# CalPro+ 🔥

แอปติดตามแคลอรี่ + คำนวณ TDEE ภาษาไทย/อังกฤษ · PWA ติดตั้งได้บนมือถือ + Android APK ผ่าน Capacitor

**Live demo:** https://peerawatsuper271-afk.github.io/calpro/

## ฟีเจอร์

- 🏠 บันทึกอาหารแบบ real-time (เช้า/กลางวัน/เย็น/ของว่าง) · แก้ไข/ลบ/แนบรูปได้
- 🍽️ **Portion picker** — เลือกจำนวนเท่า (0.5×–2× หรือ custom) ก่อนเพิ่มอาหารเพื่อความแม่นยำ
- 🔥 เครื่องคำนวณ **TDEE / BMR / BMI** สูตร Harris-Benedict (revised 1984) แบบ live update
- 📈 **กราฟแนวโน้มน้ำหนัก (คาดการณ์)** — พยากรณ์น้ำหนักจากแคลอรี่ + workout (1 kg ≈ 7700 kcal) · ไม่ต้องชั่งน้ำหนักทุกวัน · เห็นว่าจะถึงเป้าใน ~กี่สัปดาห์
- 💡 **คำแนะนำสุขภาพรายวัน** — วิเคราะห์ทุกการกินด้วย 10 rules (โปรตีน · macro · น้ำ · ข้ามมื้อ · ความหลากหลาย ฯลฯ) · ย่อ/ขยายการ์ดได้
- 💧 ติดตามน้ำดื่ม · สถิติ 7 วัน · แท่งสีฟ้าตามจำนวนแก้ว
- 📊 วิเคราะห์ trends ทั้งหมด + เหรียญตรา (badges) · กราฟแคล 7 วัน + น้ำ 7 วัน
- 🍱 ฐานข้อมูลอาหาร 110+ รายการ (ไทย/ญี่ปุ่น/เกาหลี/อิตาเลียน/อินเดีย/fast food/healthy/dessert/fruit/seafood/snack/veggie/drink)
- ⭐ Favorites + 🕘 Recent + 📝 Custom foods — เพิ่มเร็ว ไม่ต้องค้นใหม่
- 🎨 **8 ธีม** (5 dark: dark/night/rose/sky/violet · 3 light: light/cream/mint) + 8 สี accent · toggle ☀️/🌙
- 🔤 **เลือกฟอนต์ได้** — System / Sarabun / Prompt / Kanit / Mitr / IBM Plex (Google Fonts lazy-load)
- 🦊 รูปประจำตัว — เลือก emoji หรืออัพโหลดรูปจากเครื่อง
- 💾 Export/Import JSON backup — ย้ายข้อมูลข้ามเครื่องได้
- 📤 **แชร์เป็นรูปภาพ** (1080×1350) — สรุปวันนี้ + ความสำเร็จ · Web Share Level 2 (files) + fallback ดาวน์โหลด + clipboard caption
- 📅 เลือกวันที่จาก calendar picker โดยตรง
- 🔔 เตือนมื้อที่ลืม + ปรับเป้าหมายอัตโนมัติ + สรุปรายสัปดาห์ · **Native notifications** ใน APK ผ่าน Capacitor LocalNotifications
- 🏋️ บันทึกออกกำลังกาย 20 ประเภท (MET formula) → แคลอรี่ที่เผาหักจาก ring ทันที
- 📐 บันทึกสัดส่วนร่างกาย (เอว/สะโพก/อก/คอ) + คำนวณ Body Fat % สูตร US Navy
- 🌐 รองรับ 2 ภาษา ไทย / English (toggle ในตั้งค่า)
- ☁️ Cloud sync (opt-in via Supabase) — sync ข้ามเครื่อง · self-healing fallback ถ้า migration ยังไม่ครบ · friends + leaderboard (BETA)
- 📱 **PWA + APK** — ติดตั้งบน Android/iOS, ใช้งาน offline ได้, แจ้งเตือนเมื่อมีเวอร์ชั่นใหม่
- 🛠️ Simple Mode · customizable bottom nav · collapsible health tips
- 📖 หน้า **วิธีใช้งาน** ในตัวแอป — ครบทุก section
- 📨 ส่ง feedback ตรงถึงผู้พัฒนาผ่าน mailto draft
- 🔒 ข้อมูลทั้งหมดเก็บใน localStorage บนเครื่อง (Cloud Sync เป็น opt-in)

