-- CalPro+ v2.19 migration — AI usage rate-limit table
-- Run once: psql "$DATABASE_URL" -f calpro-database-v2.19-ai-usage.sql
-- Or paste into Supabase SQL editor and Run.
--
-- This table is read + written by the ai-vision Edge Function to enforce
-- a per-user daily quota on AI photo analyses. Users see their remaining
-- count in the app.

CREATE TABLE IF NOT EXISTS public.ai_usage (
  user_id    uuid        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  day        date        NOT NULL,
  count      int         NOT NULL DEFAULT 0,
  updated_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, day)
);

-- Tell PostgREST about the schema change so the API picks it up immediately.
NOTIFY pgrst, 'reload schema';

-- Row-Level Security: users can read + write only their own usage rows.
-- The Edge Function uses the user's JWT so RLS applies as expected.
ALTER TABLE public.ai_usage ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "ai_usage_self_select" ON public.ai_usage;
CREATE POLICY "ai_usage_self_select" ON public.ai_usage
  FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "ai_usage_self_upsert" ON public.ai_usage;
CREATE POLICY "ai_usage_self_upsert" ON public.ai_usage
  FOR INSERT WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "ai_usage_self_update" ON public.ai_usage;
CREATE POLICY "ai_usage_self_update" ON public.ai_usage
  FOR UPDATE USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

-- Optional: index on day to speed up "today's row" lookups (the PK already
-- covers (user_id, day) so a separate index isn't strictly needed, but
-- range queries by day for analytics would benefit).
CREATE INDEX IF NOT EXISTS ai_usage_day_idx ON public.ai_usage (day);

-- Optional: a tiny cleanup job — drop rows older than 90 days. Run as needed,
-- or set up a pg_cron schedule. Safe to skip — table will stay small.
-- DELETE FROM public.ai_usage WHERE day < CURRENT_DATE - INTERVAL '90 days';

NOTIFY pgrst, 'reload schema';
