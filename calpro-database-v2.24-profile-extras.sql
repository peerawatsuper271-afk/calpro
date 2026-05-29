-- CalPro+ v2.24 migration — banner image + persisted badges
-- Run once in Supabase SQL editor (or via Management API).
--
-- WHY:
-- - banner_image was local-only because the original profile sync stripped
--   it (`delete p.banner_image`). That meant friends couldn't see your
--   uploaded banner, only your color. Adding the column + flipping the
--   sync exclusion enables cross-device + cross-friend visibility.
-- - persisted_badges currently live in `localStorage['cp_earned_badges']`
--   only. Friends can't see them, and a fresh device starts from zero
--   until enough food is logged to re-earn the live conditions. JSONB
--   array column lets us push/pull the snapshot.
--
-- Both columns are additive and safe to re-run.

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS banner_image TEXT;

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS persisted_badges JSONB DEFAULT '[]'::jsonb;

-- Tell PostgREST to reload the schema cache so the new columns appear.
NOTIFY pgrst, 'reload schema';
