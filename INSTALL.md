# CalPro v1.0.0 — วิธีติดตั้งบนมือถือ

CalPro ทำเป็น **PWA (Progressive Web App)** — ติดตั้งได้ทั้ง Android และ iOS โดยไม่ต้องผ่าน App Store / Play Store

## โครงสร้างไฟล์

```
CalPro/
├── calpro-app.html        ← แอปหลัก (HTML+CSS+JS)
├── manifest.webmanifest   ← PWA manifest
├── sw.js                  ← Service worker (offline)
├── icon-192.png           ← icon 192×192
├── icon-512.png           ← icon 512×512
├── icon-maskable-512.png  ← maskable icon (Android)
├── apple-touch-icon.png   ← icon 180×180 (iOS)
├── favicon-32.png         ← favicon
└── calpro-database.sql    ← (legacy, ไม่ใช้แล้ว)
```

## วิธี deploy (เลือก 1)

### A. ใช้ host ฟรี (แนะนำ)

อัปโหลดทั้งโฟลเดอร์ขึ้น:
- **GitHub Pages** — push repo แล้ว enable Pages
- **Netlify Drop** — ลากโฟลเดอร์ไป https://app.netlify.com/drop
- **Vercel** — `npx vercel` ในโฟลเดอร์
- **Cloudflare Pages** — connect GitHub repo

จะได้ URL เช่น `https://yourname.github.io/calpro/calpro-app.html`

### B. รันที่บ้านผ่านเครือข่าย LAN

```powershell
powershell -ExecutionPolicy Bypass -File .claude\serve.ps1
```

แล้วเปิดบนมือถือ: `http://<IP-เครื่อง>:8765/`
(มือถือต้องอยู่ Wi-Fi เดียวกัน)

## วิธีติดตั้งลงมือถือ

### Android (Chrome)
1. เปิด URL ในเบราว์เซอร์ Chrome
2. กดเมนู `⋮` → **"Install app"** หรือ **"Add to Home screen"**
3. ไอคอน CalPro จะปรากฏบนหน้าจอหลัก กดเปิดได้เลย (เหมือนแอปจริง)

### iOS (Safari)
1. เปิด URL ใน **Safari** (ต้องเป็น Safari เท่านั้น)
2. กด **Share** (สี่เหลี่ยมพร้อมลูกศรขึ้น)
3. เลื่อนหา **"Add to Home Screen"**
4. กด "Add" — ไอคอน CalPro จะอยู่หน้าจอหลัก

## คุณสมบัติ PWA ที่รองรับ

- ✅ ใช้งาน **offline** (cache HTML + icons ผ่าน service worker)
- ✅ Full-screen (ไม่มี address bar ตอนเปิดจาก home screen)
- ✅ Theme color = #ff6b6b (status bar สีแดงตอน Android)
- ✅ Splash screen อัตโนมัติจาก icon + theme color
- ✅ Safe-area padding รองรับ notch/home indicator ของ iPhone

## ถ้าอยากได้ APK/IPA จริง ๆ

PWA ใช้งานเหมือนแอปจริงแล้ว แต่ถ้าอยากปล่อย Play Store / App Store:

**Android (APK/AAB):**
1. ใช้ [PWABuilder.com](https://www.pwabuilder.com) → ใส่ URL ของ PWA → กด Build → ดาวน์โหลด AAB
2. หรือใช้ Bubblewrap CLI (ต้องมี Node.js + Android Studio)

**iOS (IPA):**
- ต้องมี Mac + Xcode + Apple Developer ($99/ปี)
- ใช้ PWABuilder สร้าง project Xcode → build IPA → upload App Store Connect

## หมายเหตุ

- ข้อมูลทั้งหมดเก็บใน **localStorage ของเบราว์เซอร์** บนเครื่องผู้ใช้
- ไม่มี backend, ไม่มีบัญชี
- ถ้าเปลี่ยนเบราว์เซอร์/เครื่อง ข้อมูลจะหาย — แนะนำ export/import ในรุ่นถัดไป
