-- ╔══════════════════════════════════════════════════════════╗
-- ║  CalPro — Supabase Database Setup                       ║
-- ║  วางโค้ดนี้ใน Supabase → SQL Editor แล้วกด Run         ║
-- ╚══════════════════════════════════════════════════════════╝

-- 1. PROFILES TABLE
create table if not exists public.profiles (
  id          uuid primary key references auth.users(id) on delete cascade,
  email       text,
  display_name text,
  gender      text default 'male',
  age         int,
  weight      numeric,
  height      numeric,
  goal_weight numeric,
  activity    numeric default 1.55,
  goal_type   text default 'lose',
  goal_cal    int default 1800,
  created_at  timestamptz default now()
);

-- 2. FOOD ENTRIES TABLE
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
  created_at  timestamptz default now()
);

-- 3. FRIENDS TABLE
create table if not exists public.friends (
  user_id     uuid references public.profiles(id) on delete cascade,
  friend_id   uuid references public.profiles(id) on delete cascade,
  created_at  timestamptz default now(),
  primary key (user_id, friend_id)
);

-- ─── Row Level Security (RLS) ───────────────────────────────

alter table public.profiles enable row level security;
alter table public.food_entries enable row level security;
alter table public.friends enable row level security;

-- PROFILES: ดูได้ทุกคน (เพื่อ leaderboard), แก้ได้แค่ตัวเอง
create policy "profiles_select" on public.profiles
  for select using (true);

create policy "profiles_insert" on public.profiles
  for insert with check (auth.uid() = id);

create policy "profiles_update" on public.profiles
  for update using (auth.uid() = id);

-- FOOD_ENTRIES: ดูและแก้ได้แค่ตัวเอง + เพื่อนดูได้
create policy "entries_own" on public.food_entries
  for all using (auth.uid() = user_id);

create policy "entries_friends_select" on public.food_entries
  for select using (
    exists (
      select 1 from public.friends
      where user_id = auth.uid() and friend_id = food_entries.user_id
    )
  );

-- FRIENDS: จัดการเพื่อนของตัวเอง
create policy "friends_all" on public.friends
  for all using (auth.uid() = user_id);

create policy "friends_select_reverse" on public.friends
  for select using (auth.uid() = friend_id);

-- ─── Auto-create profile on signup ──────────────────────────

create or replace function public.handle_new_user()
returns trigger language plpgsql security definer as $$
begin
  insert into public.profiles (id, email, display_name)
  values (
    new.id,
    new.email,
    coalesce(new.raw_user_meta_data->>'display_name', split_part(new.email, '@', 1))
  );
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ─── Index สำหรับ query เร็ว ─────────────────────────────────

create index if not exists idx_entries_user_date on public.food_entries(user_id, entry_date);
create index if not exists idx_entries_date on public.food_entries(entry_date);
create index if not exists idx_friends_user on public.friends(user_id);

-- ─── เสร็จแล้ว! ──────────────────────────────────────────────
-- ✅ profiles — เก็บข้อมูลผู้ใช้และเป้าหมาย
-- ✅ food_entries — บันทึกอาหารแต่ละวัน
-- ✅ friends — ความสัมพันธ์เพื่อน
-- ✅ RLS — ความปลอดภัย (แต่ละคนเข้าถึงข้อมูลตัวเองเท่านั้น)
-- ✅ Trigger — สร้าง profile อัตโนมัติเมื่อสมัครสมาชิก
