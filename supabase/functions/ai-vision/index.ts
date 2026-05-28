// CalPro+ AI Vision Proxy — forwards food-photo requests to Gemini.
// The Gemini API key lives ONLY in Supabase secrets (GEMINI_API_KEY).
// The browser never sees it; the source code never embeds it.
//
// Deploy:
//   supabase functions deploy ai-vision --no-verify-jwt
//     (we verify the JWT manually below to allow anonymous sessions)
//   supabase secrets set GEMINI_API_KEY=AIza...
//
// Run the migration once before first use:
//   psql -f calpro-database-v2.19-ai-usage.sql

// Deno.serve is built-in since Deno 1.40 — no std/http import needed.
// supabase-js pinned to @2 wildcard so we float up minor/patch automatically.
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const GEMINI_API_KEY = Deno.env.get("GEMINI_API_KEY") || "";
const GEMINI_MODEL = Deno.env.get("GEMINI_MODEL") || "gemini-2.5-flash";
const DAILY_LIMIT = parseInt(Deno.env.get("AI_DAILY_LIMIT") || "20", 10);
const SUPABASE_URL = Deno.env.get("SUPABASE_URL") || "";
const SUPABASE_ANON_KEY = Deno.env.get("SUPABASE_ANON_KEY") || "";

// CORS — accept any origin (the app is a PWA + APK; origins vary).
// If you want to lock this down, swap "*" for your Pages URL.
const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

const json = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, "content-type": "application/json" },
  });

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });
  if (req.method !== "POST") return json({ error: "method_not_allowed" }, 405);

  if (!GEMINI_API_KEY) return json({ error: "server_misconfigured", detail: "GEMINI_API_KEY not set" }, 500);

  // 1) Auth — verify the user's Supabase JWT (anonymous sessions OK).
  const authHeader = req.headers.get("authorization") || "";
  const jwt = authHeader.replace(/^Bearer\s+/i, "");
  if (!jwt) return json({ error: "unauthenticated" }, 401);

  const sb = createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
    global: { headers: { Authorization: `Bearer ${jwt}` } },
  });
  const { data: userRes, error: userErr } = await sb.auth.getUser(jwt);
  if (userErr || !userRes?.user) return json({ error: "invalid_jwt", detail: userErr?.message }, 401);
  const userId = userRes.user.id;

  // 2) Rate limit — UPSERT today's count, reject if over.
  const today = new Date().toISOString().slice(0, 10); // YYYY-MM-DD
  const { data: usageRows, error: usageErr } = await sb
    .from("ai_usage")
    .select("count")
    .eq("user_id", userId)
    .eq("day", today)
    .maybeSingle();
  if (usageErr) return json({ error: "rate_check_failed", detail: usageErr.message }, 500);

  const usedSoFar = usageRows?.count ?? 0;
  if (usedSoFar >= DAILY_LIMIT) {
    return json({ error: "rate_limited", used: usedSoFar, limit: DAILY_LIMIT }, 429);
  }

  // 3) Parse body — expect { image: base64Jpeg, prompt: string }
  let body: { image?: string; prompt?: string };
  try { body = await req.json(); } catch { return json({ error: "bad_json" }, 400); }
  const imageB64 = body.image;
  const prompt = body.prompt || "Analyze this food photo and return JSON.";
  if (!imageB64 || imageB64.length < 100) return json({ error: "missing_image" }, 400);
  if (imageB64.length > 5_000_000) return json({ error: "image_too_large" }, 413);

  // 4) Forward to Gemini.
  const url = `https://generativelanguage.googleapis.com/v1beta/models/${GEMINI_MODEL}:generateContent?key=${encodeURIComponent(GEMINI_API_KEY)}`;
  const upstream = await fetch(url, {
    method: "POST",
    headers: { "content-type": "application/json" },
    body: JSON.stringify({
      contents: [{
        parts: [
          { inline_data: { mime_type: "image/jpeg", data: imageB64 } },
          { text: prompt },
        ],
      }],
    }),
  });
  if (!upstream.ok) {
    const text = await upstream.text();
    return json({ error: "upstream_failed", status: upstream.status, detail: text.slice(0, 300) }, 502);
  }
  const result = await upstream.json();
  const text = result?.candidates?.[0]?.content?.parts?.[0]?.text ?? "";

  // 5) Increment usage AFTER successful upstream (don't charge users for failures).
  await sb.from("ai_usage").upsert(
    { user_id: userId, day: today, count: usedSoFar + 1, updated_at: new Date().toISOString() },
    { onConflict: "user_id,day" },
  );

  return json({ text, used: usedSoFar + 1, limit: DAILY_LIMIT });
});
