# CalPro 🔥

แอปติดตามแคลอรี่ + คำนวณ TDEE ภาษาไทย ทำงานเป็น PWA ติดตั้งได้บนมือถือ

**Live demo:** https://peerawatsuper271-afk.github.io/calpro/calpro-app.html

## ฟีเจอร์

- 🏠 บันทึกอาหารแบบ real-time (เช้า/กลางวัน/เย็น/ของว่าง)
- 🔥 เครื่องคำนวณ **TDEE / BMR / BMI** สูตร Harris-Benedict (revised 1984)
- 📊 วิเคราะห์ 7 วันล่าสุด + เหรียญตรา (badges)
- 🍽️ ฐานข้อมูลอาหาร 40+ รายการ (ไทย/ญี่ปุ่น/เกาหลี/อิตาเลียน/อินเดีย/fast food/healthy)
- 🎨 8 ธีม (5 dark + 3 light) + 8 สี accent · toggle ☀️/🌙 ที่ header
- 🦊 รูปประจำตัว — เลือก emoji หรืออัพโหลดรูปจากเครื่อง
- 📤 แชร์สรุปวันนี้ / ความสำเร็จ (badges, streak)
- 📱 **PWA** — ติดตั้งบน Android/iOS, ใช้งาน offline ได้
- 💾 เก็บข้อมูลใน localStorage (ไม่ต้องล็อคอิน, ไม่มี backend)

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

- **v1.1.0** — เพิ่มรูปประจำตัว (emoji 24 ตัว + อัพโหลด), ธีมสว่าง (light/cream/mint) + ปุ่ม toggle 🌞🌙, แชร์สรุปวันนี้/ความสำเร็จ (Web Share API + clipboard fallback)
- **v1.0.0** — initial release
