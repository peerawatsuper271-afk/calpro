-- CalPro+ — seed 10 demo users onto the public leaderboard
-- Run once in Supabase SQL editor (or via Management API).
--
-- Creates 10 non-anonymous auth.users (so get_public_profiles shows them),
-- lets the on_auth_user_created trigger create their profiles, then fills in
-- avatar/goal + logs food entries over the past weeks so each has a real
-- streak + "days on track" → a spread of leaderboard scores.
--
-- All demo accounts use @calpro.demo emails so they're easy to remove later
-- (see calpro-database-unseed-demo-users.sql).

do $$
declare
  names   text[]  := array['พลอย','ต่าย','มิ้นต์','บีม','น็อต','ไอซ์','เฟิร์น','กัน','โบว์','แพร'];
  avatars text[]  := array['🦊','🐱','🐰','🐻','🐼','🦁','🐯','🐨','🐮','🐭'];
  -- consecutive days each logs (drives streak + on-track → score = 15×days)
  daysArr int[]   := array[23, 20, 18, 15, 13, 11, 9, 7, 5, 3];
  bios    text[]  := array[
    'กำลังลดน้ำหนัก 🔥','คุมอาหารวันละนิด','สายเฮลตี้ 🥗','เริ่มต้นวันนี้','ออกกำลังกายทุกเช้า',
    'เป้าหมาย 60 กก.','กินคลีน 90%','พักผ่อนให้พอ 😴','ค่อยๆทำไป','รักสุขภาพ ❤️'];
  uid   uuid;
  nm    text;
  i     int;
  dgoal int;
  wt    numeric;
  ndays int;
  j     int;
  dkcal int;
begin
  for i in 1..10 loop
    uid   := gen_random_uuid();
    nm    := names[i];
    dgoal := 1600 + i*40;                 -- varied daily goals 1640..2000
    wt    := 55 + i*2.5;                   -- varied weights
    ndays := daysArr[i];

    -- 1. auth user (non-anonymous). Trigger auto-creates the profile row.
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

    -- 2. flesh out the profile the trigger just made
    update public.profiles set
      display_name = nm,
      avatar       = avatars[i],
      gender       = case when i % 2 = 0 then 'female' else 'male' end,
      age          = 22 + i,
      weight       = wt,
      height       = 160 + i,
      goal_weight  = wt - 4,
      activity     = 1.55,
      goal_type    = 'lose',
      goal_cal     = dgoal,
      bio          = bios[i],
      banner_color = (array['#ff6b6b','#ffa94d','#51cf66','#74c0fc','#b197fc','#f783ac','#ffd43b','#63e6be','#495057','#ff8787'])[i],
      updated_at   = now()
    where id = uid;

    -- 3. log one "on track" meal per day for the last ndays days (incl. today)
    for j in 0..(ndays-1) loop
      dkcal := dgoal - 150 - (j % 5)*30;   -- comfortably under goal → on-track
      insert into public.food_entries (user_id, entry_date, food_name, calories, protein, carbs, fat, meal, client_id, updated_at)
      values (
        uid, (current_date - j),
        'อาหารเดโม', dkcal, 30, 70, 18, 'กลางวัน',
        'demo-'||i||'-'||j, now()
      );
    end loop;
  end loop;
end $$;

notify pgrst, 'reload schema';
