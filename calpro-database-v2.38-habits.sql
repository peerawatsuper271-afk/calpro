-- CalPro+ v2.38 migration — Daily Habits cloud sync (Epic B)
-- Run once: paste into the Supabase SQL editor and Run
--           (or psql "$DATABASE_URL" -f calpro-database-v2.38-habits.sql)
--
-- Stores the Today-page "นิสัยประจำวัน" card per user per day:
--   • sleep  — hours slept (0–14, in 0.5 steps)
--   • sleepq — sleep-quality emoji index 0..3 (nullable = not rated)
--   • supps  — array of supplement ids taken that day, e.g. ["multi","omega3"]
--   • steps  — manual step count for the day (0–100,000)
--
-- Mirrors the existing date-keyed tables (water / weights / body_measures):
-- composite PK (user_id, entry_date) → the app pushes with a pure upsert
-- on conflict (user_id, entry_date) and pulls with a cloud-wins-by-date merge.
-- Idempotent + self-healing: safe to re-run; ADD COLUMN IF NOT EXISTS repairs a
-- partially-created table from an older attempt.

-- ── 1. Table ────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.habits (
  user_id     uuid        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  entry_date  date        NOT NULL,
  sleep       numeric     NOT NULL DEFAULT 0,
  sleepq      smallint,
  supps       jsonb       NOT NULL DEFAULT '[]'::jsonb,
  steps       integer     NOT NULL DEFAULT 0,
  updated_at  timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, entry_date)
);

-- ── 2. Self-heal: add any missing columns if the table pre-existed ───────────
ALTER TABLE public.habits ADD COLUMN IF NOT EXISTS sleep      numeric     NOT NULL DEFAULT 0;
ALTER TABLE public.habits ADD COLUMN IF NOT EXISTS sleepq     smallint;
ALTER TABLE public.habits ADD COLUMN IF NOT EXISTS supps      jsonb       NOT NULL DEFAULT '[]'::jsonb;
ALTER TABLE public.habits ADD COLUMN IF NOT EXISTS steps      integer     NOT NULL DEFAULT 0;
ALTER TABLE public.habits ADD COLUMN IF NOT EXISTS updated_at timestamptz NOT NULL DEFAULT now();

-- ── 3. Row-Level Security: each user sees + edits only their own rows ─────────
ALTER TABLE public.habits ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "habits_own_all" ON public.habits;
CREATE POLICY "habits_own_all" ON public.habits
  FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

-- ── 4. Tell PostgREST to reload the schema cache immediately ─────────────────
NOTIFY pgrst, 'reload schema';
