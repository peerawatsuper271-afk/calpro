# Deploying the AI Vision Proxy

ต้องทำ 4 ขั้นตอนนี้ครั้งเดียวก่อนที่ผู้ใช้จะใช้ AI feature ผ่าน proxy ได้

## 1) ขอ Gemini API key (ฟรี)

1. เปิด **https://aistudio.google.com/app/apikey**
2. ล็อกอินด้วย Google account
3. กด **"Create API Key"** → เลือก project (หรือสร้างใหม่)
4. คัดลอก key (ขึ้นต้นด้วย `AIza...`) เก็บไว้

## 2) Run database migration

เปิด Supabase Dashboard → SQL Editor → paste เนื้อหาของไฟล์ `calpro-database-v2.19-ai-usage.sql` → กด **Run**

(หรือ CLI: `psql "$DATABASE_URL" -f calpro-database-v2.19-ai-usage.sql`)

ตรวจสอบ: ในหน้า Table Editor ควรเห็นตาราง `ai_usage` ใหม่

จากนั้น run `calpro-database-v2.34-security-fixes.sql` ด้วย (ทำให้ `ai_usage`
เขียนได้จาก server เท่านั้น + สร้าง RPC `increment_ai_usage` ที่ Edge Function ใช้)

## 3) Enable Anonymous Sign-ins (ครั้งเดียว)

Supabase Dashboard → **Authentication** → **Providers** → **Anonymous** → toggle เป็น **ON** → Save

(จำเป็นเพื่อให้ผู้ใช้ที่ยังไม่ได้สมัครใช้ AI feature ได้)

## 4) Deploy Edge Function + ตั้ง secrets

ติดตั้ง Supabase CLI ถ้ายังไม่มี:
```
npm install -g supabase
```

Login + link project:
```
supabase login
supabase link --project-ref pbtxshodaeztptegkguy
```

ตั้ง Gemini key เป็น secret (ใส่ key จากขั้นตอน 1):
```
supabase secrets set GEMINI_API_KEY=AIza...your-key-here
```

ตั้ง service-role key เป็น secret ด้วย (ใช้เขียน counter `ai_usage` ฝั่ง server —
หาได้จาก Dashboard → Settings → API → `service_role` secret):
```
supabase secrets set SUPABASE_SERVICE_ROLE_KEY=eyJ...service-role-key
```
⚠️ อย่าเอา service-role key ไปใส่ในแอป/ฝั่ง client เด็ดขาด — ใช้ใน Edge Function เท่านั้น

(ออปชั่นนัล) ปรับ daily limit หรือ model:
```
supabase secrets set AI_DAILY_LIMIT=20
supabase secrets set GEMINI_MODEL=gemini-2.5-flash
```
**Note:** ใช้ `gemini-2.5-flash` (default · multimodal · เร็ว · free tier รองรับ). อย่าใช้ `gemini-2.0-flash` เพราะใน free tier ใหม่ถูก rate-limit ทันที. ทางเลือกประหยัด token: `gemini-2.5-flash-lite`

Deploy function (no-verify-jwt เพราะเรา verify เองใน code):
```
supabase functions deploy ai-vision --no-verify-jwt
```

หลัง deploy ทดสอบโดยเปิดแอป → Settings → AI → กด "🔌 ทดสอบ" → ควรเห็น "✓ เชื่อมต่อสำเร็จ"

## Monitoring

ดู logs:
```
supabase functions logs ai-vision --tail
```

ดูจำนวน user/วัน ใน SQL editor:
```sql
SELECT day, COUNT(*) AS active_users, SUM(count) AS total_requests
FROM ai_usage
GROUP BY day
ORDER BY day DESC
LIMIT 14;
```

## ค่าใช้จ่าย

- Gemini Flash free tier: 1500 requests/day **ทั้งหมด** ต่อ key (ทุกคนรวมกัน)
- 20 รูป/วัน/คน × ~75 active users/วัน = ~1500 requests = ใช้ free tier เต็ม
- เกิน free tier: ~$0.0001/request (ถูกมาก) — ตั้ง billing alert ได้ใน Google Cloud Console

## Troubleshooting

**"Anonymous sign-in failed"** → ตรวจว่าได้ enable Anonymous Sign-ins ในขั้นตอน 3 แล้ว

**"server_misconfigured"** → secret ยังไม่ถูกตั้ง → `supabase secrets list` เช็คว่ามี `GEMINI_API_KEY` หรือยัง

**"rate_limited"** ทันทีที่ทดสอบ → ใน Dashboard ลบแถวใน `ai_usage` ของ user_id นั้น หรือ:
```sql
DELETE FROM ai_usage WHERE day = CURRENT_DATE;
```

**CORS error** → ตรวจว่า function แล้ว deploy แล้ว (`supabase functions list`) และ URL ตรงกับ `AI_PROXY_URL` ใน calpro-app.html
