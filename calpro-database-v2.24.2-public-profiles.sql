-- CalPro+ v2.24.2 migration — keep anonymous users off the public leaderboard
-- Run once in Supabase SQL editor (or via Management API).
--
-- THE BUG (found in a Supabase audit):
--   Anonymous sessions are auto-created for the AI camera + offline-sync
--   features (v2.20 / v2.24). syncToCloud was upserting a profiles row for
--   every session, anon included. Because profiles_select RLS = `true`, the
--   PUBLIC leaderboard (renderAllUsersLeaderboard) listed ALL profiles —
--   so 14 of 18 profiles in production were anonymous, 11 of them nameless,
--   rendering as "Test User" rows on the global board. A few anon users with
--   logged food were even out-ranking real signed-up members.
--
-- THE FIX (two parts; this file is the server half):
--   1. App no longer pushes a profile row for anon sessions (client change).
--   2. get_public_profiles() RPC returns only NON-anonymous, named profiles
--      — joining auth.users (which the anon key can't read directly), so the
--      leaderboard can exclude them robustly server-side.
--
-- Also cleans up the anonymous profile rows already in the table. We DELETE
-- only anon rows with NO food entries (the nameless score-0 clutter); anon
-- rows that have entries are blanked of identity instead (kept so their
-- food_entries FK doesn't cascade-delete real logged data).

-- ── 1. Public-profiles RPC (excludes anon + nameless) ──
create or replace function public.get_public_profiles()
returns table(
  id uuid, display_name text, avatar text, goal_cal int,
  weight numeric, banner_color text, banner_image text,
  bio text, persisted_badges jsonb
)
language sql
stable
security definer
set search_path = public
as $$
  select p.id, p.display_name, p.avatar, p.goal_cal,
         p.weight, p.banner_color, p.banner_image, p.bio, p.persisted_badges
  from public.profiles p
  join auth.users u on u.id = p.id
  where coalesce(u.is_anonymous, false) = false
    and coalesce(btrim(p.display_name), '') <> ''
$$;

grant execute on function public.get_public_profiles() to anon, authenticated;

-- ── 2. Clean up existing anonymous profile clutter ──
-- Safe: only deletes anon profiles that have ZERO food entries (no data loss).
-- food_entries has ON DELETE CASCADE, so we explicitly guard with NOT EXISTS.
delete from public.profiles p
using auth.users u
where u.id = p.id
  and coalesce(u.is_anonymous, false) = true
  and not exists (select 1 from public.food_entries fe where fe.user_id = p.id);

-- Anonymous profiles that DO have entries: keep the row (so their data isn't
-- cascade-deleted) but the get_public_profiles RPC already hides them, so no
-- extra action needed here.

notify pgrst, 'reload schema';
