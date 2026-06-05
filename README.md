# CalPro+ 🔥

แอปติดตามแคลอรี่ + คำนวณ TDEE ภาษาไทย/อังกฤษ · PWA ติดตั้งได้บนมือถือ + Android APK ผ่าน Capacitor

**Live demo:** https://peerawatsuper271-afk.github.io/calpro/

## ทำไมต้อง CalPro+

- 🇹🇭 **เข้าใจคนไทย** — ฐานข้อมูล 540 รายการ มีอาหารไทยตั้งแต่ street food ถึง chain ดัง พร้อมแมโครที่เคยตรวจสอบ
- 🤖 **AI ถ่ายรูปฟรี** — ถ่ายรูปอาหาร · ระบบช่วยกรอกแคล/มาโคร · ไม่ต้องตั้งค่าอะไรเลย
- 📱 **ไม่ต้องล็อกอินก็ใช้ได้** — ข้อมูลเก็บในเครื่อง · อยาก sync ข้ามมือถือค่อยเปิด Cloud Sync (ฟรี)
- 🎮 **โปรไฟล์สไตล์ Steam** — banner สีปรับได้ · level + badges · เห็นโปรไฟล์เพื่อนแบบ social
- 🔒 **เคารพ privacy** — ไม่มี tracker · source code เปิดให้ตรวจสอบ

## ฟีเจอร์

- 🏠 บันทึกอาหารแบบ real-time (เช้า/กลางวัน/เย็น/ของว่าง) · แก้ไข/ลบ/แนบรูปได้
- 🍽️ **Portion picker** — เลือกจำนวนเท่า (0.5×–2× หรือ custom) ก่อนเพิ่มอาหารเพื่อความแม่นยำ
- 🔥 เครื่องคำนวณ **TDEE / BMR / BMI** สูตร Harris-Benedict (revised 1984) แบบ live update
- 🌙 **ตัวติดตามนิสัยประจำวัน** — ก้าวเดิน (อัตโนมัติ) · การนอน (ชั่วโมง + คุณภาพ)
- 🎤 **สั่งงานด้วยเสียง** — พูดชื่ออาหารในช่องค้นหา (ไทย/อังกฤษ/จีน)
- 📈 **กราฟแนวโน้มน้ำหนัก (คาดการณ์)** — พยากรณ์น้ำหนักจากแคลอรี่ + workout · ไม่ต้องชั่งทุกวัน
- 💡 **คำแนะนำสุขภาพรายวัน** — วิเคราะห์การกินด้วย 10 rules · ย่อ/ขยายได้
- 💧 ติดตามน้ำดื่ม · สถิติ 7 วัน
- 📊 วิเคราะห์ trends ทั้งหมด + เหรียญตรา (badges)
- 🍱 ฐานข้อมูลอาหาร 540+ รายการ (ไทย/ญี่ปุ่น/เกาหลี/อิตาเลียน/อินเดีย/fast food/healthy/dessert/fruit/seafood/snack/veggie/drink)
- ⭐ Favorites + 🕘 Recent + 📝 Custom foods — เพิ่มเร็ว ไม่ต้องค้นใหม่
- 🎨 **8 ธีม** (5 dark · 3 light) + 8 สี accent · toggle ☀️/🌙 · เลือกฟอนต์ได้
- 🦊 รูปประจำตัว — เลือก emoji หรืออัพโหลดรูป + ครอปเอง
- 💾 Export/Import JSON backup · 📤 แชร์เป็นรูปภาพ (สรุปวันนี้ + ความสำเร็จ)
- 📅 เลือกวันที่จาก calendar picker ในแอป
- 🔔 เตือนมื้อ + ปรับเป้าหมายอัตโนมัติ + สรุปรายสัปดาห์ · **Native notifications** ใน APK
- 🏋️ บันทึกออกกำลังกาย 20 ประเภท (MET) → หักจาก ring ทันที
- 📐 บันทึกสัดส่วนร่างกาย + คำนวณ Body Fat % สูตร US Navy
- 🌐 รองรับ 4 ภาษา ไทย / English / 简体 / 繁體
- ☁️ Cloud sync (opt-in via Supabase) — sync ข้ามเครื่อง · friends + leaderboard
- 📱 **PWA + APK** — ติดตั้งบน Android/iOS, ใช้งาน offline ได้, อัปเดตอัตโนมัติ
- 🛠️ Simple Mode · customizable bottom nav
- 📖 หน้า **วิธีใช้งาน** + ทัวร์แนะนำในตัวแอป
- 🔒 ข้อมูลทั้งหมดเก็บในเครื่อง (Cloud Sync เป็น opt-in)

