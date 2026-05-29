-- CalPro+ — seed 10 demo users onto the public leaderboard (STABLE scores)
-- Run once in Supabase SQL editor (or via Management API).
--
-- SCORING NOTE — why scores stay put:
--   Leaderboard score = daysOnTrack×10 + streak×5.
--   `streak` counts consecutive logged days ENDING TODAY, so for static seed
--   data it would collapse to 0 the next day (score would "jump down"). To
--   keep demo scores credible + steady we deliberately log NO entry for today,
--   so streak = 0 for everyone and the score = daysOnTrack×10 only — a flat,
--   non-fluctuating value. On-track days sit in the recent window so they
--   don't age out for ~7 weeks.
--
-- All demo accounts use @calpro.demo emails (see unseed script to remove).

do $$
declare
  names   text[] := array['พลอย','ต่าย','มิ้นต์','บีม','น็อต','ไอซ์','เฟิร์น','กัน','โบว์','แพร'];
  avatars text[] := array['🦊','🐱','🐰','🐻','🐼','🦁','🐯','🐨','🐮','🐭'];
  colors  text[] := array['#ff6b6b','#ffa94d','#51cf66','#74c0fc','#b197fc','#f783ac','#ffd43b','#63e6be','#495057','#ff8787'];
  bios    text[] := array[
    'กำลังลดน้ำหนัก 🔥','คุมอาหารวันละนิด','สายเฮลตี้ 🥗','เพิ่งเริ่มต้น','ออกกำลังกายทุกเช้า',
    'เป้าหมาย 60 กก.','กินคลีน 90%','พักผ่อนให้พอ 😴','ค่อยๆ ทำไป','รักสุขภาพ ❤️'];
  -- on-track day count per user → STABLE score = onTrack×10  (spread 10–40)
  ontrackArr int[] := array[4, 2, 3, 1, 4, 2, 3, 1, 3, 2];   -- 40,20,30,10,40,20,30,10,30,20
  -- extra over-goal logged days (count toward "logged" but NOT on-track) for realism
  fillerArr  int[] := array[3, 5, 2, 6, 2, 4, 1, 7, 3, 5];
  uid uuid; nm text; i int; dgoal int; wt numeric; k int; m int; j int;
begin
  for i in 1..10 loop
    uid   := gen_random_uuid();
    nm    := names[i];
    dgoal := 1600 + i*40;          -- varied daily goal 1640..2000
    wt    := 55 + i*2.5;           -- varied weight
    k     := ontrackArr[i];
    m     := fillerArr[i];

    -- 1. non-anonymous auth user (trigger auto-creates the profile)
    insert into auth.users (
      id, instance_id, aud, role, email, encrypted_password,
      email_confirmed_at, created_at, updated_at,
      raw_app_meta_data, raw_user_meta_data, is_anonymous
    ) values (
      uid, '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated',
      'demo'||i||'@calpro.demo', '',
      now(), now() - (i||' days')::interval, now(),
      '{"provider":"email","providers":["email"]}'::jsonb,
      jsonb_build_object('display_name', nm),
      false
    );

    -- 2. flesh out the auto-created profile
    update public.profiles set
      display_name = nm, avatar = avatars[i],
      gender = case when i % 2 = 0 then 'female' else 'male' end,
      age = 22 + i, weight = wt, height = 160 + i, goal_weight = wt - 4,
      activity = 1.55, goal_type = 'lose', goal_cal = dgoal,
      bio = bios[i], banner_color = colors[i], updated_at = now()
    where id = uid;

    -- 3a. on-track days at offsets 1..k (UNDER goal, never today → streak=0)
    for j in 1..k loop
      insert into public.food_entries (user_id, entry_date, food_name, calories, protein, carbs, fat, meal, client_id, updated_at)
      values (uid, (current_date - j), 'อาหารเดโม', dgoal - 180, 32, 70, 18, 'กลางวัน', 'demo-'||i||'-ok-'||j, now());
    end loop;
    -- 3b. filler over-goal days at offsets (k+1)..(k+m) — logged but not on-track
    for j in 1..m loop
      insert into public.food_entries (user_id, entry_date, food_name, calories, protein, carbs, fat, meal, client_id, updated_at)
      values (uid, (current_date - (k + j)), 'อาหารเดโม', dgoal + 280, 28, 95, 30, 'เย็น', 'demo-'||i||'-x-'||j, now());
    end loop;
  end loop;
end $$;

notify pgrst, 'reload schema';
