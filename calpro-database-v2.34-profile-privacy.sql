-- ╔══════════════════════════════════════════════════════════╗
-- ║  CalPro+ v2.34 — Profiles privacy hardening (SECURITY)     ║
-- ║  Run once in Supabase → SQL Editor.                        ║
-- ╚══════════════════════════════════════════════════════════╝
--
-- THE VULNERABILITY (found in a security audit):
--   The `profiles` SELECT policy was `using (true)` — i.e. world-readable.
--   Because the anon API key is shipped in the client (by design), ANYONE
--   could query the table directly, e.g.:
--       supabase.from('profiles').select('email,weight,height,age')
--   and bulk-harvest every user's e-mail + body stats (PII leak). The in-app
--   friend search also concatenated the query into a PostgREST `.or()` filter,
--   allowing filter injection (e.g. `,id.neq.0`) to dump all rows.
--
-- THE FIX:
--   1. Lock `profiles` SELECT to the OWNER only.
--   2. Expose only SAFE, shareable columns to others through SECURITY DEFINER
--      RPCs (no email / age / height / goal_weight / activity ever leave the DB):
--        • get_public_profiles()        — the leaderboard (already added v2.24.2)
--        • get_public_profile(_id)       — single friend-profile view (NEW)
--        • search_profiles(_q)           — add-friend search, parameterized (NEW)
--   The client (v2.34+) calls these RPCs first and only falls back to a direct
--   select on older databases, so running this migration is safe + non-breaking.

-- ── 1. profiles SELECT → owner only ───────────────────────────────────────
drop policy if exists "profiles_select" on public.profiles;
create policy "profiles_select" on public.profiles
  for select using (auth.uid() = id);
-- (insert/update policies from the base schema already restrict to auth.uid()=id)

-- ── 2. Single public profile (friend-profile modal) — safe columns only ───
create or replace function public.get_public_profile(_id uuid)
returns table(
  id uuid, display_name text, avatar text, goal_cal int, goal_type text,
  weight numeric, bio text, banner_color text, banner_image text, persisted_badges jsonb
)
language sql stable security definer set search_path = public as $$
  select p.id, p.display_name, p.avatar, p.goal_cal, p.goal_type,
         p.weight, p.bio, p.banner_color, p.banner_image, p.persisted_badges
  from public.profiles p
  where p.id = _id
$$;
grant execute on function public.get_public_profile(uuid) to anon, authenticated;

-- ── 3. Friend search — server-side match, returns NO email / PII ──────────
create or replace function public.search_profiles(_q text)
returns table(id uuid, display_name text, avatar text)
language sql stable security definer set search_path = public as $$
  select p.id, p.display_name, p.avatar
  from public.profiles p
  join auth.users u on u.id = p.id
  where coalesce(u.is_anonymous, false) = false
    and coalesce(btrim(p.display_name), '') <> ''
    and (
      lower(p.email) = lower(btrim(_q))                                  -- exact e-mail
      or p.display_name ilike '%' || replace(replace(_q, '%', ''), ',', '') || '%'  -- name contains
    )
  limit 20
$$;
grant execute on function public.search_profiles(text) to anon, authenticated;

-- ── 4. Stop raw cross-user food_entries access (food names + meal PHOTOS) ──
--   Vulnerability: `entries_friends_select` let you read a user's ENTIRE
--   food_entries row (food_name + base64 photo) for anyone you'd added as a
--   friend — and friending is one-way (no accept), so any authenticated user
--   could `insert (me, victim_id)` then read the victim's full food diary +
--   meal photos. The friends leaderboard + friend-profile only need aggregate
--   daily kcal (already exposed safely via get_public_daily_totals), so we drop
--   this policy entirely → food_entries becomes strictly owner-only.
--   (The app v2.34+ scores friends from get_public_daily_totals instead.)
drop policy if exists "entries_friends_select" on public.food_entries;

-- ── 5. AI quota can no longer be reset from the client ────────────────────
--   Vulnerability: ai_usage had FOR INSERT/UPDATE policies for the owner, and
--   the Edge Function wrote it with the USER's JWT — so a user could call
--   ai_usage.update({count:0}) directly and reset their daily AI limit
--   (unlimited free calls on the shared Gemini key = cost abuse).
--   Fix: only the server (service-role) may write ai_usage; users keep SELECT
--   (to see "X left"). The Edge Function v2.34+ uses the service-role key.
--   ⚠ DEPLOY ORDER: deploy the updated ai-vision function (with the
--   SUPABASE_SERVICE_ROLE_KEY secret set) BEFORE running this, otherwise the
--   server upsert would be blocked and the quota would stop incrementing.
drop policy if exists "ai_usage_self_upsert" on public.ai_usage;
drop policy if exists "ai_usage_self_update" on public.ai_usage;
-- (ai_usage_self_select stays so the app can still show remaining count.)

notify pgrst, 'reload schema';

-- ✅ After running: email / age / height / goal_weight / activity are no longer
--    readable by anyone but the owner. Leaderboard, friend search and the
--    friend-profile view keep working via the safe RPCs above.
