/* Custom service worker for PWA caching */
importScripts('https://storage.googleapis.com/workbox-cdn/releases/6.5.4/workbox-sw.js');

if (self.workbox) {
  // Cache static assets (images, fonts, icons)
  workbox.routing.registerRoute(
    ({request}) =>
      request.destination === 'image' || request.destination === 'font',
    new workbox.strategies.CacheFirst({
      cacheName: 'static-assets',
      plugins: [
        new workbox.expiration.ExpirationPlugin({
          maxEntries: 60,
          maxAgeSeconds: 30 * 24 * 60 * 60, // 30 days
        }),
      ],
    }),
  );

  // Stale-while-revalidate for Supabase REST calls
  workbox.routing.registerRoute(
    ({url}) => url.pathname.startsWith('/rest/v1/'),
    new workbox.strategies.StaleWhileRevalidate({
      cacheName: 'supabase-api',
      plugins: [
        new workbox.expiration.ExpirationPlugin({
          maxEntries: 120,
          maxAgeSeconds: 5 * 60, // 5 minutes
        }),
      ],
    }),
  );

  // Network-first for auth endpoints
  workbox.routing.registerRoute(
    ({url}) => url.pathname.includes('/auth/'),
    new workbox.strategies.NetworkFirst({cacheName: 'auth-cache'}),
  );

  workbox.core.clientsClaim();
  workbox.core.skipWaiting();
} else {
  console.warn('Workbox failed to load; offline caching disabled.');
}
