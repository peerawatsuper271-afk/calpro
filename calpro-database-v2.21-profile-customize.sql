-- CalPro+ v2.21 migration — Steam-style profile customization
-- Run once in Supabase SQL editor.
--
-- Adds bio + banner_color + level_title to profiles so users can
-- customize their public profile card (and friends can see it).
-- Everything is additive · safe to re-run · no data loss.

-- Bio text (≤280 chars enforced client-side · DB allows TEXT)
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS bio TEXT;

-- Hex color or gradient name for the banner background
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS banner_color TEXT DEFAULT '#ff6b6b';

-- Custom title displayed under display name (e.g. "🔥 100-day warrior")
-- Optional · auto-computed client-side if NULL
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS level_title TEXT;

-- Tell PostgREST to reload the schema cache so the new columns appear
NOTIFY pgrst, 'reload schema';
