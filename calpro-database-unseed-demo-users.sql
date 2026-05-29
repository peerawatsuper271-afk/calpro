-- CalPro+ — remove the 10 demo leaderboard users
-- Deleting from auth.users cascades to public.profiles (FK ON DELETE CASCADE)
-- which cascades to food_entries/weights/etc. One statement cleans everything.

delete from auth.users where email like 'demo%@calpro.demo';

notify pgrst, 'reload schema';
