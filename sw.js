// CalPro Service Worker — offline cache
const VERSION = '2.29.3';
const CACHE = 'calpro-v' + VERSION;
const ASSETS = [
  './',
  './calpro-app.html',
  './manifest.webmanifest',
  './icon-192.png',
  './icon-512.png',
  './apple-touch-icon.png'
];

self.addEventListener('install', (e) => {
  // FORCE UPDATE: activate the new worker immediately instead of waiting for the
  // user to confirm. Combined with clients.claim() on activate + the page's
  // controllerchange→reload listener, every user is auto-pulled to the latest
  // version the moment they open the app — no "update available?" prompt. They
  // see the "What's new" popup afterwards instead.
  self.skipWaiting();
  e.waitUntil(
    caches.open(CACHE).then(c => c.addAll(ASSETS).catch(() => null))
  );
});

self.addEventListener('activate', (e) => {
  e.waitUntil(
    caches.keys()
      .then(keys => Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

// Listen for message from page to skip waiting (user clicked "refresh now")
self.addEventListener('message', (e) => {
  if (e.data && e.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
});

// Notification click — bring app to foreground (or open if closed)
self.addEventListener('notificationclick', (e) => {
  e.notification.close();
  e.waitUntil((async () => {
    const all = await self.clients.matchAll({ type: 'window', includeUncontrolled: true });
    for (const c of all) {
      if ('focus' in c) return c.focus();
    }
    if (self.clients.openWindow) return self.clients.openWindow('./');
  })());
});

// Stale-while-revalidate for the main HTML — serve cache fast,
// then refresh in background. Other assets stay cache-first.
// Skip Supabase + AI provider URLs entirely — they have their own
// auth/CORS rules and shouldn't be cached.
const STALE_WHILE_REVALIDATE_PATHS = ['./calpro-app.html', './'];

self.addEventListener('fetch', (e) => {
  const req = e.request;
  if (req.method !== 'GET') return;
  const url = new URL(req.url);
  // Bypass API hosts — never cache, always go straight to network.
  if (/supabase\.co|generativelanguage\.googleapis\.com|api\.anthropic\.com|api\.openai\.com/.test(url.hostname)) {
    return; // let the network handle it
  }
  // Stale-while-revalidate for index HTML — same-origin only
  const isSWR = url.origin === self.location.origin &&
    STALE_WHILE_REVALIDATE_PATHS.some(p => url.pathname.endsWith(p) || url.pathname.endsWith(p.slice(1)));
  if (isSWR) {
    e.respondWith((async () => {
      const cached = await caches.match(req);
      const fetchPromise = fetch(req).then(res => {
        if (res && res.status === 200 && res.type === 'basic') {
          const copy = res.clone();
          caches.open(CACHE).then(c => c.put(req, copy)).catch(() => {});
        }
        return res;
      }).catch(() => null);
      return cached || (await fetchPromise) || caches.match('./calpro-app.html');
    })());
    return;
  }
  // Cache-first for everything else (icons, manifest, fonts via google CDN, etc.)
  e.respondWith(
    caches.match(req).then(hit => {
      if (hit) return hit;
      return fetch(req).then(res => {
        if (res && res.status === 200 && res.type === 'basic') {
          const copy = res.clone();
          caches.open(CACHE).then(c => c.put(req, copy)).catch(() => {});
        }
        return res;
      }).catch(() => caches.match('./calpro-app.html'));
    })
  );
});
