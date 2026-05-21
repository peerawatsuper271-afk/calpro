# CalPro 🔥

แอปติดตามแคลอรี่ + คำนวณ TDEE ภาษาไทย ทำงานเป็น PWA ติดตั้งได้บนมือถือ

**Live demo:** https://peerawatsuper271-afk.github.io/calpro/calpro-app.html

## ฟีเจอร์

- 🏠 บันทึกอาหารแบบ real-time (เช้า/กลางวัน/เย็น/ของว่าง) · แก้ไข/ลบ/แนบรูปได้
- 🔥 เครื่องคำนวณ **TDEE / BMR / BMI** สูตร Harris-Benedict (revised 1984)
- ⚖️ บันทึกน้ำหนักรายวัน + กราฟ 30 วัน พร้อมแนวโน้ม (linear regression)
- 💧 ติดตามน้ำดื่ม 8 แก้ว/วัน · สถิติ 7 วัน
- 📊 วิเคราะห์ trends ทั้งหมด + เหรียญตรา (badges)
- 🍽️ ฐานข้อมูลอาหาร 110+ รายการ (ไทย/ญี่ปุ่น/เกาหลี/อิตาเลียน/อินเดีย/fast food/healthy/dessert/fruit/seafood/snack/veggie/drink)
- ⭐ Favorites + 🕘 Recent + 📝 Custom foods — เพิ่มเร็ว ไม่ต้องค้นใหม่
- 🎨 8 ธีม (5 dark + 3 light) + 8 สี accent · toggle ☀️/🌙 ที่ header
- 🦊 รูปประจำตัว — เลือก emoji หรืออัพโหลดรูปจากเครื่อง
- 💾 Export/Import JSON backup — ย้ายข้อมูลข้ามเครื่องได้
- 📤 แชร์สรุปวันนี้ / ความสำเร็จ (badges, streak)
- 📅 เลือกวันที่จาก calendar picker โดยตรง
- 🔔 เตือนมื้อที่ลืม + ปรับเป้าหมายอัตโนมัติทุก 4 สัปดาห์ + สรุปรายสัปดาห์
- 🏋️ บันทึกออกกำลังกาย 20 ประเภท (MET formula) → เพิ่ม kcal ในเป้าหมาย
- 📐 บันทึกสัดส่วนร่างกาย (เอว/สะโพก/อก/คอ) + คำนวณ Body Fat % สูตร US Navy
- 🌐 รองรับ 2 ภาษา ไทย / English (toggle ในตั้งค่า)
- ☁️ Cloud sync (opt-in via Supabase) — sync ข้ามเครื่อง · friends + leaderboard
- 📱 **PWA** — ติดตั้งบน Android/iOS, ใช้งาน offline ได้, แจ้งเตือนเมื่อมีเวอร์ชั่นใหม่
- 🔒 ข้อมูลทั้งหมดเก็บใน localStorage บนเครื่อง (ไม่ต้องล็อคอิน, ไม่มี backend)

## โครงสร้าง

```
calpro-app.html        ← แอปหลัก (HTML+CSS+JS in one file)
manifest.webmanifest   ← PWA manifest
sw.js                  ← Service worker (offline cache)
icon-*.png             ← App icons
```

## การติดตั้งบนมือถือ

**Android (Chrome):** เปิด URL → เมนู ⋮ → "Install app"

**iOS (Safari):** เปิด URL → Share → "Add to Home Screen"

ดูรายละเอียดเพิ่มเติมที่ [INSTALL.md](INSTALL.md)

## Stack

- Vanilla HTML/CSS/JS (no framework)
- localStorage (no backend)
- Service Worker (offline-first)

## เวอร์ชั่น

- **v2.2.0** — UI redesign: minimalist + left drawer (☰) สำหรับ Profile/Friends/Settings/About · ลด bottom nav เหลือ 4 tabs · Settings page ใหม่ครบ (theme/lang/reminders/water goal/meal times/compact mode/data) · ย้าย Profile เข้า drawer
- **v2.1.0** — ☁️ Cloud sync ผ่าน Supabase (opt-in · email login · push/pull localStorage ↔ cloud · 8 ตาราง · friends + leaderboard กลับมา · default ยังเป็น localStorage)
- **v2.0.0** — รองรับ 2 ภาษา 🇹🇭/🇬🇧 (i18n layer + toggle ใน settings), บันทึกออกกำลังกาย 20 ประเภท (MET formula → kcal เผาผลาญ → เพิ่มในเป้าหมาย), บันทึกสัดส่วนร่างกาย (เอว/สะโพก/อก/คอ) + Navy Body Fat % calculator
- **v1.5.0** — แนบรูปอาหารต่อรายการ, banner เตือนมื้อที่ลืม, ปรับเป้า kcal อัตโนมัติทุก 4 สัปดาห์ตามแนวโน้มน้ำหนัก, สรุปสัปดาห์ที่แล้ว popup
- **v1.4.0** — ขยายฐานข้อมูลอาหาร 40→110 รายการ + 5 หมวดใหม่, ของโปรด ⭐, รายการล่าสุด 🕘, ไลบรารีอาหารส่วนตัว 📝
- **v1.3.0** — บันทึกน้ำหนัก (30-day line chart + trend regression), บันทึกน้ำดื่ม 8 แก้ว/วัน (widget + 7-day bars), Analysis page รวม trends ทั้งหมด
- **v1.2.0** — แก้ไขรายการอาหาร (modal pre-fill), Export/Import JSON backup, Service worker update toast, Direct date picker
- **v1.1.0** — เพิ่มรูปประจำตัว (emoji 24 ตัว + อัพโหลด), ธีมสว่าง (light/cream/mint) + ปุ่ม toggle 🌞🌙, แชร์สรุปวันนี้/ความสำเร็จ (Web Share API + clipboard fallback)
- **v1.0.0** — initial release
