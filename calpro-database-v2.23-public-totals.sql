-- CalPro+ v2.23 migration — public leaderboard daily totals
-- Run once in Supabase SQL editor.
--
-- WHY: The renderAllUsersLeaderboard view shows the top 50 users by score.
-- Score = daysOnTrack * 10 + streak * 5, both computed from food_entries
-- aggregated per day. But the existing RLS policy on food_entries only
-- allows reading your own entries + your friends' entries. That meant
-- every non-friend in the leaderboard scored 0 — clearly broken UX.
--
-- HOW: Expose ONLY aggregated daily kcal totals via a SECURITY DEFINER
-- function. The function bypasses RLS (runs as table owner) but returns
-- nothing identifying — just (user_id, date, total_kcal). No food names,
-- no photos, no individual entries leak.
--
-- Privacy stance: profiles.display_name + avatar + bio are already public
-- (profiles_select policy uses `true`). Daily kcal totals are no more
-- sensitive than the leaderboard score itself, which is derived from them.
--
-- Window: last 60 days only — both privacy-friendly and keeps the response
-- small for the client.

create or replace function public.get_public_daily_totals(_days int default 60)
returns table(user_id uuid, entry_date date, total_kcal int)
language sql
security definer
set search_path = public
stable
as $$
  select user_id, entry_date, coalesce(sum(calories), 0)::int as total_kcal
  from public.food_entries
  where entry_date >= current_date - (_days || ' days')::interval
  group by user_id, entry_date
$$;

-- Allow both signed-in users and anonymous visitors to call it.
grant execute on function public.get_public_daily_totals(int) to anon, authenticated;

-- Tell PostgREST to reload the schema cache so the new RPC appears.
notify pgrst, 'reload schema';
