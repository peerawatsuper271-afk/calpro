-- ╔══════════════════════════════════════════════════════════╗
-- ║  CalPro v2.1 — Supabase Database Setup                  ║
-- ║  วางโค้ดนี้ใน Supabase → SQL Editor แล้วกด Run         ║
-- ║  ปลอดภัยที่จะ run หลายครั้ง (idempotent · ใช้ IF NOT)  ║
-- ╚══════════════════════════════════════════════════════════╝

-- ════════════════════════════════════════════════════════════
-- 1. PROFILES
-- ════════════════════════════════════════════════════════════
create table if not exists public.profiles (
  id           uuid primary key references auth.users(id) on delete cascade,
  email        text,
  display_name text,
  avatar       text,                          -- emoji หรือ data URL
  gender       text default 'male',
  age          int,
  weight       numeric,
  height       numeric,
  goal_weight  numeric,
  activity     numeric default 1.55,
  goal_type    text default 'lose',
  goal_cal     int default 1800,
  updated_at   timestamptz default now(),
  created_at   timestamptz default now()
);

-- ════════════════════════════════════════════════════════════
-- 2. FOOD ENTRIES (อาหารรายวัน)
-- ════════════════════════════════════════════════════════════
create table if not exists public.food_entries (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid references public.profiles(id) on delete cascade,
  entry_date  date not null,
  food_name   text not null,
  calories    int not null,
  protein     numeric default 0,
  carbs       numeric default 0,
  fat         numeric default 0,
  amount_g    int,
  meal        text default 'กลางวัน',
  photo       text,                            -- base64 data URL (optional)
  client_id   text,                            -- localStorage uid for sync dedup
  updated_at  timestamptz default now(),
  created_at  timestamptz default now()
);

-- ════════════════════════════════════════════════════════════
-- 3. WEIGHTS (น้ำหนักรายวัน)  ── v1.3+
-- ════════════════════════════════════════════════════════════
create table if not exists public.weights (
  user_id     uuid references public.profiles(id) on delete cascade,
  entry_date  date not null,
  kg          numeric not null,
  updated_at  timestamptz default now(),
  primary key (user_id, entry_date)
);

-- ════════════════════════════════════════════════════════════
-- 4. WATER (น้ำดื่ม cups/วัน)  ── v1.3+
-- ════════════════════════════════════════════════════════════
create table if not exists public.water (
  user_id     uuid references public.profiles(id) on delete cascade,
  entry_date  date not null,
  cups        int not null default 0,
  updated_at  timestamptz default now(),
  primary key (user_id, entry_date)
);

-- ════════════════════════════════════════════════════════════
-- 5. WORKOUTS (ออกกำลังกาย)  ── v2.0+
-- ════════════════════════════════════════════════════════════
create table if not exists public.workouts (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid references public.profiles(id) on delete cascade,
  entry_date  date not null,
  name        text not null,
  name_en     text,
  met         numeric,
  minutes     int not null,
  kcal        int not null,
  client_id   text,
  updated_at  timestamptz default now(),
  created_at  timestamptz default now()
);

-- ════════════════════════════════════════════════════════════
-- 6. BODY MEASURES (สัดส่วน)  ── v2.0+
-- ════════════════════════════════════════════════════════════
create table if not exists public.body_measures (
  user_id     uuid references public.profiles(id) on delete cascade,
  entry_date  date not null,
  waist       numeric,
  hip         numeric,
  chest       numeric,
  neck        numeric,
  bf_pct      numeric,
  updated_at  timestamptz default now(),
  primary key (user_id, entry_date)
);

-- ════════════════════════════════════════════════════════════
-- 7. FAVORITES (อาหารโปรด)  ── v1.4+
-- ════════════════════════════════════════════════════════════
create table if not exists public.favorites (
  user_id     uuid references public.profiles(id) on delete cascade,
  food_name   text not null,
  added_at    timestamptz default now(),
  primary key (user_id, food_name)
);

-- ════════════════════════════════════════════════════════════
-- 8. CUSTOM FOODS (อาหารผู้ใช้)  ── v1.4+
-- ════════════════════════════════════════════════════════════
create table if not exists public.custom_foods (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid references public.profiles(id) on delete cascade,
  name        text not null,
  name_en     text default '',
  calories    int not null,
  protein     numeric default 0,
  carbs       numeric default 0,
  fat         numeric default 0,
  amount_g    int,
  updated_at  timestamptz default now()
);

