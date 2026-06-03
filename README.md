# CalPro+ 🔥

แอปติดตามแคลอรี่ + คำนวณ TDEE ภาษาไทย/อังกฤษ · PWA ติดตั้งได้บนมือถือ + Android APK ผ่าน Capacitor

**Live demo:** https://peerawatsuper271-afk.github.io/calpro/

## ทำไมต้อง CalPro+

- 🇹🇭 **เข้าใจคนไทย** — ฐานข้อมูล 250 รายการ มีอาหารไทยตั้งแต่ street food ถึง chain ดัง พร้อมแมโครที่เคยตรวจสอบ
- 🤖 **AI ถ่ายรูปฟรี** — ถ่ายรูปอาหาร · ระบบช่วยกรอกแคล/มาโคร · ไม่ต้องตั้งค่าอะไรเลย
- 📱 **ไม่ต้องล็อกอินก็ใช้ได้** — ข้อมูลเก็บในเครื่อง · อยาก sync ข้ามมือถือค่อยเปิด Cloud Sync (ฟรี)
- 🎮 **โปรไฟล์สไตล์ Steam** — banner สีปรับได้ · level + badges · เห็นโปรไฟล์เพื่อนแบบ social
- 🔒 **เคารพ privacy** — ไม่มี tracker · ไม่มีโฆษณาเข้าระบบ · source code เปิดให้ตรวจสอบ

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

