#!/usr/bin/env node
// Copies PWA assets into ./www/ so Capacitor can sync them into native projects.
// Capacitor expects an index.html at the root of webDir.

const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');
const WWW = path.join(ROOT, 'www');

// Reset www/
if (fs.existsSync(WWW)) {
  fs.rmSync(WWW, { recursive: true, force: true });
}
fs.mkdirSync(WWW, { recursive: true });

// Files to copy. calpro-app.html becomes index.html so Capacitor finds it.
const files = [
  { src: 'calpro-app.html', dst: 'index.html' },
  { src: 'manifest.webmanifest', dst: 'manifest.webmanifest' },
  { src: 'sw.js', dst: 'sw.js' },
  { src: 'icon-192.png', dst: 'icon-192.png' },
  { src: 'icon-512.png', dst: 'icon-512.png' },
  { src: 'icon-maskable-512.png', dst: 'icon-maskable-512.png' },
  { src: 'apple-touch-icon.png', dst: 'apple-touch-icon.png' },
  { src: 'favicon-32.png', dst: 'favicon-32.png' },
];

for (const f of files) {
  const srcPath = path.join(ROOT, f.src);
  const dstPath = path.join(WWW, f.dst);
  if (!fs.existsSync(srcPath)) {
    console.warn(`[prepare-www] missing source: ${f.src}`);
    continue;
  }
  fs.copyFileSync(srcPath, dstPath);
  console.log(`[prepare-www] ${f.src} → www/${f.dst}`);
}

// Patch index.html: rewrite manifest href + service worker path so they resolve
// inside the Capacitor webview (which serves from app://localhost/).
const idx = path.join(WWW, 'index.html');
let html = fs.readFileSync(idx, 'utf8');
// SW registration is fine as-is (sw.js sits next to index.html).
// Make sure title tag exists (Capacitor uses it on iOS).
if (!/<title>/.test(html)) {
  html = html.replace('<head>', '<head>\n<title>CalPro+</title>');
}
fs.writeFileSync(idx, html);

console.log('[prepare-www] done.');