-- ════════════════════════════════════════════════════════════
-- 9. FRIENDS
-- ════════════════════════════════════════════════════════════
create table if not exists public.friends (
  user_id    uuid references public.profiles(id) on delete cascade,
  friend_id  uuid references public.profiles(id) on delete cascade,
  created_at timestamptz default now(),
  primary key (user_id, friend_id)
);

-- ════════════════════════════════════════════════════════════
-- ROW LEVEL SECURITY
-- ════════════════════════════════════════════════════════════
alter table public.profiles      enable row level security;
alter table public.food_entries  enable row level security;
alter table public.weights       enable row level security;
alter table public.water         enable row level security;
alter table public.workouts      enable row level security;
alter table public.body_measures enable row level security;
alter table public.favorites     enable row level security;
alter table public.custom_foods  enable row level security;
alter table public.friends       enable row level security;

-- ─── PROFILES: ทุกคนดูได้ (leaderboard), แก้ตัวเองเท่านั้น ────
drop policy if exists "profiles_select" on public.profiles;
create policy "profiles_select" on public.profiles for select using (true);

drop policy if exists "profiles_insert" on public.profiles;
create policy "profiles_insert" on public.profiles for insert with check (auth.uid() = id);

drop policy if exists "profiles_update" on public.profiles;
create policy "profiles_update" on public.profiles for update using (auth.uid() = id);

-- ─── ตารางข้อมูลส่วนตัว (entries/weights/water/workouts/measures/custom/favorites) ───
-- ดูและแก้ได้แค่ตัวเอง · เพื่อนดูได้เฉพาะ food_entries
do $$
declare
  tbl text;
begin
  for tbl in select unnest(array['food_entries','weights','water','workouts','body_measures','favorites','custom_foods'])
  loop
    execute format('drop policy if exists "%s_own_all" on public.%I', tbl, tbl);
    execute format('create policy "%s_own_all" on public.%I for all using (auth.uid() = user_id)', tbl, tbl);
  end loop;
end$$;

-- เพื่อนดู food_entries ได้
drop policy if exists "entries_friends_select" on public.food_entries;
create policy "entries_friends_select" on public.food_entries
  for select using (
    exists (
      select 1 from public.friends
      where user_id = auth.uid() and friend_id = food_entries.user_id
    )
  );

-- ─── FRIENDS ───
drop policy if exists "friends_all" on public.friends;
create policy "friends_all" on public.friends for all using (auth.uid() = user_id);

drop policy if exists "friends_select_reverse" on public.friends;
create policy "friends_select_reverse" on public.friends for select using (auth.uid() = friend_id);

-- ════════════════════════════════════════════════════════════
-- AUTO-CREATE PROFILE ON SIGNUP
-- ════════════════════════════════════════════════════════════
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer as $$
begin
  insert into public.profiles (id, email, display_name)
  values (
    new.id,
    new.email,
    coalesce(new.raw_user_meta_data->>'display_name', split_part(new.email, '@', 1))
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ════════════════════════════════════════════════════════════
-- INDEXES
-- ════════════════════════════════════════════════════════════
create index if not exists idx_entries_user_date  on public.food_entries(user_id, entry_date);
create index if not exists idx_weights_user_date  on public.weights(user_id, entry_date);
create index if not exists idx_water_user_date    on public.water(user_id, entry_date);
create index if not exists idx_workouts_user_date on public.workouts(user_id, entry_date);
create index if not exists idx_measures_user_date on public.body_measures(user_id, entry_date);
create index if not exists idx_friends_user       on public.friends(user_id);

-- ════════════════════════════════════════════════════════════
-- ✅ เสร็จแล้ว
-- ════════════════════════════════════════════════════════════
-- ตาราง:
--   profiles · food_entries · weights · water · workouts
--   body_measures · favorites · custom_foods · friends
-- RLS: ทุกตารางเปิด, policies ตั้งให้ user เข้าถึงเฉพาะของตัวเอง
-- Auto profile creation on signup via trigger
