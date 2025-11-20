# DRIP (Disaster Relief Integration Platform) — Architecture & Delivery Spec
**Version:** 2025-11-20  
**Status:** Final / SSoT  
**Targets:** Flutter (mobile/web), Supabase (Postgres 15)  
**Purpose:** Replace prior draft with a concise, testable architecture that passes CI (Vercel) and satisfies feature spec + bilingual UX requirements.

---

## 0. Build/Deployment Baseline (Vercel + Flutter Web)
- SDK: Flutter 3.38.1 (pinned in `vercel_build.sh`), Dart 3.10.0, web target = CanvasKit (Skia) with wasm dry-run warnings ignored (`isar` uses `dart:ffi`; web build still uses dart2js).
- Command: `bash vercel_build.sh` (ensures SUPABASE_URL / SUPABASE_ANON_KEY present). If needed, add `--no-wasm-dry-run` to the flutter build line to silence wasm warnings.
- Do **not** run Flutter as root; Vercel sandbox prints warnings but builds fine.
- Lints/format: `dart format .` before commit; no analyzer override changes required for build.
- Known constraint: Offline cache (Isar) is native-only; web falls back to network-first (no FFI).

---

## 1. System Overview
- **Frontend:** Flutter (Material 3), Riverpod 2.x, GoRouter 14, Dio (edge calls), Google Maps (mobile), l10n (en-US / zh-TW). Offline cache with Isar (mobile/desktop).
- **Backend:** Supabase (Auth + Postgres + Realtime). PostGIS, pg_cron. Edge Functions for privileged flows (role promotion, FCM fan-out).
- **Security:** Strong RLS, field-level triggers, audit logs, masked PII, MFA recommended for elevated roles.
- **Domains:** Announcements, Tasks, Shuttles, Resource Points, Profiles/Identity, Chat.

---

## 2. Cross-Language Strategy (UI vs Content)
- UI strings: Controlled by `user_settings.language` (fallback `profiles_public.locale`). Two options: `zh-TW`, `en-US`. Toggle in Profile Settings → saves to both tables.
- Content fields (titles/bodies): Stored as jsonb with `zh-TW`/`en-US` keys; no input language enforcement. Display rule: `preferredLang` value, else `fallbackLang`.
- Flutter helper: `localizedText(jsonMap, prefLang)` (see `lib/core/localization/localized_text.dart`).
- App locale wiring: `localeController` (Riverpod) loads/syncs language; `MaterialApp.locale` bound to controller; GoRouter unaffected.

---

## 3. Architecture (Frontend)
- **State:** Riverpod providers for auth, locale, features (tasks/shuttles/resources). Avoid global mutable singletons.
- **Navigation:** GoRouter tree  
  `/login`, `/register`, `/home`, `/map` (+resources/create), `/tasks` (+create, :id), `/shuttles` (+:id), `/profile` (+settings).
- **Data Flow:** Repositories call Supabase; models via Freezed/JsonSerializable. Offline: on mobile, cache reads to Isar; writes remain online-only.
- **UI Composition:** Feature-first directories; shared widgets in `core/widgets`; theming in `core/theme`.
- **Maps:** `google_maps_flutter` mobile; web map deferred (spec allows Desktop/Mobile priority).
- **Error/Empty:** Use toasts/modals per feature spec; 30-day TTL chat history (aligned with backend).

---

## 4. Architecture (Backend / Supabase)
### 4.1 Identity & Settings
- Tables: `profiles_public(id, display_id, nickname, role, masked_phone, locale, avatar_url, created_at, updated_at)`; `profiles_private(id, email, full_name, real_phone, privacy_settings)`; `user_settings(user_id, language, timezone, push_enabled, updated_at)`.
- Sync: Locale updates write to `user_settings.language` + `profiles_public.locale`.

