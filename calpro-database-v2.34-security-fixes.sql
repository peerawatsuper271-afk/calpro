-- ╔══════════════════════════════════════════════════════════╗
-- ║  CalPro+ v2.34 — Security hardening migration             ║
-- ║  Run once in Supabase → SQL Editor. Idempotent.          ║
-- ╚══════════════════════════════════════════════════════════╝
--
-- Fixes from the v2.33 security audit:
--   #2  profiles.email was world-readable (profiles_select = `true`), so the
--       public anon key could dump / enumerate EVERY user's email via
--       GET /rest/v1/profiles?select=email. Lock the column down and move the
--       "find friend by email" feature behind a SECURITY DEFINER RPC that
--       never returns anyone's email.
--   #3  Friendship was one-sided: anyone could INSERT a friends row pointing at
--       a victim and immediately read that victim's private food_entries.
--       Require a MUTUAL friendship before raw entries are shared.
--   #4  ai_usage (the AI rate-limit counter) was client-writable, so a user
--       could reset their own count to 0 and call the paid Gemini proxy without
--       limit. Make the counter server-only (Edge Function / service role) and
--       increment it atomically to also close a TOCTOU race.


-- ════════════════════════════════════════════════════════════
-- #2 — Hide profiles.email from the REST API (column-level grants)
-- ════════════════════════════════════════════════════════════
-- RLS is row-level and can't hide a single column, so we use column GRANTs.
-- Revoking the blanket SELECT then re-granting every column EXCEPT email means
-- `select=*` still works (PostgREST expands * to the granted columns) but
-- `select=email` is rejected. INSERT/UPDATE privileges are untouched, so the
-- owner can still write their email on sync (the client upsert uses
-- return=minimal, so it never needs to read the column back).
revoke select on public.profiles from anon, authenticated;
grant select (
  id, display_name, avatar, gender, age, weight, height, goal_weight,
  activity, goal_type, goal_cal, bio, banner_color, level_title,
  banner_image, persisted_badges, updated_at, created_at
) on public.profiles to anon, authenticated;

-- "Add friend" search — matches display_name (ILIKE) or email (EXACT) but only
-- ever returns id / display_name / avatar. Exact-match on email means it can be
-- used to confirm a known address but NOT to bulk-enumerate the user base, and
-- the email itself is never echoed back. SECURITY DEFINER so it can read
-- auth.users.email even though the caller can't.
create or replace function public.search_profiles(_q text)
returns table(id uuid, display_name text, avatar text)
language sql
stable
security definer
set search_path = public
as $$
  select p.id, p.display_name, p.avatar
  from public.profiles p
  join auth.users u on u.id = p.id
  where coalesce(u.is_anonymous, false) = false
    and coalesce(btrim(p.display_name), '') <> ''
    and (
      lower(u.email) = lower(btrim(_q))
      or p.display_name ilike '%' || replace(replace(_q, '%', ''), ',', '') || '%'
    )
  limit 20
$$;

-- authenticated only (NOT anon): friend-search lives behind a real-user gate
-- in the app, and exact-email matching shouldn't be an open, anonymous
-- "is this address registered?" oracle.
revoke all on function public.search_profiles(text) from public, anon;
grant execute on function public.search_profiles(text) to authenticated;


-- ════════════════════════════════════════════════════════════
-- #3 — Require a MUTUAL friendship to read raw food_entries
-- ════════════════════════════════════════════════════════════
-- Old policy: A could read B's entries as soon as A inserted (A → B). Now both
-- (A → B) AND (B → A) rows must exist. Non-mutual viewers still see only the
-- aggregated public daily totals (get_public_daily_totals), exactly like any
-- other non-friend — no private food names / photos / per-entry rows leak.
drop policy if exists "entries_friends_select" on public.food_entries;
create policy "entries_friends_select" on public.food_entries
  for select using (
    exists (
      select 1 from public.friends f
      where f.user_id = auth.uid()
        and f.friend_id = food_entries.user_id
    )
    and exists (
      select 1 from public.friends f2
      where f2.user_id = food_entries.user_id
        and f2.friend_id = auth.uid()
    )
  );


-- ════════════════════════════════════════════════════════════
-- #4 — ai_usage: server-only writes + atomic increment
-- ════════════════════════════════════════════════════════════
-- Drop the self INSERT/UPDATE policies so a user can no longer reset their own
-- counter through the REST API. Reads stay allowed (the app shows remaining
-- quota). The Edge Function now writes via the service role / the RPC below.
drop policy if exists "ai_usage_self_upsert" on public.ai_usage;
drop policy if exists "ai_usage_self_update" on public.ai_usage;
-- (ai_usage_self_select is kept — read-only is fine.)

-- Atomic "use one credit". The single UPSERT closes the read-then-write race
-- the Edge Function had (two parallel requests could both read N and write N+1).
-- SECURITY DEFINER + granted to service_role only: regular users can't call it
-- to bump an arbitrary user. The Edge Function passes the JWT-verified user id.
create or replace function public.increment_ai_usage(_user uuid)
returns int
language sql
security definer
set search_path = public
as $$
  insert into public.ai_usage (user_id, day, count, updated_at)
  values (_user, current_date, 1, now())
  on conflict (user_id, day)
    do update set count = ai_usage.count + 1, updated_at = now()
  returning count;
$$;

revoke all on function public.increment_ai_usage(uuid) from public, anon, authenticated;
grant execute on function public.increment_ai_usage(uuid) to service_role;


-- Reload PostgREST schema cache so the new RPCs + grants take effect immediately.
notify pgrst, 'reload schema';