## โครงสร้าง

```
calpro-app.html                       ← แอปหลัก (HTML+CSS+JS ไฟล์เดียว)
manifest.webmanifest                  ← PWA manifest
sw.js                                 ← Service worker (offline cache + notification clicks)
icon-*.png, apple-touch-icon.png      ← App icons (192/512/maskable/touch)
capacitor.config.json                 ← Capacitor wrapper config (com.calpro.app)
package.json                          ← Capacitor + assets + pedometer deps
scripts/prepare-www.js                ← Copy web → www/ for Capacitor sync
.github/workflows/build-android-debug.yml  ← APK CI (artifact: calpro-plus-debug-apk)
resources/                            ← Source icons for capacitor-assets
calpro-database.sql                   ← Supabase schema (tables + RLS)
calpro-database-v2.*.sql              ← Migrations (ส่วนเสริมแบบ self-healing · habits/profile/ai_usage ฯลฯ)
```

## การติดตั้งบนมือถือ

**Android (Chrome):** เปิด URL → เมนู ⋮ → "Install app"
**Android (APK direct):** ดาวน์โหลด APK จาก [GitHub Releases](https://github.com/peerawatsuper271-afk/calpro/releases/latest) แล้วติดตั้งบนเครื่อง
**iOS (Safari):** เปิด URL → Share → "Add to Home Screen"

ดูรายละเอียดเพิ่มเติมที่ [INSTALL.md](INSTALL.md)

## Stack

- Vanilla HTML/CSS/JS (no framework)
- localStorage default · Supabase opt-in cloud sync
- Service Worker (offline-first)
- Capacitor 8 (Android wrapper) + `@capacitor/local-notifications` + `@capgo/capacitor-pedometer`
- Google Fonts (lazy-loaded only when picked)

## การนับก้าว & สิทธิ์ (Step counting)

CalPro+ นับก้าวให้อัตโนมัติ โดยเลือกแหล่งข้อมูลตามแพลตฟอร์ม:

- **แอป Android (APK):** อ่านตัวนับก้าวของระบบ (hardware step counter) ผ่าน `@capgo/capacitor-pedometer` — นับได้ตลอดวันแม้ปิดแอป · ขอสิทธิ์ **ACTIVITY_RECOGNITION** (กิจกรรมทางกาย) ครั้งแรกที่ใช้
- **เว็บ / PWA:** ใช้เซนเซอร์การเคลื่อนไหว (DeviceMotion) — **นับเฉพาะตอนเปิดแอปไว้** (เบราว์เซอร์อ่านตัวนับก้าวทั้งวันของระบบไม่ได้) · iOS ต้องแตะอนุญาตใช้เซนเซอร์ครั้งแรก
- ถ้าอุปกรณ์ไม่มีเซนเซอร์/ไม่ได้รับสิทธิ์ → จะไม่นับ (ไม่มี error)
- **ความเป็นส่วนตัว:** ข้อมูลก้าวเก็บในเครื่อง · ซิงค์ขึ้น Supabase เฉพาะเมื่อเปิด Cloud Sync · ไม่แชร์ให้บุคคลที่สาม

## เวอร์ชั่น

> สรุปย่อ — เน้นฟีเจอร์หลัก (เวอร์ชันแก้บั๊ก/ปรับปรุงย่อยรวมเข้าด้วยกัน · อัปเดตเงียบไม่แสดง)

- **v2.41** — ชุดธีม Nutrition UI System · วิเคราะห์การนอนหลับ · นับก้าวเดินหักแคลอรี่ · แก้ไขบั๊ก
- **v2.40** — จัดหน้านิสัยประจำวันใหม่ (ก้าวเดินคู่ออกกำลังกาย · ย้ายการนอนไปหน้าวิเคราะห์) · แก้ไขบั๊ก
- **v2.39** — ก้าวเดินอัตโนมัติ
- **v2.38** — ตัวติดตามนิสัยประจำวัน · สั่งงานด้วยเสียง · ซิงค์นิสัยขึ้นคลาวด์
- **v2.35** — ทัวร์แนะนำการใช้งาน · สำรอง+กู้คืนข้อมูลอัตโนมัติ · แก้ไขบั๊ก
- **v2.33** — ดีไซน์กระจกฝ้า (glassmorphism)
- **v2.32** — โปรไฟล์สไตล์โซเชียล · ครอปรูปเอง · ไอคอน SVG ทั้งแอป
- **v2.31** — วงแหวนไล่สีสเปกตรัม · ปรับปรุง UI
- **v2.30** — โฉมใหม่ธีมเข้ม · แถบล่างแคปซูลกระจก · เมนูเลือกในแอป
- **v2.29** — แอปอัปเดตเอง · เต็มจอขอบจรดขอบ · ตัวกรองหมวดอาหาร
- **v2.28** — เพิ่มด่วน 1 แตะ · ปรับปรุงประสิทธิภาพ
- **v2.27** — เลือกมื้ออัตโนมัติ · skeleton loading · ป๊อปอัปในแอป
- **v2.26** — แนวโน้มน้ำหนักใหม่ (พยากรณ์)
- **v2.25** — ปฏิทินเลือกวันที่ในแอป
- **v2.24** — ซิงค์แม้ไม่ล็อกอิน · แก้ไขบั๊ก
- **v2.23** — กระดานผู้นำระดับโลก · Level 1–10
- **v2.22** — Friends + Leaderboard (เปิดใช้จริง)
- **v2.21** — โปรไฟล์ Steam-style · ดูโปรไฟล์เพื่อน · AI ถ่ายรูปฟรี
- **v2.20** — ปรับ UX · AI เฉพาะสมาชิก · เหรียญถาวร
- **v2.19** — AI ถ่ายรูปอาหารฟรี · ระบบ Growth (สตรีค/referral/แชร์)
- **v2.18** — FAB เพิ่มอาหาร · Desktop UI · Developer Mode · โฆษณา Affiliate
- **v2.17** — เพิ่ม/ค้นหาเพื่อน
- **v2.16** — เพิ่มอาหาร · ธีมคมชัด
- **v2.15** — รูปอาหารลง IndexedDB
- **v2.14** — สแกนบาร์โค้ด
- **v2.13** — สร้างสูตรอาหาร
- **v2.12** — Onboarding ครั้งแรก
- **v2.11** — เพิ่มอาหาร · accessibility
- **v2.10** — ชุดอาหารสำเร็จ (Presets)
- **v2.9** — APK rebuild · Smart Goal v2
- **v2.8** — Portion picker · Font picker · ระบบอัปเดตในแอป
- **v2.7** — แจ้งเตือนเนทีฟ · คำแนะนำสุขภาพ · แนวโน้มน้ำหนัก · แก้ไขบั๊ก
- **v2.6** — สถานะบาร์เนทีฟ · ไอคอนแอปใหม่ · แถบล่างปรับแต่งได้
- **v2.5** — แอป Android (Capacitor + APK)
- **v2.4** — ซิงค์แบบ MERGE ปลอดภัย + auto-sync
- **v2.3** — เปลี่ยนชื่อ CalPro+ · โหมดใช้งานง่าย · ไอคอน SVG
- **v2.2** — ยกเครื่อง UI + เมนูข้าง
- **v2.1** — ซิงค์คลาวด์ (Supabase) + เพื่อน/กระดานผู้นำ
- **v2.0** — 2 ภาษา (ไทย/อังกฤษ) · บันทึกออกกำลังกาย · สัดส่วนร่างกาย
- **v1.5** — รูปอาหาร · เตือนมื้อ · ปรับเป้าอัตโนมัติ · สรุปสัปดาห์
- **v1.4** — ขยายฐานข้อมูลอาหาร · ของโปรด · อาหารส่วนตัว
- **v1.3** — บันทึกน้ำหนัก · น้ำดื่ม · หน้าวิเคราะห์
- **v1.2** — แก้ไขรายการ · Export/Import · เลือกวันที่
- **v1.1** — รูปประจำตัว · ธีมสว่าง · แชร์
- **v1.0** — เวอร์ชันแรก