## โครงสร้าง

```
calpro-app.html                       ← แอปหลัก (HTML+CSS+JS in one file, ~250KB)
manifest.webmanifest                  ← PWA manifest
sw.js                                 ← Service worker (offline cache + notification clicks)
icon-*.png, apple-touch-icon.png      ← App icons (192/512/maskable/touch)
capacitor.config.json                 ← Capacitor wrapper config (com.calpro.app)
package.json                          ← Capacitor + assets deps
scripts/prepare-www.js                ← Copy web → www/ for Capacitor sync
.github/workflows/build-android-debug.yml  ← APK CI (artifact: calpro-plus-debug-apk)
resources/                            ← Source icons for capacitor-assets
calpro-database.sql                   ← Supabase schema (9 tables + RLS)
calpro-database-v2.4-migration.sql    ← Unique constraints for safe MERGE upserts
calpro-database-v2.7-migration.sql    ← Adds client_id / photo / name_en / met / avatar / updated_at columns
```

## การติดตั้งบนมือถือ

**Android (Chrome):** เปิด URL → เมนู ⋮ → "Install app"
**Android (APK direct):** ดาวน์โหลด APK จาก GitHub Actions artifacts (`calpro-plus-debug-apk`) แล้วติดตั้งบนเครื่อง
**iOS (Safari):** เปิด URL → Share → "Add to Home Screen"

ดูรายละเอียดเพิ่มเติมที่ [INSTALL.md](INSTALL.md)

## Stack

- Vanilla HTML/CSS/JS (no framework)
- localStorage default · Supabase opt-in cloud sync
- Service Worker (offline-first)
- Capacitor 6 (Android wrapper) + @capacitor/local-notifications
- Google Fonts (lazy-loaded only when picked)

## เวอร์ชั่น