### 4.2 Content Entities
- **Announcements:** `title jsonb`, `body jsonb` (both require zh-TW & en-US keys), `type general|emergency`, `is_pinned`, unique active emergency constraint.
- **Resource Points:** `title jsonb`, `description jsonb`, category `permanent|temporary`, geohash-6, PostGIS indexes.
- **Tasks:** `display_id`, `status open|in_progress|done|canceled`, `is_priority` (Leader+ only), participant_count maintained by trigger; geohash.
- **Shuttles:** `display_id`, route (origin/destination geog + geohash), seats_total/taken, vehicle, contact_phone_masked, schedule fields.
- **Participants/Messages:** `task_participants`, `shuttle_participants`, `task_messages`, `shuttle_messages` with 30-day expiry enforced by cron.

### 4.3 Business Logic (Triggers/RPC)
- Rate limit: 1 task create/hour for User/Superuser (Leader+ exempt).
- Priority guard: `is_priority` change requires Leader+.
- Capacity guard: shuttle insert enforces seats_taken < seats_total.
- Counters: participant/message sync triggers keep aggregates.
- Geodata: geohash setters on resource/task/shuttle.
- RPC: `join_shuttle` (transaction: lock, capacity check, insert, increment), `admin_appoint_role` (role promotion).

### 4.4 RLS (summary)
- Public read: announcements, resource_points; Auth read on shuttles; tasks readable by all.
- Mutations require auth and ownership or elevated role (Leader+/Admin+/Superadmin per table).
- Messages/participants restricted to members, owners, or Leader+.
- Referral codes/audit logs admin-only.

---

## 5. Security & Privacy
- PII split public/private; masked phone/email in public views.
- TLS in-transit, AES-256 at-rest (Supabase managed). Secrets in env; no hard-coded keys.
- Audit: `audit_logs` insert-only; retain ≥1y. Events: role promotion, referral issuance, task/shuttle creation/delete, visibility toggles, policy breaches.
- MFA recommended for Leader/Admin/Superadmin; App Check enforced for clients.
- A11y: minimum tappable 44x44, contrast 4.5:1, marquee non-blocking.

---

## 6. Feature Surfaces (per specs_feature)
- P01 Home: hero + CTA, notifications icon, profile shortcut.
- P04 Announcements list: pinned emergency, marquee bottom.
- P05/P06/P07 Shuttles: list/filter, detail with chat, tabs (created/joined/history), join/leave capacity-aware.
- P08/P09/P10 Tasks: list/detail/chat, join modal with visibility flag.
- P11 Map: pins for resources/tasks/shuttles, bottom sheet detail, navigation deeplink to Google Maps.
- P12 Admin center: role review/referral (Admin+).
- P13 Profile: profile card, settings -> language toggle, privacy/notifications (stubs).

---

## 7. Non-Functional & Ops
- Observability: Crashlytics (mobile), GA4 events (`shuttle_join/leave/full/complete`, `task_join/leave/complete`, `emergency_announcement_view`, `map_navigation_click`).
- Performance: Cache-first reads with background refresh; paginate lists; sort per spec (`priority desc, departAt asc, createdAt desc`).
- Cleanup: pg_cron daily prune `*_messages` older than 30 days.
- Backups: Supabase PITR enabled (per org policy).
- CI/CD: Vercel build via `vercel_build.sh`; run `dart format .` and `flutter test` (unit) where available.

---

## 8. Immediate Fix Applied (build blocker)
- Riverpod `AsyncError` in `locale_controller` adjusted to match 2.6.1 signature (removed `previous` argument); keeps fallback state by resetting after error. This resolves the Vercel compile failure.

---

## 9. Future Enhancements / Risks
- Web offline cache: replace Isar on web with in-memory or `shared_preferences`; currently network-first on web.
- Map on web: add web map provider or disable map tab when unsupported.
- Auth flows: add LINE OAuth (currently stubbed); enable MFA prompt for elevated roles.
- Tests: add unit tests for localization fallback and geohash triggers (SQL).
- Dependency drift: many packages outdated; schedule upgrade ticket (Riverpod 3, GoRouter 17, Isar 3 with web Wasm).

---

**End of document.**
