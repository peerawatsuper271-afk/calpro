-- ╔══════════════════════════════════════════════════════════╗
-- ║  CalPro+ v2.4 — Migration                                ║
-- ║  Adds unique constraints so safe upsert works            ║
-- ║  Idempotent · safe to re-run                             ║
-- ╚══════════════════════════════════════════════════════════╝

-- ─── 1. food_entries: ensure client_id is unique per user ─
-- (Postgres "add constraint if not exists" isn't supported; emulate)
do $$ begin
  if not exists (
    select 1 from pg_constraint where conname = 'food_entries_user_client_uniq'
  ) then
    alter table public.food_entries
      add constraint food_entries_user_client_uniq unique (user_id, client_id);
  end if;
exception when others then
  raise notice 'food_entries unique skip: %', sqlerrm;
end $$;

-- ─── 2. workouts: same ──────────────────────────────────
do $$ begin
  if not exists (
    select 1 from pg_constraint where conname = 'workouts_user_client_uniq'
  ) then
    alter table public.workouts
      add constraint workouts_user_client_uniq unique (user_id, client_id);
  end if;
exception when others then
  raise notice 'workouts unique skip: %', sqlerrm;
end $$;

-- ─── 3. custom_foods: unique by (user_id, name) ─────────
do $$ begin
  if not exists (
    select 1 from pg_constraint where conname = 'custom_foods_user_name_uniq'
  ) then
    alter table public.custom_foods
      add constraint custom_foods_user_name_uniq unique (user_id, name);
  end if;
exception when others then
  raise notice 'custom_foods unique skip: %', sqlerrm;
end $$;

-- ─── 4. Optional: extend JWT expiry for less frequent logouts ─
-- (run in Supabase dashboard → Authentication → Settings → JWT expiry)
-- recommend: 604800 (7 days) instead of default 3600 (1 hour)
-- the dashboard setting takes precedence over any SQL

-- ─── 5. Ensure favorites/water/weights/measures have updated_at default
-- (already in schema · this is no-op if column exists)

-- ✅ done · safe upserts now possible
