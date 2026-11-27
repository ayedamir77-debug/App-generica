// Service worker: rende l'app installabile e la fa aprire anche senza internet.
// Pagina e file dell'app: prima la rete (così gli aggiornamenti arrivano subito), se manca la rete usa la copia salvata.
// Librerie esterne (Supabase, OCR, PDF): copia salvata, aggiornata in sottofondo.
// Le chiamate ai dati (Supabase) non vengono mai salvate.
const CACHE = 'cantiere-v2';
self.addEventListener('install', () => self.skipWaiting());
self.addEventListener('activate', (e) => e.waitUntil((async () => {
  for (const k of await caches.keys()) if (k !== CACHE) await caches.delete(k);
  await self.clients.claim();
})()));
self.addEventListener('fetch', (e) => {
  const req = e.request, url = new URL(req.url);
  if (req.method !== 'GET') return;
  if (url.hostname.endsWith('.supabase.co') || url.hostname.endsWith('radio-browser.info') || url.hostname.includes('open-meteo.com')) return;
  const lib = url.hostname === 'esm.sh' || url.hostname === 'cdn.jsdelivr.net';
  if (url.origin === location.origin) {
    e.respondWith((async () => {
      try { const r = await fetch(req, { cache: 'no-cache' }); if (r.ok) (await caches.open(CACHE)).put(req, r.clone()); return r; }
      catch { return (await caches.match(req)) || (await caches.match('./index.html')) || Response.error(); }
    })());
  } else if (lib) {
    e.respondWith((async () => {
      const c = await caches.open(CACHE), hit = await c.match(req);
      const net = fetch(req).then((r) => { if (r.ok) c.put(req, r.clone()); return r; }).catch(() => hit);
      return hit || net;
    })());
  }
});

// Notifiche push (anche a telefono bloccato)
const STILI = {
  chat: { vibrate: [120, 60, 120], tag: 'chat' },
  lavoro: { vibrate: [250, 100, 250, 100, 250], tag: 'lavoro' },
  ferie: { vibrate: [200], tag: 'ferie' },
  test: { vibrate: [100, 50, 100] }
};
const tipoDa = (u) => { try { return new URL(u, self.location.href).searchParams.get('n') || ''; } catch { return ''; } };
self.addEventListener('push', (e) => {
  let d = {}; try { d = e.data ? e.data.json() : {}; } catch { d = { body: e.data && e.data.text() }; }
  const t = tipoDa(d.url || ''), st = STILI[t] || {};
  e.waitUntil(self.registration.showNotification(d.title || 'Cantiere in Tasca', {
    body: d.body || '', icon: 'icon-192.png', badge: 'badge-96.png', vibrate: st.vibrate, tag: st.tag, renotify: !!st.tag,
    actions: t ? [{ action: 'open', title: 'Apri' }] : [], data: { url: d.url || './', n: t }
  }));
});
self.addEventListener('notificationclick', (e) => {
  e.notification.close();
  const n = (e.notification.data && e.notification.data.n) || '';
  e.waitUntil((async () => {
    const all = await clients.matchAll({ type: 'window', includeUncontrolled: true });
    for (const c of all) { if ('focus' in c) { c.postMessage({ go: n }); return c.focus(); } }
    return clients.openWindow((e.notification.data && e.notification.data.url) || './');
  })());
});