- **v2.18.0** *(APK + web · BETA)* — **🚀 Mega-release** · **➕ FAB เพิ่มอาหารหน้าแรก** · **🖥️ Desktop UI** 3 breakpoints + card frame + shadow + gradient · **🔧 Developer Mode** ใน drawer → อื่น ๆ (ต้องใส่รหัสผ่าน) ดูสถิติผู้ใช้/อุปกรณ์/settings · **🍱 ลบ stats ซ้ำ** + ตัวเต็มสารอาหาร (โปรตีน/คาร์บ/ไขมัน) · **📷 อัปโหลดรูปโปรไฟล์** 256→512px, 2→8MB · **iOS fixes**: share card overflow, ปิด double-tap zoom, ปุ่ม refresh · **🐞 Bottom nav width fix** desktop
- **v2.17.0** *(web only · BETA)* — **👥 Friends ออกจาก placeholder** — Modal เพิ่มเพื่อนแบบใหม่ (แทน prompt) · ค้นหา debounced 250ms ด้วยอีเมล/display_name · status pills · ✕ ปุ่มลบเพื่อนในแต่ละแถว leaderboard · escapeHtml ป้องกัน XSS
- **v2.16.0** *(web only · BETA)* — **🍱 Food DB +30** (160+ รวม) — Rad Na/Drunken Noodles/Duck Rice/Suki/Yen Ta Fo + chains (Bonchon/Subway/Yayoi/MK) + drinks · **♿ ธีม "คมชัด" (Contrast)** · **♿ Modal Tab-trap** + reduced-motion media query · **⚡ Lazy-load Supabase SDK** (script defer + ensureSupabase polling)
- **v2.15.0** *(web only · BETA)* — **🖼️ Meal photos → IndexedDB** — เลิกใช้ localStorage 5MB · ความจุระดับ GB+ · sentinel `idb:<id>` · cloud sync resolve เป็น data URL ก่อนอัปโหลด · ลบ/clean/reset cascade ลง IDB · backward-compat กับรูปเก่า inline
- **v2.14.0** *(web only · BETA)* — **📷 Barcode Scanner** ในหน้าเพิ่มอาหาร — สแกนบาร์โค้ดสินค้าด้วยกล้อง (ZXing lazy-load) · ดึงข้อมูลโภชนาการจาก OpenFoodFacts (ฟรี ไม่ต้องสมัคร) · พิมพ์รหัสเองได้เมื่อกล้องใช้ไม่ได้ · ต่อเข้า Portion Picker เพื่อเลือกจำนวนก่อนเพิ่ม
- **v2.13.0** *(web only · BETA)* — **🍲 Recipe Builder** ในหน้าเพิ่มอาหาร — สร้างสูตรจากหลายส่วนผสม · ปรับจำนวนเท่าได้ละเอียด · per-serving + total live preview · บันทึกซ้ำชื่อ = อัปเดต
- **v2.12.0** *(web only · BETA)* — **👋 Onboarding Wizard** ครั้งแรกที่เปิดแอป — 4 ขั้นตอน (ทักทาย → กรอกข้อมูล → เลือกเป้า → สรุป TDEE) · live TDEE preview ก่อนเริ่มใช้งาน · "ข้ามไปก่อน" ก็ได้ · ♿ focus-visible outline ตอนกด Tab navigation
- **v2.11.0** *(web only · BETA)* — **🍱 +21 อาหารใหม่** Thai street food (ข้าวขาหมู/หมูแดง/หมูกรอบ/ก๋วยจั๊บ/ข้าวคลุกกะปิ/หมูสะเต๊ะ/ขนมจีบ/ผัดมาม่า/ผัดผักบุ้ง/ยำมาม่า) + chains (KFC/McDonald's/7-11/Starbucks) + healthy (อกไก่ 100g/ทูน่ากระป๋อง/เต้าหู้) · **♿ Accessibility**: กด Esc ปิด modal/drawer · ARIA labels บนปุ่ม icon (☰ · sync dot · mode toggle · water +/−)
- **v2.10.0** *(web only · BETA)* — **🍱 Quick Presets (ชุดอาหาร)** — แท็บใหม่ในหน้าเพิ่มอาหาร · บันทึกอาหารทั้งวันเป็นชุด เช่น "มื้อเช้าปกติ" → ครั้งหน้าแตะเดียวเพิ่มได้ครบ · ลบ/ดูจำนวน kcal รวมของแต่ละชุด · รองรับ export/import
- **v2.9.0** *(APK + web · BETA)* — **🎉 APK rebuild ครั้งแรกตั้งแต่ v2.7.1** — รวมทุก feature/fix ตั้งแต่ v2.7.2 ถึงปัจจุบัน (in-app update prompt, projection chart, health tips, portion picker, font picker, themes ใหม่, feedback, etc.) · **Smart Goal v2** ใช้แคลอรี่ projection แทน weight log · **ปุ่มลบรูปอาหารเก่า** (>30 วัน) ใน Settings → จัดการข้อมูล · ปิดท้าย i18n holdouts (TDEE apply toast)
- **v2.8.2** *(web only · BETA)* — **ระบบอัปเดตในแอป**: Modal "มีเวอร์ชันใหม่" (อัปเดตเลย / ไว้ทีหลัง) เมื่อ Service Worker เจอเวอร์ชันใหม่ · "✨ มีอะไรใหม่" popup อัตโนมัติหลังอัปเดตสำเร็จ แสดงประวัติย้อนหลังครบทุกเวอร์ชันที่ข้าม · ปุ่ม **"🔄 ตรวจหาเวอร์ชันใหม่"** + **"✨ มีอะไรใหม่"** ในหน้าเกี่ยวกับ · CHANGELOG embedded ในแอป (TH/EN)
- **v2.8.1** *(web only · BETA)* — **ปรับชุดธีม**: ลบ forest/warm/ocean ออก เพิ่ม **rose / sky / violet** ที่ทำสีตามสีหลัก (ยังคง 8 ธีมรวม: 5 dark + 3 light) · **Feedback modal** ใน drawer → อื่น ๆ → "ส่งคำแนะนำ" → เปิด mailto draft ไปที่ผู้พัฒนา (peerawat_pee123@hotmail.co.th) แนบเวอร์ชันแอป + UA อัตโนมัติ · README อัปเดตประวัติเวอร์ชั่นครบจนถึงปัจจุบัน · backward-compat: legacy theme `forest/warm/ocean` migrate อัตโนมัติเป็น sky/rose/sky
- **v2.8.0** *(web only · BETA)* — **Collapsible health-tips card** (state saved per user) · **Portion picker modal** เลือกจำนวนเท่า 0.5×–2× + custom + live preview macros/kcal/grams · **Font picker** Sarabun/Prompt/Kanit/Mitr/IBM Plex Sans Thai (lazy Google Fonts) · **Friends BETA badge** ใน drawer + bottom nav · CSS variable `--app-font` รองรับ font override
- **v2.7.9** *(web only · BETA)* — **คำแนะนำสุขภาพรายวัน** 10 rules วิเคราะห์ net kcal · โปรตีน · macro split · น้ำ · ข้ามมื้อเช้า · มื้อเย็นหนัก · ของว่าง · ความหลากหลาย · ของหวาน · เสนอ workout · สีขอบ severity (red/amber/blue/green) · **หน้า "วิธีใช้งาน"** 9 sections ครบ TH/EN ใน drawer → อื่น ๆ
- **v2.7.8** *(web only · BETA)* — **ตัดฟีเจอร์น้ำหนักรายวันออกทั้งหมด** · แทนที่ด้วย **กราฟแนวโน้มน้ำหนักคาดการณ์** จากข้อมูลแคลอรี่ + workout (1 kg ≈ 7700 kcal) · เส้นทึบ 14 วันย้อนหลัง + เส้นปะ 14 วันข้างหน้า · จุดวันนี้ + เส้นเป้าหมาย · ETA "ถึงเป้าใน ~N สัปดาห์" · ไม่ต้องชั่งน้ำหนักทุกวัน
- **v2.7.7** *(web only · BETA)* — **แท่งน้ำ** ในหน้าวิเคราะห์เติมสีฟ้าตามจำนวนแก้ว (opacity ลดถ้ายังไม่ถึงเป้า) · **แชร์ความสำเร็จ** เปลี่ยนเป็นรูปภาพ 1080×1350 (streak ใหญ่ + 3 stat boxes + earned badges + invite) · ปุ่ม "แชร์สรุปวันนี้" ยังแสดงตอน Simple Mode
- **v2.7.6** *(web only · BETA)* — **Workout ลดเลขกลางวง** (ring center = net = food − workout, ring fill % = net/goal) · Drawer "เครื่องมือ" แสดงเฉพาะตอน Simple Mode เปิด · แก้ root-cause version display ไม่อัปเดต (element `appVer` ไม่มีจริง → null.textContent crash → ver-tag updater ไม่รัน)
- **v2.7.5** *(web only · BETA)* — i18n bug sweep: theme labels (มืด/ดึก/ป่า/อุ่น/มหาสมุทร) มี EN translations · 15+ Thai-only toasts (export/import/save/avatar/share/sync error) ใช้ ternary lang switch · auth modal · workout select order · tooltips ✏️/✕ ใช้ t()
- **v2.7.4** *(web only · BETA)* — แก้ notification ค้าง "กำลังส่ง..." (เปลี่ยนจาก `serviceWorker.ready` ที่รอ activation เป็น `getRegistration()` ที่ return ทันที + on-demand register)
- **v2.7.3** *(web only · BETA)* — **Share card v2**: ลบวันที่/status pill ออกจากรูป, ลิงก์ไปอยู่ใน caption แทน · เพิ่มคำว่า **BETA** หลังเลขเวอร์ชั่น · progress UI ตอนทดสอบแจ้งเตือน
- **v2.7.2** *(web only)* — Share daily เป็น **รูปภาพ 1080×1350** + คำเชิญสุภาพ (random TH/EN) + Web Share Level 2 (files) + fallback ดาวน์โหลด + copy caption · แก้ Notification API บน installed PWA (`Illegal constructor`) → ใช้ `ServiceWorkerRegistration.showNotification()`
- **v2.7.1** — Migration SQL ใหม่ ([`calpro-database-v2.7-migration.sql`](calpro-database-v2.7-migration.sql)) — `ALTER TABLE ADD COLUMN IF NOT EXISTS` สำหรับ client_id/photo/name_en/met/avatar/updated_at + unique constraints + NOTIFY pgrst · Diagnose ตรวจ schema cache (PGRST204/42703 → column missing) + ปุ่มลิงก์ตรงไป Supabase SQL editor
- **v2.7.0** — release ใหญ่: **bug sweep** + **App launcher icon** ใน APK (capacitor-assets generate → mipmap ทุก density จาก resources/icon.png) · **Native notifications** ผ่าน @capacitor/local-notifications (helper sendNotification เลือก native vs web) · **Self-healing sync** (detect 42P10 → fallback fetch+update+insert แทน upsert) · Sync status dot 12px แสดง color เสมอ (gray/amber-pulse/green/red) tap-to-open settings · Stability: try/catch รอบ Capacitor calls + lsSave wrapped + photo 320px JPEG q=0.72 · Emoji cleanup (headers/buttons/drawer plain text) · **Drawer "เครื่องมือ"** section: quick modals สำหรับน้ำ/น้ำหนัก/workout/measurements (เข้าถึงได้แม้ Simple Mode ซ่อน widget)
- **v2.6.0** — แก้ sync หลัง login ไม่ refresh UI (`refreshActivePage()`) · ปุ่ม "ตรวจสอบการเชื่อมต่อ" ตรวจ migration constraints · Native APK status bar overlay (overlaysWebView + Capacitor StatusBar bridge ใน applyTheme) · **App icon ใหม่** "Cal" ขาว + "Pro+" แดง · ปุ่ม **ทดสอบแจ้งเตือน** · **Customizable bottom nav** เลือก 5 tabs จาก 8 ตัวเลือก (Today pinned) · animation นุ่มนวล · prefers-reduced-motion support
- **v2.5.0** — Capacitor scaffold + GitHub Actions APK build (debug APK ดาวน์โหลดจาก Actions artifacts)
- **v2.4.0** — แก้ปัญหาข้อมูลหาย + auto-logout · ใช้ **safe MERGE sync** แทน delete-then-insert · **Auto-sync** ทุกครั้งที่มีการเปลี่ยนแปลง (debounced 2s) + ทุก 5 นาที + ตอนกลับมาที่แท็บ · Session persists (autoRefreshToken + localStorage) · Sync dot indicator · ต้อง run [`calpro-database-v2.4-migration.sql`](calpro-database-v2.4-migration.sql)
- **v2.3.0** — เปลี่ยนชื่อ **CalPro+** · แก้บั๊ก: sync ค้าง (per-table try/catch + 15s timeout) · favorites ⭐ กดได้แล้ว · **โหมดใช้งานง่าย** · bottom nav + header เป็น **SVG icons**
- **v2.2.0** — UI redesign: minimalist + left drawer (☰) สำหรับ Profile/Friends/Settings/About · bottom nav 4 tabs · Settings page ใหม่ครบ
- **v2.1.0** — ☁️ Cloud sync ผ่าน Supabase (opt-in · email login · 8 ตาราง · friends + leaderboard · default ยังเป็น localStorage)
- **v2.0.0** — รองรับ 2 ภาษา 🇹🇭/🇬🇧 · บันทึกออกกำลังกาย 20 ประเภท (MET) · บันทึกสัดส่วนร่างกาย + Navy Body Fat %
- **v1.5.0** — แนบรูปอาหารต่อรายการ · banner เตือนมื้อ · ปรับเป้า kcal อัตโนมัติทุก 4 สัปดาห์ · สรุปสัปดาห์
- **v1.4.0** — ขยายฐานข้อมูลอาหาร 40→110 รายการ + ของโปรด ⭐ · รายการล่าสุด 🕘 · ไลบรารีอาหารส่วนตัว 📝
- **v1.3.0** — บันทึกน้ำหนัก (30-day chart) · บันทึกน้ำดื่ม 8 แก้ว/วัน · Analysis page รวม trends
- **v1.2.0** — แก้ไขรายการอาหาร · Export/Import JSON · SW update toast · Direct date picker
- **v1.1.0** — รูปประจำตัว (emoji 24 ตัว + อัพโหลด) · ธีมสว่าง (light/cream/mint) + ปุ่ม toggle 🌞🌙 · แชร์สรุปวันนี้/ความสำเร็จ
- **v1.0.0** — initial release
