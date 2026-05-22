-- ╔══════════════════════════════════════════════════════════╗
-- ║  CalPro+ v2.7 — Migration (idempotent · safe to re-run) ║
-- ║                                                          ║
-- ║  ❗ จำเป็นต้อง run อันนี้ในกรณีที่ schema ของคุณถูก     ║
-- ║     สร้างจาก calpro-database.sql รุ่นเก่ากว่า v2.1       ║
-- ║                                                          ║
-- ║  Diagnose ในแอปแจ้งว่า:                                  ║
-- ║   "Could not find the 'client_id' column" → run this    ║
-- ╚══════════════════════════════════════════════════════════╝

-- ════════════════════════════════════════════════════════════
-- 1. ADD MISSING COLUMNS to existing tables
-- ════════════════════════════════════════════════════════════

-- profiles
alter table public.profiles add column if not exists avatar text;
alter table public.profiles add column if not exists updated_at timestamptz default now();

-- food_entries
alter table public.food_entries add column if not exists client_id text;
alter table public.food_entries add column if not exists photo text;
alter table public.food_entries add column if not exists updated_at timestamptz default now();

-- workouts
alter table public.workouts add column if not exists client_id text;
alter table public.workouts add column if not exists name_en text;
alter table public.workouts add column if not exists met numeric;
alter table public.workouts add column if not exists updated_at timestamptz default now();

-- weights
alter table public.weights add column if not exists updated_at timestamptz default now();

-- water
alter table public.water add column if not exists updated_at timestamptz default now();

-- body_measures
alter table public.body_measures add column if not exists updated_at timestamptz default now();

-- custom_foods
alter table public.custom_foods add column if not exists name_en text default '';
alter table public.custom_foods add column if not exists updated_at timestamptz default now();


-- ════════════════════════════════════════════════════════════
-- 2. ADD UNIQUE CONSTRAINTS (for upsert onConflict)
-- ════════════════════════════════════════════════════════════

do $$ begin
  if not exists (select 1 from pg_constraint where conname = 'food_entries_user_client_uniq') then
    alter table public.food_entries
      add constraint food_entries_user_client_uniq unique (user_id, client_id);
  end if;
exception when others then
  raise notice 'food_entries unique constraint skip: %', sqlerrm;
end $$;

do $$ begin
  if not exists (select 1 from pg_constraint where conname = 'workouts_user_client_uniq') then
    alter table public.workouts
      add constraint workouts_user_client_uniq unique (user_id, client_id);
  end if;
exception when others then
  raise notice 'workouts unique constraint skip: %', sqlerrm;
end $$;

do $$ begin
  if not exists (select 1 from pg_constraint where conname = 'custom_foods_user_name_uniq') then
    alter table public.custom_foods
      add constraint custom_foods_user_name_uniq unique (user_id, name);
  end if;
exception when others then
  raise notice 'custom_foods unique constraint skip: %', sqlerrm;
end $$;


-- ════════════════════════════════════════════════════════════
-- 3. INDEXES (faster lookups)
-- ════════════════════════════════════════════════════════════

create index if not exists idx_food_entries_user_client on public.food_entries(user_id, client_id);
create index if not exists idx_workouts_user_client on public.workouts(user_id, client_id);
create index if not exists idx_custom_foods_user_name on public.custom_foods(user_id, name);


-- ════════════════════════════════════════════════════════════
-- 4. RELOAD PostgREST SCHEMA CACHE
-- ════════════════════════════════════════════════════════════
-- จำเป็น — ไม่งั้น Supabase API ยังไม่เห็น columns ใหม่
notify pgrst, 'reload schema';


-- ════════════════════════════════════════════════════════════
-- ✅ DONE
-- ════════════════════════════════════════════════════════════
-- ตรวจสอบที่แอป:
-- 1. กลับมาที่ Settings → Cloud Sync → 🔍 ตรวจสอบ
-- 2. ควรเห็น "upsert constraint: ✓"
-- 3. ทุก table มี updated_at + client_id (สำหรับ food_entries/workouts)
-- 4. กด "ซิงค์เลย" → ข้อมูลจะถูก push ขึ้น cloud