- **v2.33.20** *(เว็บ · BETA · silent)* — 🧩 **จิปาถะหลายจุด** — **หน้ากรอกเอง** เป็นป๊อปอัพ (กดปุ่มแล้วเปิดหน้าต่างเล็ก เหมือนสร้างสูตรอาหาร) · **ซูมรูปโปรไฟล์/พื้นหลังได้จริง** (บีบนิ้ว/แตะสองครั้งซูมที่รูปเอง ไม่ใช่ซูมทั้งเพจ) · ปุ่ม **แชร์หน้าแรก** เด่นขึ้น (โทนสีหลักแบบบางๆ ไม่รก) · **แถบเมนูซ้าย** พื้นหลังทึบขึ้น สีกลมกลืนไม่เป็นหย่อม · **หน้า Cloud Sync** จัดใหม่สไตล์ iOS (ไอคอนเมฆในวงกลม + ปุ่มเป็นระเบียบ) · อัปเดตเงียบ
- **v2.33.19** *(เว็บ · BETA · silent)* — 📐 หน้าต่างแก้ไขโปรไฟล์: จำกัดความสูง **ไม่เกิน 2/3 ของจอ** (จากเดิมเกือบเต็มจอ) → กล่องกะทัดรัดลอยกลางจอ เนื้อหาเลื่อนภายใน หัวข้อ/ปุ่มปิด/ปุ่มบันทึกยังตรึงไว้ครบ · อัปเดตเงียบ
- **v2.33.18** *(เว็บ · BETA · silent)* — ✏️ **หน้าต่างแก้ไขโปรไฟล์ใหม่ (แก้ปัญหาปิดไม่ได้)** — เปลี่ยนเป็นโครงสไตล์แอป: **หัวข้อ + ปุ่มปิด (×) ตรึงไว้ด้านบนเสมอ** (เลื่อนยังไงก็กดปิดได้ — เดิมบางเครื่องเลื่อนลงแล้วปุ่มปิดหาย กดออกไม่ได้) · เนื้อหาเลื่อนเฉพาะตรงกลาง · **ปุ่ม "บันทึก" เดียวตรึงด้านล่าง** (รวมบันทึกข้อมูลส่วนตัว + สัดส่วนร่างกายเป็นปุ่มเดียว ไม่สับสน) · หัวข้ออยู่กึ่งกลาง · แตะนอกกล่องเพื่อปิดได้ · กล่องไม่ยาวเกินจอ · อัปเดตเงียบ
- **v2.33.17** *(เว็บ · BETA · silent)* — 🛠️ **เพิ่มอาหารใช้ง่ายขึ้น + โฆษณาตามภาษา** — โฆษณาแปลตามภาษาแล้ว (อังกฤษเมื่อเลือก EN/จีน, ไทยเมื่อเลือกไทย) · หน้าเพิ่มอาหาร: ย้าย **① มื้ออาหาร** ขึ้นบนสุด ตามด้วย **② ประเภทอาหาร** (ใส่เลขขั้นตอนให้ใช้ง่าย) · กล่องผลค้นหา **ลากขยายได้** + สูงขึ้น · ดาวหลังชื่ออาหารเปลี่ยนเป็น **ไอคอนดาว SVG** (เหลืองเมื่อเป็นของโปรด) · หน้าต่างแก้ไขโปรไฟล์: หัวข้อ **อยู่กึ่งกลาง** + ปุ่มปิดไม่บังชื่อ · อัปเดตเงียบ
- **v2.33.16** *(เว็บ · BETA · silent)* — 🈶 **จีนครบขึ้น (ไม่มีไทยโผล่) + หน้าต่างแก้ไขโปรไฟล์เตี้ยลง** — ข้อความไดนามิก ~138 จุด (toast/ยืนยัน/ข้อความคำนวณ) เดิมตกเป็นไทยเมื่อเลือกจีน ตอนนี้ **fallback เป็นอังกฤษอัตโนมัติ** (จีน/อังกฤษไม่เห็นไทยอีก) + แปลจุดเด่นเป็นจีนจริง (ปุ่ม ตกลง/ยกเลิก/ยืนยัน · บันทึก/เพิ่ม/แชร์/ล้างข้อมูล/Export/Import) · แก้ placeholder ที่ตกหล่น (textarea แปลตามภาษาแล้ว) · **หน้าต่างแก้ไขโปรไฟล์เตี้ยลง** (กระชับ spacing + bio 2 บรรทัด) เนื้อหาเท่าเดิม · อัปเดตเงียบ
- **v2.33.15** *(เว็บ · BETA · silent)* — 🌏 **เพิ่มภาษาจีน (简体 + 繁體) + ยกเครื่องหน้าแก้ไขโปรไฟล์** — เพิ่ม **简体中文 / 繁體中文** ในหน้าภาษา (จัดใหม่เป็นรายการสไตล์ iOS มีเครื่องหมายติ๊กบนภาษาที่เลือก) แปล UI หลักทั้งหมด · **หน้าแก้ไขโปรไฟล์** เปลี่ยนเป็นสไตล์ iOS (หัวข้อ section + กลุ่มมน) + ลดขนาดช่องกรอกให้กะทัดรัด · **แตะรูปโปรไฟล์/ภาพพื้นหลังเพื่อซูมดูใหญ่ชัด** (รูปเล็กก็ขยายเต็ม) · อัปเดตเงียบ
- **v2.33.14** *(เว็บ · BETA · silent)* — 🧊 **ยกเครื่องหน้าตั้งค่า + จัดระเบียบโปรไฟล์/วิเคราะห์** — หน้าตั้งค่าย่อยเปลี่ยนเป็นสไตล์ iOS (หัวข้อ section + กลุ่มมนโปร่งกระจก + เส้นคั่นบาง) แทนการ์ดแบนๆ + โชว์ **เลขเวอร์ชั่น** ล่างสุดหน้าตั้งค่า · **กราฟน้ำดื่ม** เปลี่ยนเป็นแท่งสไตล์ iOS เหมือนกราฟแคลอรี่ (เส้นกริด/เส้นเป้าประ/แตะดูรายวัน) · ย้าย **เหรียญตรา** ออกจากหน้าวิเคราะห์ → ไปหน้าโปรไฟล์ (กดพับ/ขยายได้) · **แตะรูปโปรไฟล์ / ภาพพื้นหลังเพื่อดูเต็มจอ** ได้ (เปลี่ยนรูปผ่านปุ่มกล้องเหมือนเดิม) · อัปเดตเงียบ
- **v2.33.13** *(เว็บ · BETA · silent)* — 🎨 **ปรับดีไซน์การ์ดแชร์** — การ์ดสรุปรายวัน: ตัดบรรทัด "จาก..." ใต้ตัวเลขออก เหลือแค่ **kcal** + ขยับตัวเลขให้อยู่กึ่งกลางวงแหวนพอดี · มาโคร (โปรตีน/คาร์บ/ไขมัน) มี **วงแหวนสีรอบตัวเลข** เติมตามสัดส่วนแคลของแต่ละมาโคร · การ์ดความสำเร็จ: จัดเลข streak/สถิติ/เหรียญให้บาลานซ์อยู่กึ่งกลางสวยขึ้น · **คำเชิญชวนใหม่ 10 แบบ** สไตล์สดใสน่ารัก (ไทย + อังกฤษ) สุ่มแสดงบนการ์ด · อัปเดตเงียบ
- **v2.33.12** *(เว็บ · BETA · silent)* — 🔗 **QR โหลดแอปบนการ์ดแชร์ทุกใบ** — การ์ดสรุปรายวัน + การ์ดความสำเร็จ มี QR code ลิงก์ไปหน้าแอป พร้อม **ไอคอนแอปอยู่กลาง QR** (สร้างด้วย ECC ระดับ H เลยสแกนติดแม้ไอคอนบังกลาง) · จัด footer ใหม่: QR ฝั่งซ้าย + ข้อความเชิญชวนฝั่งขวา · ไฟล์ QR เป็น asset ในตัว (`qr-app.png`) ทำงานออฟไลน์ + วาดลง canvas ได้โดยไม่ทำให้การ export รูปพัง · อัปเดตเงียบ
- **v2.33.11** *(เว็บ · BETA · silent)* — 📊 **กราฟแคลอรี่สไตล์ iOS Battery** — ยกเครื่องใหม่: เส้นกริดแนวนอนจางๆ + เส้นฐาน (baseline) + **เส้นเป้าหมายแบบประ** พร้อมป้ายค่า + ป้ายสเกลแกน Y · แท่งมุมโค้งด้านบน (เขียว=ในเป้า · แดง=เกิน) · **แตะแท่งเพื่อดูรายวัน** (วันที่ + แคล + ส่วนต่างจากเป้า) แท่งที่เลือกเด่นขึ้น แท่งอื่นจางลงแบบ iOS Health · สเกลปรับอัตโนมัติไม่ล้นกรอบ · ใช้ได้ทั้ง 7 วัน/30 วัน · อัปเดตเงียบ
- **v2.33.10** *(เว็บ · BETA · silent)* — ⚙️ **หน้าตั้งค่าสไตล์ iOS (หน้าย่อยแยก)** — เปลี่ยนจากการ์ดยาวหน้าเดียว เป็นรายการจัดกลุ่มแบบ iOS Settings: แต่ละแถวมีไอคอนสีในกล่องมน + ป้ายชื่อ + chevron › เมื่อกดจะเปิด **หน้าย่อยแยกออกมา** (Cloud Sync · รูปลักษณ์ · ภาษา · การเตือน · AI · ปรับแต่งแถบล่าง · เป้าหมายน้ำดื่ม · จัดการข้อมูล) พร้อมปุ่มย้อนกลับ · ตัวควบคุมทั้งหมดทำงานเหมือนเดิม · อัปเดตเงียบ
- **v2.33.9** *(เว็บ · BETA · silent)* — 📊 **กราฟวิเคราะห์สไตล์กระจก/iOS** — แท่งแคลอรี่มุมโค้ง + ประกายกระจก (sheen) · กราฟน้ำหนักเติม area fill ไล่จางแบบ iOS Health · จุดน้ำดื่มเป็นกระจก · ⚙️ **หน้าตั้งค่าสไตล์ iOS** — toggle แบบ iOS (เปิด=เขียว ปุ่มขาวมีเงา) · เส้นคั่นนุ่มขึ้น · อัปเดตเงียบ
- **v2.33.8** *(เว็บ + Edge/SQL · BETA · silent · 🔒 security)* — เจาะรอบลึก (สิทธิ์/business-logic): แก้ **broken access control** — เดิมเพิ่มเพื่อนฝ่ายเดียวแล้วอ่าน food_entries ดิบ (ชื่อ+รูปมื้อ) ของคนอื่นได้ → leaderboard ใช้ผลรวม (RPC get_public_daily_totals) แทน + ลบนโยบาย `entries_friends_select` · แก้ **AI quota bypass** — Edge function เขียน `ai_usage` ด้วย service-role + ลบนโยบาย write ของ user · **ต้องทำ**: รัน `calpro-database-v2.34-profile-privacy.sql` + ตั้ง secret `SUPABASE_SERVICE_ROLE_KEY` แล้ว redeploy `ai-vision` (ตามลำดับในไฟล์ SQL)
- **v2.33.7** *(เว็บ · BETA · silent · 🔒 security)* — รอบตรวจที่ 2: escape ชื่ออาหารทุกจุดที่ render (ค้นหา/ของโปรด/ล่าสุด/สูตร/quick-add — ชื่อ custom=ผู้ใช้, ล่าสุด=บาร์โค้ด/AI) · ชื่อออกกำลังกาย · ตัวเลขผล AI coerce เป็น Number · ยืนยัน toast/dialog/bio ใช้ textContent ปลอดภัยอยู่แล้ว · อัปเดตเงียบ (เว็บ · APK พักไว้)
- **v2.33.6** *(เว็บ · BETA · silent · 🔒 security)* — อุดช่องโหว่จาก security audit: escape ข้อมูลผู้ใช้/เพื่อนทุกจุดที่ render (กัน **stored XSS** จากชื่อ/รูปโปรไฟล์เพื่อน + ชื่ออาหารจากบาร์โค้ด/AI) · กัน **CSS injection** จากสี/รูป banner · กัน **PostgREST filter injection** ในค้นหาเพื่อน + ปิด **PII ของ profiles** (email/อายุ/ส่วนสูง) ผ่าน RPC ปลอดภัย + RLS own-only *(ต้องรัน `calpro-database-v2.34-profile-privacy.sql` ใน Supabase)* · `rel=noopener` กัน tabnabbing · อัปเดตเงียบ (เว็บ · APK พักไว้)
- **v2.33.5** *(เว็บ · BETA · silent)* — 🩹 เอาเส้นขอบขาวบนการ์ดโปรไฟล์ (cover) ออก — เดิม border `glass-bd` + specular highlight สีขาวพาดบนแบนเนอร์มืด เหลือแค่เงา drop · อัปเดตเงียบ
- **v2.33.4** *(เว็บ · BETA · silent)* — 🔝 แถบหัวเต็มขอบ (full-bleed) + blur ย้ายไป `::before` พร้อม mask ไล่จางลงล่าง → เลื่อนแล้วเนื้อหาเบลอจางหายไม่มีเส้นขอบ (iOS scroll-edge) · อัปเดตเงียบ
- **v2.33.3** *(เว็บ · BETA · silent)* — 🧹 เก็บกวาดอีโมจิตกค้าง/ซ้ำในทุกหน้า+ป๊อปอัป: ลบอีโมจิที่ซ้ำกับไอคอน SVG (recap/ส่งกำลังใจ/โปรไฟล์เพื่อน/AI/บันทึกสูตร) · statline ใช้ award icon · empty-state เป็น SVG · เอา 🎁🔒🎉 ออกจาก toast/แจ้งเตือน/empty-state (อัปเดตเงียบ ไม่เด้ง changelog)
- **v2.33.2** *(APK + web · BETA)* — ✨ **ยกระดับเป็นกระจกใสสไตล์ iOS (liquid glass) ทั้งแอป** เบลอหนักขึ้น/โปร่งขึ้น/มีขอบเรืองแสง · 🔝 แถบหัวเอากรอบออก (โปร่งลอย) · ➕ FAB สีเข้มสดขึ้น + ประกายกระจก · 🧊 แถบล่าง+เมนูข้าง liquid glass · ปุ่มรองกระจกโปร่ง
- **v2.33.1** *(APK + web · BETA)* — 🪟 **แถบหัว (header) เป็นกระจกฝ้า** เปลี่ยนตามธีม + เส้นคั่นบาง · ➕ **ปุ่มลอย (FAB) เป็นกระจกใส** โทน accent โปร่งเบลอ มีขอบ/แสงสะท้อน · 🎨 ขอบแถบล่าง/เมนูข้างปรับตามธีม (เลิก hardcode สีขาว)
- **v2.33.0** *(APK + web · BETA)* — 🪟 **ดีไซน์ใหม่สไตล์กระจกฝ้า (glassmorphism) ทั้งแอป** — การ์ด/เมนู/โมดัล/แถบล่างเป็นพื้นผิวกึ่งโปร่งเบลอ ลอยเหนือพื้นหลังไล่สีพาสเทลนุ่ม · 🎨 ปรับชุดธีมใหม่ให้เข้ากับกระจก โทนอ่อนละมุน (เลิกดำสนิท) ทั้งมืด/สว่าง · ♿ ธีมคมชัดคงพื้นทึบ
- **v2.32.2** *(APK + web · BETA)* — 🎨 **เปลี่ยนอีโมจิ UI ทั้งแอปเป็นไอคอนเส้น (SVG)** สไตล์เดียวกับแถบล่าง (ปุ่ม/หัวข้อ/เมนู/แท็บ/หน้าวิธีใช้/โมดัล) · คงอีโมจิเดิมเฉพาะ เหรียญ/ระดับ/มื้ออาหาร/คำแนะนำ/อวาตาร์/โฆษณา · ตัดธงภาษา 🇹🇭🇬🇧 ออก (เหลือชื่อภาษา)
- **v2.32.1** *(APK + web · BETA)* — ✂️ **ครอปรูปโปรไฟล์/พื้นหลังแบบลากซูมเอง** (หน้าครอปสไตล์โซเชียล · ลาก+แถบซูม · avatar เป็นวงกลม · พื้นหลัง 4:1 · เลิกครอปกึ่งกลางอัตโนมัติ) · 🎨 **ไอคอนเมนูข้างเป็นเส้นโมเดิร์น** (เปลี่ยนจากอีโมจิ) · 🩹 เอาเงาดำจางที่ขอบซ้าย (โผล่ตอนเมนูปิด) ออก
- **v2.32.0** *(APK + web · BETA)* — 👤 **โปรไฟล์โฉมใหม่สไตล์โซเชียล** (รูปปก + avatar ซ้อน + ปุ่มกล้องแก้รูป/พื้นหลัง · แถวสถิติย่อ · ปุ่มแชร์+แก้ไข) · 📂 **เมนูข้างใหม่** (การ์ดผู้ใช้ + ไอคอนวงกลมในเมนู) — สไตล์อ้างอิง FB
- **v2.31.5** *(APK + web · BETA · silent)* — 🌫️ เอา frost ขอบล่างกลับมาแบบ**ไม่เขียว** — ใช้ gradient ไล่จางเป็นสีพื้นแอปแทน backdrop blur (เลี่ยง artifact เขียวบนพื้นดำสนิท) เนื้อหาจางหายที่ขอบล่างเหมือนรูปอ้างอิง (อัปเดตเงียบ)
- **v2.31.4** *(APK + web · BETA · silent)* — 🛠️ แก้แถบเขียวจางที่ขอบล่าง — เอา frosted scrim ออก (backdrop-filter เบลอทับพื้นดำสนิท #000 ทำให้บาง GPU เรนเดอร์เป็นโทนเขียว) + ตัด `saturate()` จากแคปซูล/drawer · คงพื้นดำสนิทไว้ (อัปเดตเงียบ)
- **v2.31.3** *(APK + web · BETA · silent)* — 🛠️ แก้ขอบล่างมีแถบสีจางๆ (วอลเปเปอร์เครื่องโผล่ขึ้นมาเพราะ `html` พื้นหลังโปร่งใส) — ตั้งพื้นหลัง `html` เป็นสีธีม คลุมเต็มจอ (อัปเดตเงียบ · ย้อน v2.31.2 ที่แก้ผิดจุดออก)
- **v2.31.1** *(APK + web · BETA · silent)* — 🌫️ เพิ่มแถบเบลอ (frosted scrim) ด้านล่างหลังแถบแคปซูลที่ลอย — content ที่เลื่อนผ่านช่องล่างจะเบลอแบบในรูปอ้างอิง (อัปเดตเงียบ ไม่เด้ง "มีอะไรใหม่")
- **v2.31.0** *(APK + web · BETA)* — 🌈 วงแหวนไล่สีสเปกตรัม (on-track) · ⬅️ หน้าย่อยปุ่มกลับวงกลม+หัวข้อกึ่งกลาง · 🍱 รายการอาหารมีไอคอนสีประจำมื้อ · 🟢 ป้ายระดับเป็นชิปเขียว · 🎨 เมนูซ้ายธีมกระจกเข้ม · 🔽 dropdown กลางจอ · ✂️ ตัดอีโมจิออกกำลังกาย
- **v2.30.1** *(APK + web · BETA)* — 🎛️ **เมนูเลือก (dropdown) ของแอปเอง** — เลิกใช้ picker ของระบบ (ตัวใหญ่/ไม่เข้าธีม) เปลี่ยนเป็น bottom-sheet ธีมเดียวกับแอป ตัวอักษรเล็กลง (มื้ออาหาร/ประเภทอาหาร/เพศ/กิจกรรม ฯลฯ)
- **v2.30.0** *(APK + web · BETA)* — 🎨 **โฉมใหม่** — ธีมดำสนิท · การ์ดขอบมนใหญ่ · 🛟 แถบเมนูล่างลอยเป็นแคปซูลกระจกไอคอนล้วน (active เป็น pill เทา) · 🟢 ชุดสีสด (เขียว/ฟ้า/เหลือง) บนพื้นดำ
- **v2.29.3** *(APK + web · BETA)* — 🧹 **หน้าค้นหาอาหารโล่งขึ้น** — รวมปุ่มหมวด 16 ปุ่มเป็น **ตัวกรอง dropdown อันเดียว** จัดกลุ่ม "อาหารนานาชาติ" + "ตามประเภท" ไม่รก
- **v2.29.2** *(APK + web · BETA)* — 🍽️ **เพิ่มหมวด "ทั้งหมด"** ในหน้าค้นหาอาหาร (รวมทุกหมวด + อาหารที่เพิ่มเอง · เป็นตัวกรองแรก เลือกอัตโนมัติเมื่อเปิดหน้า)
- **v2.29.1** *(APK + web · BETA)* — 🔖 **ตัวกรองหมวดอาหารใหม่** — หน้าค้นหาเปลี่ยนจากปุ่มธงประเทศ (🇹🇭🇯🇵) เป็นชิปตัวกรองมีชื่อกำกับ ("ไทย"/"ญี่ปุ่น"…) อ่านง่าย แสดงตรงกันทุกเครื่อง
- **v2.29.0** *(APK + web · BETA)* — 📲 **แอป Android อัปเดตเองได้** — เช็ก GitHub Releases ตอนเปิด ถ้ามีใหม่เด้งให้ดาวน์โหลด & ติดตั้ง APK ทันที (เผื่อย้ายไปสโตร์ภายหลัง — แค่ตั้ง `storeUrl`) · 🖥️ **โหมดเต็มจอ ขอบจรดขอบ** (edge-to-edge · ยังเห็นนาฬิกา) ผ่าน MainActivity ที่ commit ไว้ + CI คัดลอกตอน build
- **v2.28.5** *(APK + web · BETA)* — ⚡ **อัปเดตอัตโนมัติทันที** — แอปอัปเดตเป็นเวอร์ชั่นล่าสุดเองเมื่อเปิด ไม่ถาม "อัปเดตไหม" อีก (SW `skipWaiting` + auto-apply) แล้วโชว์ "มีอะไรใหม่" แทน · 🔄 ดึงเวอร์ชั่นใหม่ตอนกลับเข้าแอป — คนที่ค้างเวอร์ชั่นเก่าถูกพาขึ้นล่าสุดอัตโนมัติ
- **v2.28.4** *(APK + web · BETA)* — 🔌 **ขยายการกันค้างไปทุกหน้าที่ดึงเน็ต** (ตรวจครบทุกหน้า) · 👤 โปรไฟล์เพื่อน + ค้นหาเพื่อนใส่ timeout 8 วิ — เน็ตช้าโชว์ "⏳ เน็ตช้า · แตะลองใหม่" ไม่ค้าง "loading…" · ➕ ปุ่มเพิ่มเพื่อนเปิดทันที (เดิมรอโหลดรายชื่อก่อน เน็ตค้าง=กดแล้วเงียบ)
- **v2.28.3** *(APK + web · BETA)* — ⚡ **หน้า Developer โหลดทันที** — ย้ายการนับข้อมูลคลาวด์ไปทำหลังหน้าขึ้น หน้าไม่รอเน็ต · 🟡 เน็ตช้าโชว์ "⏳ เน็ตช้า" แทน Error แดง (count แบบ exact ของ Supabase ช้าเมื่อเน็ตไม่ดี — ทำให้ degrade นุ่มนวล)
- **v2.28.2** *(APK + web · BETA)* — 🔧 แก้**หน้า Developer ค้างโหลด** (เดิมค้าง "Collecting diagnostics…" ถ้า Supabase ตอบช้า — ใส่ timeout ทุก cloud probe สูงสุด ~5 วิ) · 🛡️ กันหน้าแบบ async ค้างเงียบ (log แทนค้าง) · ✅ ตรวจครบทุกหน้ารวม Developer — ไม่มี error ค้างหน้าใดเลย
- **v2.28.1** *(APK + web · BETA)* — 🔧 แก้สลับหน้าแล้วข้อมูลไม่โหลด (render แต่ละหน้ากันพังแยกกัน · ไม่ต้องรีเฟรชเองอีก) · 🔄 อัปเดตหน้าอัตโนมัติหลังดึงข้อมูลจากคลาวด์ · 📡 กระดานผู้นำมีปุ่มลองใหม่ ไม่ค้างโหลด
- **v2.28.0** *(APK + web · BETA)* — ⚡ **เพิ่มด่วน 1 แตะ** (แถวอาหารล่าสุด/โปรดบนหน้าแรก · แตะเดียวบันทึก) · 🍽️ empty state ชวนลงมือ (หน้าแรก + โปรด/ล่าสุด) · 👋 ปุ่ม + กระพริบนำมือใหม่ — ลดแรงเสียดทานการบันทึกตามหลัก UX
- **v2.27.1** *(APK + web · BETA)* — ⏱️ เลือกมื้ออัตโนมัติตามเวลา (ตัด 1 แตะตอนบันทึก) · 🍽️ หน้าว่างมีปุ่มชวนบันทึก — ลดแรงเสียดทานตามหลัก UX (ผู้ช่วยออกแบบ)
- **v2.27.0** *(APK + web · BETA)* — 💀 skeleton loading + shimmer เวลาโหลดข้อมูล · 📐 accordion หน้าวิธีใช้งาน · 💬 กล่อง popup เองทั้งหมด (เลิก alert/confirm/prompt ระบบ) · 💡 tooltip ใหม่ (เลิก title เบราว์เซอร์)
- **v2.26.0** *(APK + web · BETA)* — ⚖️ **แนวโน้มน้ำหนักใหม่ทั้งหมด** (energy-balance จริง: กิน − TDEE − ออกกำลังกาย · ยึดน้ำหนักที่ชั่งจริง · พยากรณ์ 7 วัน) · 🎯 แก้ baseline ที่เคยใช้ "เป้าหมาย" แทน TDEE · 🧮 รวมสูตร BMR/TDEE/goal เป็นจุดเดียว (ตรวจ BMI/bodyfat/มาโครถูกหมด) · 🐞 แก้เส้นเป้าหมาย+ETA ที่ไม่เคยขึ้น
- **v2.25.0** *(APK + web · BETA)* — 📅 **ปฏิทินเลือกวันที่ใหม่ในแอป** (มินิมอล · มีจุดบอกวันที่บันทึก · ไม่ใช้ปฏิทินระบบ) · 🎨 แถบวันที่หน้าแรกเป็นปุ่มมน เว้นระยะจากหัว · 💧 การ์ดน้ำดื่มกระชับขึ้น (−/+ เล็กลง inline)
- **v2.24.3** *(APK + web · BETA)* — 🐞 แก้โปรไฟล์เพื่อนโชว์ Lv 1/streak 0 ผิด (คนไม่ใช่เพื่อนเห็นสถิติ 0 ทั้งที่ติดอันดับ) · 🩹 แก้ซิงค์บัญชีไม่ล็อกอินพังจาก foreign key (regression 2.24.2) — เจอ + แก้จากการทดสอบผ่าน preview
- **v2.24.2** *(APK + web · BETA)* — 🧹 กันบัญชีไม่ล็อกอิน (anonymous) ขึ้นกระดานผู้นำ — เดิมโผล่เป็น "Test User" รก (เจอจากการตรวจระบบ Supabase) · 🏅 leaderboard แสดงเฉพาะสมาชิกที่ตั้งชื่อแล้ว
- **v2.24.1** *(APK + web · BETA)* — 🖼️ banner รูปแสดงในโปรไฟล์เพื่อน + ข้ามเครื่อง · 🏅 เหรียญตราซิงค์คลาวด์ (เพื่อนเห็น + ไม่หายตอนใช้เครื่องใหม่) · 📊 คะแนน leaderboard ตรงกันทุกเครื่อง (ใช้เป้าหมายเจ้าของ ไม่ใช่ผู้ดู)
- **v2.24.0** *(APK + web · BETA)* — ☁️ **ซิงค์แม้ไม่ได้ล็อคอิน** (anonymous Supabase session · ข้อมูลผูกกับเครื่องนี้จนกว่าจะล็อคอิน) · 🔄 **ย้ายข้อมูลอัตโนมัติเมื่อล็อคอิน** · 🏆 fix คะแนน 0 ของคนไม่ใช่เพื่อน (RPC รวมยอดต่อวัน) · 🔁 หน้าแรกรีโหลดเมื่อเปลี่ยน tab · 🧹 ลบหัวข้อ "เหลือ" + "จำนวนรายการ" · ✏️ test user → Test User
- **v2.23.0** *(APK + web · BETA)* — 🌍 **Global leaderboard ดูได้แม้ไม่ล็อกอิน** (Friends tab ต้อง login) · 📊 แคล/น้ำ 7d↔30d toggle + auto-resize · 🎮 Steam profile · Level 1-10 · banner upload + crop · ✏️ edit/measurements ซ่อนเป็น default · 📌 sticky header · 🤳 iOS no-zoom · ✕ friend profile close ในหัว + footer
- **v2.22.0** *(APK + web · BETA)* — ✨ **Friends + Leaderboard GA** · ⚡ Service Worker stale-while-revalidate · 🌐 บายพาส API (Supabase/Gemini/OpenAI/Claude) · ♿ ARIA dialog + role บน leaderboard · 🧹 i18n holdouts (dev mode + sign-in)
- **v2.21.0** *(APK + web · BETA)* — 🎮 **โปรไฟล์ Steam-style** · banner สี · level · badges showcase · bio · 👥 **ดูโปรไฟล์เพื่อนได้** · 🤖 AI ถ่ายรูปฟรี 20/วัน · 🍱 อาหารเพิ่มเป็น 250 · 🎨 default ใหม่ (Prompt + light + nav 5 tabs) · 🔔 ขอ notification permission auto · 📈 weight chart ใหม่ · 🛠️ Capacitor 8 + JDK 21 + Android 15
- **v2.20.0** *(APK + web · BETA)* — 🎨 **UX pass** · **🎯 modals กลางจอ** (เลิก bottom-sheet) · **🤖 AI live status + spinner + heartbeat + "เหลือ N/20"** chip · **🔒 AI members-only** (กัน proxy abuse) · **🍱 Add Food ใหม่** (search top · favorites bottom) · **📉 weight chart 14 วันย้อนหลังเท่านั้น** (no future) · **🏆 badges ถาวร** (localStorage `cp_earned_badges`)
- **v2.19.3** *(APK + web · BETA)* — 🐞 **แก้ AI photo "sign-in timed out"** · `signInAnonymously()` deadlock → ใช้ REST `POST /auth/v1/signup` ตรงๆ ไม่ผ่าน SDK lock
- **v2.19.2** *(APK + web · BETA)* — 🐞 **แก้ AI photo "invalid_jwt"** · stale anon session ถูก auto-wipe + re-sign-in + retry once
- **v2.19.1** *(APK + web · BETA)* — 🐞 **Hotfix AI photo ค้าง** · `getSession()` ของ supabase-js v2 deadlock จาก navigator-lock → อ่าน session จาก localStorage ตรงๆ + anon sign-in fallback · เปลี่ยน Gemini model default จาก 2.0-flash → 2.5-flash (free tier ใหม่)
- **v2.19.0** *(APK + web · BETA)* — 🚀 **Mega-release: Growth + AI** · **🤖 AI ถ่ายรูปอาหาร ฟรี** ผ่าน Supabase Edge Function proxy (20 รูป/วัน/คน · BYO key ได้) — Claude/OpenAI/Gemini/Custom · **🔥 Streak-saver** push 21:30 · **🎉 Milestone share อัตโนมัติ** 7/14/30/60/100 · **🎁 Referral link** + badge · **Daily check-in toast** · **Onboarding telemetry** · 5 badges ใหม่ (streak14/30/60/100 + referred)
- **v2.18.3** *(APK + web · BETA)* — 🤝 **เปิดใช้งานลิงก์ Affiliate จริง** (Lazada + Shopee) · ปรับชื่อสินค้าให้ตรงกับลิงก์จริง: เวย์ · เชือกกระโดดถ่วงน้ำหนัก · ทดแทนมื้อ · อาหารคลีน · โปรตีนซีเรียล · ผักเคลกรอบ · ธัญพืชรวม · CP อกไก่ (รวม 8 สินค้า)
- **v2.18.2** *(APK + web · BETA)* — 📺 **โฆษณา Affiliate Phase 1** — banner ในหน้าวันนี้ + หน้าวิเคราะห์ · สนับสนุนการพัฒนาแอป · กด × เพื่อปิดในแต่ละ session · escape hatch ผ่าน `settings.adsHidden` · `rel="nofollow sponsored"`
- **v2.18.1** *(web only · BETA)* — 🔐 ปรับปรุงระบบรักษาความปลอดภัย Developer Mode
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
