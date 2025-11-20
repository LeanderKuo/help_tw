# Disaster Relief Platform - Development Roadmap & Issue Tracker

**Version:** 2025-01-21
**Status:** Active Development
**Spec Reference:** `specs_feature.md`

---

## Table of Contents

1. [Critical Issues Summary](#critical-issues-summary)
2. [High Priority Tasks](#high-priority-tasks)
3. [Medium Priority Tasks](#medium-priority-tasks)
4. [Low Priority Tasks](#low-priority-tasks)
5. [Code Quality Guidelines](#code-quality-guidelines)
6. [Implementation Order](#implementation-order)

---

## Critical Issues Summary

### Severity: HIGH (Blocking Core Features)

1. **Incomplete RBAC Implementation**
   - Missing: Invite/referral system, admin review panel (P12), approval queue, MFA, App Check
   - Impact: Multi-step user onboarding (User→Superuser→Leader→Admin) cannot function
   - Files: `lib/features/...`, `specs_feature.md`

2. **Auth System Gaps**
   - Current: Email/password + Google OAuth only
   - Missing: LINE login (disabled), Phone OTP, MFA, App Check
   - Impact: Spec-required auth methods unavailable
   - Files: `lib/features/auth/data/auth_repository.dart`, `login_screen.dart`, `register_screen.dart`

3. **Shuttle Module Incomplete**
   - Missing: Creation page (button shows toast only), participant/role management, chat UI
   - Data collection gaps: origin/destination, capacity, schedule, contact fields
   - Impact: Database inserts will fail against current Supabase schema
   - Files: `lib/features/shuttles/presentation/shuttle_list_screen.dart`, `shuttle_detail_screen.dart`

4. **Task Flows Insufficient**
   - Create form missing: location, required roles, participant caps, visibility toggle, materials status
   - Missing: Join/leave rule enforcement, 30-day chat retention, participant list UI
   - Files: `lib/features/tasks/presentation/create_task_screen.dart`, `task_detail_screen.dart`, `task_repository.dart`

5. **Map/Resource Features Incomplete**
   - Map displays only resource points (no tasks/shuttles)
   - Resource creation: hardcoded Taipei coordinates, no geohash deduplication, no contact masking
   - Files: `lib/features/map/presentation/map_screen.dart`, `features/resources/presentation/resource_list_screen.dart`, `create_resource_screen.dart`

6. **Security: Exposed Secrets**
   - Google Maps API keys hardcoded in Flutter config and web HTML
   - Required: Environment variable injection
   - Files: `lib/core/config/app_config.dart`, `web/index.html`

### Severity: MEDIUM (Experience & Contract Issues)

1. **Frontend-Backend Contract Mismatches**
   - Schema requires non-null `origin`/`destination`, `author_id`/`created_by` under RLS
   - Current create flows don't collect/pass these fields → operations will fail
   - Files: `supabase_schema.sql`, `create_task_screen.dart`, `create_resource_screen.dart`, shuttle UI

2. **Missing PWA/Offline Support**
   - No Workbox caching, no IndexedDB/localStorage strategy
   - Manifest remains Flutter default
   - Files: `web/manifest.json`, missing service worker setup

3. **Version/SDK Drift**
   - Code uses `Color.withValues` (newer Flutter API)
   - `pubspec.yaml` pins `sdk: ^3.10.0`, but Vercel build downloads `3.38.1`
   - Impact: Local builds on 3.10 will fail
   - Files: `pubspec.yaml`, multiple widgets

4. **Uninitialized Firebase Services**
   - Firebase messaging/analytics dependencies declared but not initialized
   - No Supabase user device registration, no audit-log client hooks
   - Files: `pubspec.yaml`, `lib/services`

---

## High Priority Tasks

### Phase 1: Core Missing Pages (Est. 20-25 hours)

#### Task 1.1: P07 "My Shuttles" Page
**File:** `lib/features/shuttles/presentation/my_shuttles_screen.dart`

- [ ] Create `MyShuttlesScreen` with tab navigation
- [ ] Implement tabs: **Hosting** / **Joined** / **History**
- [ ] Filter logic:
  - Hosting: `created_by = currentUser.id`
  - Joined: `shuttle_participants` contains current user
  - History: `status IN ('done', 'canceled')`
- [ ] Action buttons:
  - **Edit** (owner only)
  - **Complete** (owner or Leader+)
  - **Delete** (owner, with confirmation)
- [ ] Add route: `/shuttles/my`
- [ ] Wire to bottom navigation bar

**Acceptance Criteria:**
- User can view shuttles they created/joined separately
- Historical shuttles are archived after 7 days from `depart_at`
- Role-based actions enforced

---

#### Task 1.2: P10 "My Tasks" Page
**File:** `lib/features/tasks/presentation/my_tasks_screen.dart`

- [ ] Create `MyTasksScreen` with tab navigation
- [ ] Implement tabs: **Created** / **In Progress** / **History**
- [ ] Filter logic:
  - Created: `author_id = currentUser.id`
  - In Progress: `task_participants` contains user AND `status = 'in_progress'`
  - History: `status IN ('done', 'canceled')`
- [ ] Action buttons:
  - **Edit** (author only)
  - **Complete** (author or Leader+)
  - **Delete** (author, with confirmation)
- [ ] Add route: `/tasks/my`
- [ ] Wire to task list screen

**Acceptance Criteria:**
- Clear separation between authored and participated tasks
- Status transitions properly update tabs
- Historical tasks maintain chat access (until 30-day expiry)

---

#### Task 1.3: P12 "Admin Panel" Page
**File:** `lib/features/admin/presentation/admin_panel_screen.dart`

**Prerequisites:** Task 4.1 (Referral Code Repository)

- [ ] Create `AdminPanelScreen` (permission: Admin+)
- [ ] Implement 3 tabs:

  **Tab 1: User Management**
  - [ ] User list with search/filter (by role, status)
  - [ ] Role promotion UI:
    - Superuser → Leader (requires unit/reason review)
    - Leader → Admin (requires referral code + Superadmin final approval)
  - [ ] Display pending approval queue
  - [ ] Approve/Reject actions (write to `audit_logs`)

  **Tab 2: Referral Code Management**
  - [ ] Generate referral code (max 1 active per Admin, TTL 1 hour)
  - [ ] Display current code status (code, created_at, expires_at, used_count)
  - [ ] Idempotency check (prevent duplicate active codes)
  - [ ] Revoke code button

  **Tab 3: Audit Logs**
  - [ ] Query `audit_logs` table
  - [ ] Filters: date range, operation type, role, user_id
  - [ ] Paginated list view (50 entries per page)
  - [ ] Export to CSV functionality

- [ ] Add route: `/admin` (with role guard)
- [ ] Wire to profile menu (visible only to Admin+)

**Database Support:**
- ✅ `referral_codes` table exists
- ✅ `audit_logs` table exists
- ✅ RLS policies support role checks

**Acceptance Criteria:**
- Admin cannot generate >1 active referral code
- Superadmin sees all pending Leader→Admin promotions
- All approval/rejection actions logged to audit_logs

---

#### Task 1.4: "Create Shuttle" Page
**File:** `lib/features/shuttles/presentation/create_shuttle_screen.dart`

- [ ] Create form with fields:
  - **Title** (required, max 100 chars)
  - **Description** (optional, max 500 chars)
  - **Origin** (map picker + address autocomplete)
  - **Destination** (map picker + address autocomplete)
  - **Departure Time** (datetime picker, must be future)
  - **Arrival Time** (optional, must be after departure)
  - **Total Seats** (number, min 1, max 100)
  - **Cost per Seat** (number, optional)
  - **Vehicle Info** (type: van/bus/truck/other, plate number)
  - **Contact Name** (optional, defaults to user profile)
  - **Contact Phone** (masked in public view)
  - **Priority** (checkbox, visible only to Leader+)

- [ ] Permission check: User+ can create (policy may require Superuser+)
- [ ] Auto-generate `display_id` (e.g., `S-001234`)
- [ ] Calculate geohash for origin/destination (precision 6)
- [ ] Set `created_by = auth.uid()`
- [ ] Validate required fields match schema
- [ ] Add route: `/shuttles/create`
- [ ] Remove "TODO: Wire creation page" toast from `shuttle_list_screen.dart`

**Schema Alignment:**
```sql
-- Required fields per supabase_schema.sql
origin geography(point, 4326) NOT NULL
destination geography(point, 4326) NOT NULL
depart_at timestamptz NOT NULL
seats_total int NOT NULL
created_by uuid NOT NULL REFERENCES auth.users(id)
```

**Acceptance Criteria:**
- Form validation prevents submission of incomplete data
- Database insert succeeds with RLS enabled
- User is auto-joined as participant with `role = 'driver'`

---

#### Task 1.5: Implement Google Maps Navigation Deep Links
**Files:**
- `lib/features/shuttles/presentation/shuttle_list_screen.dart`
- `lib/features/shuttles/presentation/shuttle_detail_screen.dart`
- `lib/features/tasks/presentation/task_list_screen.dart`
- `lib/features/resources/presentation/resource_list_screen.dart`

**Prerequisites:** `url_launcher` package (✅ already in pubspec.yaml)

- [ ] Create utility function:
  **File:** `lib/core/utils/navigation_utils.dart`
  ```dart
  import 'package:url_launcher/url_launcher.dart';

  Future<void> launchGoogleMapsNavigation({
    required double lat,
    required double lng,
  }) async {
    final url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng'
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch Google Maps';
    }
  }
  ```

- [ ] Replace all empty `IconButton(onPressed: () {})` with actual navigation calls
- [ ] Test on Web, Android, iOS:
  - Web: Opens Google Maps in new tab
  - Mobile: Opens Google Maps app or browser

**Acceptance Criteria:**
- Navigation button works on all platforms
- Coordinates are accurate (no hardcoded Taipei defaults)
- Error handling for missing location data

---

#### Task 1.6: Add Chat UI to Shuttle Detail Page
**File:** `lib/features/shuttles/presentation/shuttle_detail_screen.dart`

**Prerequisites:** `lib/features/chat/data/chat_repository.dart` (✅ exists)

- [ ] Remove `Text('TODO: Chat messages...')` placeholder
- [ ] Integrate `ChatBox` widget (reference `task_detail_screen.dart` implementation)
- [ ] Subscribe to `shuttle_messages` stream:
  ```dart
  final messagesAsync = ref.watch(
    shuttleMessagesProvider(widget.shuttleId)
  );
  ```
- [ ] Display chat messages with:
  - Author name/avatar
  - Message text
  - Timestamp (using `timeago` package)
- [ ] Input field with send button (fixed at bottom)
- [ ] Visibility: Only participants can see/send messages
- [ ] Auto-scroll to latest message on new entry

**Database Support:**
- ✅ `shuttle_messages` table exists
- ✅ `expires_at` auto-set to 30 days
- ✅ RLS policies restrict to participants

**Acceptance Criteria:**
- Non-participants see "Join this shuttle to view chat"
- Messages sync in real-time via Supabase subscriptions
- Expired messages (>30 days) not displayed

---

### Phase 2: Authentication & Security (Est. 15-20 hours)

#### Task 2.1: Implement Phone OTP Authentication
**Files:**
- `lib/features/auth/presentation/phone_login_screen.dart` (new)
- `lib/features/auth/data/auth_repository.dart` (update)

- [ ] Create `PhoneLoginScreen` with:
  - Phone number input (with country code picker, default +886 for Taiwan)
  - OTP code input (6-digit)
  - Resend OTP button (rate limited to 1/minute)

- [ ] Update `AuthRepository`:
  ```dart
  Future<void> signInWithOtp({required String phone}) async {
    await supabase.auth.signInWithOtp(phone: phone);
  }

  Future<void> verifyOTP({
    required String phone,
    required String token
  }) async {
    await supabase.auth.verifyOTP(
      phone: phone,
      token: token,
      type: OtpType.sms
    );
  }
  ```

- [ ] Add "Sign in with Phone" button to `LoginScreen`
- [ ] Add phone registration option to `RegisterScreen`
- [ ] Handle errors: invalid phone, OTP expired, wrong code

**Spec Requirement:**
- Superuser promotion requires phone verification
- Store phone in `profiles_private.phone` table

**Acceptance Criteria:**
- Users can register/login with phone number
- OTP code expires after 5 minutes
- Rate limiting prevents spam

---

#### Task 2.2: Implement Referral Code System
**Files:**
- `lib/features/admin/data/referral_code_repository.dart` (new)
- `lib/features/admin/presentation/referral_code_panel.dart` (new)
- `lib/features/profile/presentation/apply_admin_screen.dart` (new)

**Database Support:** ✅ `referral_codes` table exists

- [ ] Create `ReferralCodeRepository`:
  ```dart
  // Generate code (Admin only, max 1 active)
  Future<ReferralCode> generateReferralCode() async {
    // Check active count
    final activeCount = await supabase
      .from('referral_codes')
      .select()
      .eq('issuer_id', currentUserId)
      .eq('is_active', true)
      .count();

    if (activeCount >= 1) {
      throw 'You already have an active referral code';
    }

    // Generate 8-char alphanumeric code
    final code = generateSecureCode(length: 8);
    final expiresAt = DateTime.now().add(Duration(hours: 1));

    return await supabase.from('referral_codes').insert({
      'code': code,
      'issuer_id': currentUserId,
      'expires_at': expiresAt.toIso8601String(),
    }).select().single();
  }

  // Validate and redeem code
  Future<bool> validateReferralCode(String code) async {
    final result = await supabase
      .rpc('validate_referral_code', params: {'code_input': code});
    return result['is_valid'] ?? false;
  }

  Future<void> redeemReferralCode(String code) async {
    await supabase.rpc('redeem_referral_code', params: {
      'code_input': code,
      'user_id': currentUserId,
    });
  }
  ```

- [ ] Admin Panel Integration:
  - Display current active code (or "Generate New Code" button)
  - Show expiry countdown
  - List historical codes with usage stats

- [ ] User Application Flow:
  - Add "Apply for Admin" button in `ProfileScreen` (visible to Leader only)
  - Input field for referral code
  - Submission triggers pending review (Superadmin approval required)

**Database Functions Required:**
```sql
-- Add to supabase_schema.sql
CREATE OR REPLACE FUNCTION validate_referral_code(code_input text)
RETURNS jsonb AS $$
DECLARE
  code_record referral_codes;
BEGIN
  SELECT * INTO code_record
  FROM referral_codes
  WHERE code = code_input
    AND is_active = true
    AND expires_at > now()
    AND max_uses > used_count;

  RETURN jsonb_build_object(
    'is_valid', code_record IS NOT NULL,
    'issuer_id', code_record.issuer_id
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

**Acceptance Criteria:**
- Admin cannot have >1 active code simultaneously
- Expired codes cannot be redeemed
- Code redemption increments `used_count`
- All actions logged to `audit_logs`

---

#### Task 2.3: Implement Role Upgrade Application Flow
**Files:**
- `lib/features/profile/presentation/role_upgrade_dialog.dart` (new)
- `lib/features/admin/presentation/user_review_panel.dart` (new)

- [ ] Create `RoleUpgradeDialog` (shown from ProfileScreen):
  - User → Superuser: Requires phone verification
  - Superuser → Leader: Requires unit/organization + reason
  - Leader → Admin: Requires referral code input

- [ ] Create application submission logic:
  ```dart
  Future<void> submitRoleUpgrade({
    required UserRole targetRole,
    String? unit,
    String? reason,
    String? referralCode,
  }) async {
    await supabase.from('role_upgrade_requests').insert({
      'user_id': currentUserId,
      'current_role': currentUser.role.name,
      'requested_role': targetRole.name,
      'unit': unit,
      'reason': reason,
      'referral_code': referralCode,
      'status': 'pending',
    });
  }
  ```

- [ ] Create `UserReviewPanel` (Admin Panel Tab 1):
  - Query `role_upgrade_requests` where `status = 'pending'`
  - Display: user info, current role, requested role, justification
  - Actions:
    - **Approve**: Update `profiles_public.role`, set request `status = 'approved'`, log to `audit_logs`
    - **Reject**: Set `status = 'rejected'`, add reason
  - Superadmin-only: Final approval for Leader→Admin (verify referral code)

**Database Schema Required:**
```sql
CREATE TABLE role_upgrade_requests (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES auth.users(id),
  current_role text NOT NULL,
  requested_role text NOT NULL,
  unit text,
  reason text,
  referral_code text,
  status text NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
  reviewed_by uuid REFERENCES auth.users(id),
  reviewed_at timestamptz,
  created_at timestamptz DEFAULT now()
);
```

**Acceptance Criteria:**
- User cannot submit duplicate pending requests
- Leader→Admin requires valid referral code
- Approval updates user role in real-time (Supabase triggers)
- Rejection includes reason visible to applicant

---

#### Task 2.4: Fix Exposed API Keys (Security)
**Files:**
- `lib/core/config/app_config.dart`
- `web/index.html`

**Current Issue:** Google Maps API keys hardcoded in source code

- [ ] Remove hardcoded keys from:
  ```dart
  // lib/core/config/app_config.dart
  static const String googleMapsApiKey = 'AIza...'; // ❌ REMOVE
  ```

- [ ] Create environment variable injection:
  - Create `.env` file (add to `.gitignore`):
    ```
    GOOGLE_MAPS_API_KEY=AIzaSyC...
    SUPABASE_URL=https://...
    SUPABASE_ANON_KEY=eyJh...
    ```

  - Add `flutter_dotenv` package:
    ```yaml
    dependencies:
      flutter_dotenv: ^5.1.0
    ```

  - Load in `main.dart`:
    ```dart
    import 'package:flutter_dotenv/flutter_dotenv.dart';

    void main() async {
      await dotenv.load(fileName: ".env");
      runApp(MyApp());
    }
    ```

  - Update `app_config.dart`:
    ```dart
    static String get googleMapsApiKey =>
      dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
    ```

- [ ] Update `web/index.html`:
  ```html
  <!-- BEFORE -->
  <script src="https://maps.googleapis.com/maps/api/js?key=AIza..."></script>

  <!-- AFTER -->
  <script>
    const MAPS_KEY = '{{GOOGLE_MAPS_API_KEY}}'; // Injected by build
  </script>
  <script src="https://maps.googleapis.com/maps/api/js?key=${MAPS_KEY}"></script>
  ```

- [ ] Configure Vercel environment variables:
  - Dashboard → Project → Settings → Environment Variables
  - Add `GOOGLE_MAPS_API_KEY`, `SUPABASE_URL`, `SUPABASE_ANON_KEY`

**Acceptance Criteria:**
- No secrets in source control
- Build fails if `.env` is missing
- Vercel builds inject environment variables correctly

---

### Phase 3: Data Model & Contract Fixes (Est. 10-15 hours)

#### Task 3.1: Fix ShuttleModel Missing Fields
**File:** `lib/models/shuttle_model.dart`

**Issue:** Database has fields not mapped in Dart model

- [ ] Add missing fields to `ShuttleModel`:
  ```dart
  @freezed
  class ShuttleModel with _$ShuttleModel {
    const factory ShuttleModel({
      required String id,
      required String displayId,
      required String title,
      String? description,
      required ShuttleStatus status,
      required LatLng origin,
      required LatLng destination,
      String? originAddress,
      String? destinationAddress,
      required DateTime departAt,
      DateTime? arriveAt,
      required int seatsTotal,
      required int seatsTaken,
      int? costPerSeat,
      required String createdBy,
      required DateTime createdAt,
      required DateTime updatedAt,

      // 🆕 MISSING FIELDS
      @JsonKey(name: 'vehicle') Map<String, dynamic>? vehicle,
      @JsonKey(name: 'contact_name') String? contactName,
      @JsonKey(name: 'contact_phone_masked') String? contactPhoneMasked,
      @JsonKey(name: 'participants') List<String>? participantIds, // Snapshot array
      @JsonKey(name: 'is_priority') bool? isPriority,
    }) = _ShuttleModel;

    factory ShuttleModel.fromJson(Map<String, dynamic> json) =>
        _$ShuttleModelFromJson(json);
  }
  ```

- [ ] Run code generation:
  ```bash
  flutter pub run build_runner build --delete-conflicting-outputs
  ```

- [ ] Update `ShuttleRepository` to query participant IDs:
  ```dart
  Future<ShuttleModel> getShuttle(String id) async {
    final data = await supabase
      .from('shuttles')
      .select('*, participants:shuttle_participants(user_id)')
      .eq('id', id)
      .single();

    // Transform participants to ID array
    data['participants'] = (data['participants'] as List)
      .map((p) => p['user_id'] as String)
      .toList();

    return ShuttleModel.fromJson(data);
  }
  ```

- [ ] Display vehicle info in `ShuttleDetailScreen`:
  ```dart
  if (shuttle.vehicle != null) {
    final type = shuttle.vehicle!['type'] ?? 'N/A';
    final plate = shuttle.vehicle!['plate'] ?? 'N/A';
    Text('Vehicle: $type - $plate');
  }
  ```

- [ ] Display masked contact:
  ```dart
  Text('Contact: ${shuttle.contactName ?? 'N/A'}');
  Text('Phone: ${shuttle.contactPhoneMasked ?? 'Hidden'}');
  ```

**Acceptance Criteria:**
- No JSON deserialization errors
- UI displays vehicle type, plate, contact info correctly
- Participant count matches snapshot array length

---

#### Task 3.2: Fix TaskModel Missing Fields
**File:** `lib/models/task_model.dart`

**Issue:** Spec requires participant snapshot array

- [ ] Add `participants` field:
  ```dart
  @freezed
  class TaskModel with _$TaskModel {
    const factory TaskModel({
      // ... existing fields
      @JsonKey(name: 'participants') List<String>? participantIds,
    }) = _TaskModel;
  }
  ```

- [ ] Update `TaskRepository` query (same pattern as Task 3.1)

- [ ] Regenerate code

**Acceptance Criteria:**
- Participant list UI can iterate over `participantIds`
- No need for separate `task_participants` query for display

---

#### Task 3.3: Add Participant List UI to Shuttle Detail
**File:** `lib/features/shuttles/presentation/shuttle_detail_screen.dart`

**Prerequisites:** Task 3.1 completed

- [ ] Create `_ParticipantList` widget:
  ```dart
  class _ParticipantList extends ConsumerWidget {
    final String shuttleId;

    Widget build(BuildContext context, WidgetRef ref) {
      final participantsAsync = ref.watch(
        shuttleParticipantsProvider(shuttleId)
      );

      return participantsAsync.when(
        data: (participants) => ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: participants.length,
          itemBuilder: (context, index) {
            final p = participants[index];
            return ListTile(
              leading: CircleAvatar(child: Text(p.name[0])),
              title: Text(p.name),
              subtitle: Text(p.role), // driver/staff/passenger
              trailing: p.isVisible
                ? Text(p.phoneMasked ?? 'N/A')
                : Icon(Icons.visibility_off),
            );
          },
        ),
        loading: () => CircularProgressIndicator(),
        error: (e, _) => Text('Error: $e'),
      );
    }
  }
  ```

- [ ] Create `shuttleParticipantsProvider`:
  ```dart
  final shuttleParticipantsProvider = StreamProvider.family<
    List<ShuttleParticipant>, String
  >((ref, shuttleId) {
    return supabase
      .from('shuttle_participants')
      .stream(primaryKey: ['id'])
      .eq('shuttle_id', shuttleId)
      .map((data) => data.map((json) =>
        ShuttleParticipant.fromJson(json)
      ).toList());
  });
  ```

- [ ] Add to `ShuttleDetailScreen` below route info
- [ ] Show role badges (driver/staff/passenger)
- [ ] Respect `is_visible` privacy setting

**Acceptance Criteria:**
- Participant list shows all joined users
- Driver is highlighted/badged
- Hidden contacts show lock icon instead of phone

---

#### Task 3.4: Enforce Schema Required Fields in Create Forms
**Files:**
- `lib/features/tasks/presentation/create_task_screen.dart`
- `lib/features/resources/presentation/create_resource_screen.dart`
- `lib/features/shuttles/presentation/create_shuttle_screen.dart` (Task 1.4)

**Issue:** Current forms don't collect all required schema fields

**Task Create Form Missing:**
- `location` (geography point) - currently allows null
- `required_roles` (jsonb)
- `participant_cap` (int)
- `visibility` (boolean)
- `materials_status` (jsonb)

**Changes:**
- [ ] Add location picker (map or address search)
- [ ] Add "Required Roles" multi-select (e.g., Medical, Driver, Logistics)
- [ ] Add "Max Participants" number input (default 10)
- [ ] Add "Public Task" checkbox (affects `is_visible`)
- [ ] Add "Materials Needed" dynamic form (item + quantity)

**Resource Create Form Missing:**
- Geohash deduplication check
- Contact phone masking

**Changes:**
- [ ] Remove hardcoded Taipei coordinates
- [ ] Use current location or map picker
- [ ] Check geohash-6 before insert:
  ```dart
  try {
    await resourceRepository.create(resource);
  } on PostgrestException catch (e) {
    if (e.code == '23505') { // Unique violation
      // Show dialog: "Resource exists nearby. View or merge?"
      final nearby = await resourceRepository.findByGeohash(geohash);
      showMergeDialog(nearby);
    }
  }
  ```

**Acceptance Criteria:**
- All form submissions succeed with RLS enabled
- No hardcoded coordinates
- Geohash conflicts handled gracefully
- Contact phones stored masked in `contact_masked_phone`

---

#### Task 3.5: Fix Flutter SDK Version Drift
**File:** `pubspec.yaml`

**Issue:** Code uses `Color.withValues` (Flutter 3.16+) but pubspec pins `sdk: ^3.10.0`

- [ ] Update SDK constraint:
  ```yaml
  environment:
    sdk: '>=3.16.0 <4.0.0'
  ```

- [ ] Update Vercel build script (if exists) to match
- [ ] Test local build with Flutter 3.16+
- [ ] Search codebase for other new API usage:
  ```bash
  grep -r "withValues" lib/
  ```

**Acceptance Criteria:**
- No compilation errors
- Local and Vercel builds use same SDK version

---

### Phase 4: PWA & Offline Support (Est. 8-10 hours)

#### Task 4.1: Configure PWA Manifest
**File:** `web/manifest.json`

**Current:** Default Flutter template

- [ ] Update manifest:
  ```json
  {
    "name": "Disaster Relief Resource Platform",
    "short_name": "Relief Platform",
    "description": "Taiwan Disaster Resource Integration Platform",
    "start_url": "/",
    "display": "standalone",
    "background_color": "#ffffff",
    "theme_color": "#1976d2",
    "orientation": "portrait-primary",
    "icons": [
      {
        "src": "icons/icon-192.png",
        "sizes": "192x192",
        "type": "image/png",
        "purpose": "any maskable"
      },
      {
        "src": "icons/icon-512.png",
        "sizes": "512x512",
        "type": "image/png",
        "purpose": "any maskable"
      }
    ],
    "screenshots": [
      {
        "src": "screenshots/home.png",
        "sizes": "540x720",
        "type": "image/png"
      }
    ]
  }
  ```

- [ ] Generate icons (192x192, 512x512) using design assets
- [ ] Add install prompt detection:
  ```dart
  // lib/core/utils/pwa_utils.dart
  void listenForInstallPrompt() {
    window.addEventListener('beforeinstallprompt', (event) {
      // Show custom install banner
    });
  }
  ```

**Acceptance Criteria:**
- PWA installable on Android/Desktop
- Correct app name and icon in launcher
- Standalone mode hides browser chrome

---

#### Task 4.2: Implement Service Worker Caching Strategy
**File:** `web/service_worker.js` (new, custom)

**Spec Requirement:**
- `stale-while-revalidate` for lists (announcements, tasks, shuttles)
- `CacheFirst` for static assets
- IndexedDB for offline mutations

- [ ] Create custom service worker (replace Flutter default):
  ```javascript
  importScripts('https://storage.googleapis.com/workbox-cdn/releases/6.5.4/workbox-sw.js');

  // Cache static assets
  workbox.routing.registerRoute(
    ({request}) => request.destination === 'image' ||
                    request.destination === 'font',
    new workbox.strategies.CacheFirst({
      cacheName: 'static-assets',
      plugins: [
        new workbox.expiration.ExpirationPlugin({
          maxEntries: 60,
          maxAgeSeconds: 30 * 24 * 60 * 60, // 30 days
        }),
      ],
    })
  );

  // Stale-while-revalidate for API calls
  workbox.routing.registerRoute(
    ({url}) => url.pathname.startsWith('/rest/v1/'),
    new workbox.strategies.StaleWhileRevalidate({
      cacheName: 'supabase-api',
      plugins: [
        new workbox.expiration.ExpirationPlugin({
          maxEntries: 100,
          maxAgeSeconds: 5 * 60, // 5 minutes
        }),
      ],
    })
  );

  // Network-first for auth/critical
  workbox.routing.registerRoute(
    ({url}) => url.pathname.includes('/auth/'),
    new workbox.strategies.NetworkFirst()
  );
  ```

- [ ] Integrate with `index.html`:
  ```html
  <script>
    if ('serviceWorker' in navigator) {
      navigator.serviceWorker.register('service_worker.js');
    }
  </script>
  ```

**Acceptance Criteria:**
- App loads basic UI when offline
- Cached data displayed with "Offline Mode" indicator
- Online sync resumes when network returns

---

#### Task 4.3: Implement IndexedDB Offline Mutation Queue
**File:** `lib/services/offline_queue_service.dart` (new)

**Use Case:** User creates task/shuttle while offline

- [ ] Create `OfflineQueueService`:
  ```dart
  class OfflineQueueService {
    final Isar isar;

    Future<void> queueMutation({
      required String type, // 'create_task', 'join_shuttle', etc.
      required Map<String, dynamic> payload,
    }) async {
      await isar.writeTxn(() async {
        await isar.offlineMutations.put(OfflineMutation(
          type: type,
          payload: jsonEncode(payload),
          createdAt: DateTime.now(),
        ));
      });
    }

    Future<void> syncPendingMutations() async {
      final pending = await isar.offlineMutations.where().findAll();
      for (final mutation in pending) {
        try {
          await _executeMutation(mutation);
          await isar.writeTxn(() => isar.offlineMutations.delete(mutation.id));
        } catch (e) {
          // Retry later
        }
      }
    }

    Future<void> _executeMutation(OfflineMutation m) async {
      switch (m.type) {
        case 'create_task':
          await supabase.from('tasks').insert(jsonDecode(m.payload));
        case 'join_shuttle':
          await supabase.rpc('join_shuttle', params: jsonDecode(m.payload));
        // ...
      }
    }
  }
  ```

- [ ] Trigger sync on network reconnect:
  ```dart
  Connectivity().onConnectivityChanged.listen((result) {
    if (result != ConnectivityResult.none) {
      offlineQueueService.syncPendingMutations();
    }
  });
  ```

**Acceptance Criteria:**
- Offline-created tasks appear as "Draft" (synced when online)
- No data loss during network transitions
- Conflict resolution (optimistic UI with rollback)

---

### Phase 5: Map & Resource Enhancements (Est. 6-8 hours)

#### Task 5.1: Display Tasks & Shuttles on Map
**File:** `lib/features/map/presentation/map_screen.dart`

**Current Issue:** Only resource points displayed

- [ ] Query tasks and shuttles with location:
  ```dart
  final tasks = ref.watch(tasksWithLocationProvider);
  final shuttles = ref.watch(shuttlesWithLocationProvider);
  ```

- [ ] Add markers with different colors:
  - **Resource Points:** Blue pin
  - **Tasks:** Green pin
  - **Shuttles:** Orange pin (origin) + Purple pin (destination)

- [ ] Cluster markers when zoomed out (use `google_maps_cluster_manager`)

- [ ] On marker tap, show bottom sheet with:
  - Title, status, distance from user
  - Quick actions: Navigate, View Details, Join/Leave

**Acceptance Criteria:**
- Map displays all 3 entity types
- Marker clusters prevent UI clutter
- Bottom sheet actions work correctly

---

#### Task 5.2: Fix Resource List "Map Preview Coming Soon"
**File:** `lib/features/resources/presentation/resource_list_screen.dart`

**Current:** Placeholder text instead of map

- [ ] Replace `Text('Map preview coming soon')` with actual map widget
- [ ] Show single resource point on small map
- [ ] Tapping map opens full `MapScreen` centered on resource
- [ ] Use `GoogleMap` widget in `SizedBox(height: 200)`

**Acceptance Criteria:**
- Resource location preview visible in list cards
- Map interactive (pan/zoom)

---

#### Task 5.3: Implement Contact Phone Masking
**File:** `lib/core/utils/phone_masking.dart` (new)

**Spec Requirement:** Taiwan phone masking (保留前 4 碼、末 3 碼)

- [ ] Create utility function:
  ```dart
  String maskPhone(String phone) {
    if (phone.length < 10) return phone;
    // Example: +886-912-345-678 → +886-912-***-678
    final countryCode = phone.substring(0, 4); // +886
    final prefix = phone.substring(4, 8); // -912
    final suffix = phone.substring(phone.length - 3); // 678
    return '$countryCode$prefix-***-$suffix';
  }
  ```

- [ ] Apply in UI:
  - `resource_list_screen.dart`: Contact phone
  - `shuttle_detail_screen.dart`: Host/participant phones
  - `task_detail_screen.dart`: Author phone

- [ ] Show unmasked phone only when:
  - User is logged in
  - User is participant (tasks/shuttles)
  - User toggled "Show Contact Info" in privacy settings

**Database Support:**
- ✅ `mask_phone()` SQL function exists
- ✅ `contact_masked_phone` columns exist

**Acceptance Criteria:**
- Visitors see masked phones
- Logged-in participants see full numbers
- Privacy preference respected

---

### Phase 6: Analytics & Monitoring (Est. 5-7 hours)

#### Task 6.1: Initialize Firebase Analytics
**File:** `lib/main.dart`

**Current Issue:** `firebase_analytics` declared but not initialized

- [ ] Initialize Firebase in `main()`:
  ```dart
  import 'package:firebase_core/firebase_core.dart';
  import 'package:firebase_analytics/firebase_analytics.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SupabaseService.initialize();
    runApp(ProviderScope(child: DisasterReliefApp()));
  }
  ```

- [ ] Create analytics service:
  **File:** `lib/services/analytics_service.dart`
  ```dart
  class AnalyticsService {
    static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

    static Future<void> logShuttleJoin(String shuttleId) async {
      await _analytics.logEvent(
        name: 'shuttle_join',
        parameters: {'shuttle_id': shuttleId},
      );
    }

    static Future<void> logTaskComplete(String taskId) async {
      await _analytics.logEvent(
        name: 'task_complete',
        parameters: {'task_id': taskId},
      );
    }

    // Add more events per spec...
  }
  ```

- [ ] Add event calls to critical actions:
  - `shuttle_join`, `shuttle_leave`, `shuttle_full`, `shuttle_complete`
  - `task_join`, `task_leave`, `task_complete`
  - `emergency_announcement_view`, `map_navigation_click`

**Acceptance Criteria:**
- Firebase console shows events in real-time
- User properties set (role, registration_date)

---

#### Task 6.2: Initialize Firebase Cloud Messaging (FCM)
**File:** `lib/services/messaging_service.dart`

**Current Issue:** `firebase_messaging` declared but not initialized

- [ ] Initialize FCM in `main()`:
  ```dart
  import 'package:firebase_messaging/firebase_messaging.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await SupabaseService.initialize();
    runApp(ProviderScope(child: DisasterReliefApp()));
  }

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Background message: ${message.notification?.title}');
  }
  ```

- [ ] Create messaging service:
  ```dart
  class MessagingService {
    final FirebaseMessaging _messaging = FirebaseMessaging.instance;

    Future<void> initialize() async {
      // Request permission
      await _messaging.requestPermission();

      // Get FCM token
      final token = await _messaging.getToken();

      // Save to Supabase user profile
      await supabase.from('profiles_private').upsert({
        'id': supabase.auth.currentUser!.id,
        'fcm_token': token,
      });

      // Listen to foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Show in-app notification
        showNotificationSnackbar(message);
      });
    }
  }
  ```

- [ ] Register device token on login
- [ ] Unregister on logout

**Acceptance Criteria:**
- Users receive push notifications for:
  - Emergency announcements
  - Task/shuttle updates (if participant)
  - Role approval status changes
- Notifications work on Web (FCM Web), Android, iOS

---

#### Task 6.3: Implement Audit Log Client Hooks
**File:** `lib/services/audit_service.dart`

**Database Support:** ✅ `audit_logs` table exists

- [ ] Create audit service:
  ```dart
  class AuditService {
    static Future<void> log({
      required String action,
      required String entityType,
      String? entityId,
      Map<String, dynamic>? metadata,
    }) async {
      await supabase.from('audit_logs').insert({
        'user_id': supabase.auth.currentUser?.id,
        'action': action,
        'entity_type': entityType,
        'entity_id': entityId,
        'metadata': metadata,
        'ip_address': await _getIpAddress(),
        'user_agent': window.navigator.userAgent,
      });
    }
  }
  ```

- [ ] Add logging to critical actions:
  - User role changes
  - Referral code generation/redemption
  - Emergency announcement creation
  - Task/shuttle deletion
  - Admin actions (approve/reject)

- [ ] Create admin audit log viewer (Task 1.3, Tab 3)

**Acceptance Criteria:**
- All high-privilege actions logged
- Logs immutable (append-only, RLS blocks DELETE)
- IP address and user agent captured

---

## Low Priority Tasks

### Phase 7: UX Enhancements (Est. 5-7 hours)

#### Task 7.1: Add Privacy Settings Page
**File:** `lib/features/profile/presentation/privacy_settings_screen.dart`

- [ ] Create settings page with toggles:
  - **Show Phone Number** (public in participant lists)
  - **Show Email** (public in profile)
  - **Show Participation History** (public in profile)

- [ ] Save to `profiles_private.privacy_settings`:
  ```dart
  await supabase.from('profiles_private').upsert({
    'id': currentUserId,
    'privacy_settings': {
      'show_phone': showPhone,
      'show_email': showEmail,
      'show_history': showHistory,
    }
  });
  ```

- [ ] Trigger syncs to `profiles_public` (via database trigger)
- [ ] Add route to Settings menu

**Acceptance Criteria:**
- Changes reflect immediately in public views
- Other users cannot see hidden fields

---

#### Task 7.2: Implement MFA Setup (Optional Security)
**File:** `lib/features/auth/presentation/mfa_setup_screen.dart`

**Spec Requirement:** Leader/Admin/Superadmin encouraged to enable MFA

- [ ] Integrate Supabase MFA:
  ```dart
  // Enroll TOTP
  final response = await supabase.auth.mfa.enroll(
    factorType: FactorType.totp,
  );
  final qrCode = response.totp.qrCode; // Show QR to user

  // Verify and activate
  await supabase.auth.mfa.challengeAndVerify(
    factorId: response.id,
    code: userInputCode,
  );
  ```

- [ ] Add MFA setup wizard in `SettingsScreen`
- [ ] Enforce MFA on login for Leader+ roles:
  ```dart
  final session = await supabase.auth.signInWithPassword(...);
  if (session.user.role.isLeaderOrAbove && !session.user.mfaEnabled) {
    // Redirect to MFA setup
  }
  ```

**Acceptance Criteria:**
- Leader+ can enable TOTP or SMS MFA
- MFA-protected accounts require code on every login
- Fallback recovery codes generated

---

#### Task 7.3: CAP Alert Integration (Advanced)
**File:** `lib/features/announcements/data/cap_service.dart`

**Spec Requirement:** CAP (Common Alerting Protocol) auto-generates emergency announcements

- [ ] Research Taiwan CAP-TWP API (e.g., NCDR Open Data Platform)
- [ ] Create polling service:
  ```dart
  class CapService {
    Future<void> pollCapAlerts() async {
      final response = await dio.get('https://alerts.ncdr.nat.gov.tw/api/cap');
      final alerts = parseCapXml(response.data);

      for (final alert in alerts) {
        if (alert.severity == 'Extreme') {
          await _createEmergencyAnnouncement(alert);
        }
      }
    }

    Future<void> _createEmergencyAnnouncement(CapAlert alert) async {
      await supabase.from('announcements').insert({
        'type': 'emergency',
        'title_i18n': {
          'zh-TW': alert.headline,
          'en-US': alert.headlineEn ?? alert.headline,
        },
        'content_i18n': {
          'zh-TW': alert.description,
          'en-US': alert.descriptionEn ?? alert.description,
        },
        'is_active': true,
        'created_by': 'system', // Special system user
      });
    }
  }
  ```

- [ ] Schedule polling (every 5 minutes) via background isolate or Supabase Edge Function
- [ ] Add admin approval step (draft → published)

**Acceptance Criteria:**
- Extreme CAP alerts auto-create emergency announcements
- Admin can edit before publishing
- No duplicate announcements for same alert ID

---

#### Task 7.4: Geohash Deduplication UX
**File:** `lib/features/resources/presentation/create_resource_screen.dart`

**Spec Requirement:** Prompt user to merge/view nearby resource on duplicate geohash

- [ ] Catch unique violation error:
  ```dart
  try {
    await resourceRepository.create(resource);
  } on PostgrestException catch (e) {
    if (e.code == '23505') {
      final nearby = await resourceRepository.findByGeohash(resource.geohash);
      _showMergeDialog(nearby);
    }
  }
  ```

- [ ] Create merge dialog:
  ```dart
  void _showMergeDialog(ResourcePoint existing) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Resource Already Exists'),
        content: Text('A resource point exists ${existing.distance}m away. '
                      'Would you like to view it or create a new one?'),
        actions: [
          TextButton(
            child: Text('View Existing'),
            onPressed: () => context.go('/map/resources/${existing.id}'),
          ),
          TextButton(
            child: Text('Create Anyway'),
            onPressed: () => _forceCreate(),
          ),
        ],
      ),
    );
  }
  ```

**Acceptance Criteria:**
- User informed of nearby resources (<1.2km)
- Can choose to view or proceed
- No silent failures

---

## Code Quality Guidelines

### Clean Code Principles

1. **Early Return Pattern** (reduce nesting)
   ```dart
   // ❌ Bad (nested)
   void processUser(User? user) {
     if (user != null) {
       if (user.isActive) {
         // process...
       }
     }
   }

   // ✅ Good (early return)
   void processUser(User? user) {
     if (user == null) return;
     if (!user.isActive) return;
     // process...
   }
   ```

2. **Extract Method** (single responsibility)
   ```dart
   // ❌ Bad (100-line method)
   Widget build(BuildContext context) {
     // ... massive widget tree
   }

   // ✅ Good (extracted methods)
   Widget build(BuildContext context) {
     return Column(
       children: [
         _buildHeader(),
         _buildBody(),
         _buildFooter(),
       ],
     );
   }
   ```

3. **Guard Clauses** (fail fast)
   ```dart
   // ✅ Good
   Widget build(BuildContext context, WidgetRef ref) {
     final dataAsync = ref.watch(dataProvider);

     if (dataAsync.isLoading) return LoadingSpinner();
     if (dataAsync.hasError) return ErrorWidget(dataAsync.error);

     final data = dataAsync.value!;
     return SuccessView(data);
   }
   ```

4. **Avoid Deep Widget Nesting** (use composition)
   ```dart
   // ❌ Bad
   return Container(
     child: Padding(
       child: Column(
         children: [
           Row(
             children: [
               Expanded(
                 child: Container(
                   // ...deep nesting
                 ),
               ),
             ],
           ),
         ],
       ),
     ),
   );

   // ✅ Good
   return Padding(
     padding: EdgeInsets.all(16),
     child: _buildContent(),
   );
   ```

5. **Riverpod Best Practices**
   ```dart
   // ✅ Use ConsumerWidget (avoid Consumer nesting)
   class MyScreen extends ConsumerWidget {
     @override
     Widget build(BuildContext context, WidgetRef ref) {
       final data = ref.watch(dataProvider);
       return data.when(
         data: (value) => SuccessView(value),
         loading: () => LoadingView(),
         error: (error, stack) => ErrorView(error),
       );
     }
   }
   ```

### Testing Requirements

- [ ] Unit tests for repositories (CRUD operations)
- [ ] Widget tests for critical screens (login, task creation)
- [ ] Integration tests for role-based access control
- [ ] E2E tests for join/leave flows

**Example:**
```dart
// test/features/tasks/task_repository_test.dart
void main() {
  late TaskRepository repository;

  setUp(() {
    repository = TaskRepository(mockSupabase);
  });

  test('createTask enforces rate limit for Users', () async {
    // Arrange
    when(mockSupabase.auth.currentUser.role).thenReturn(UserRole.user);

    // Act & Assert
    await repository.createTask(task1);
    expect(
      () => repository.createTask(task2), // Within 1 hour
      throwsA(isA<RateLimitException>()),
    );
  });
}
```

---

## Implementation Order

### Recommended Sequence (by dependency)

**Week 1: Core Pages & Navigation**
1. Task 1.4 - Create Shuttle Page (unblocks user flows)
2. Task 1.1 - My Shuttles Page
3. Task 1.2 - My Tasks Page
4. Task 1.6 - Shuttle Chat UI

**Week 2: Admin & RBAC**
5. Task 2.2 - Referral Code System (backend)
6. Task 2.3 - Role Upgrade Flow
7. Task 1.3 - Admin Panel (integrates 2.2 & 2.3)
8. Task 2.4 - Fix API Key Exposure

**Week 3: Data Model & UX**
9. Task 3.1 - Fix ShuttleModel Fields
10. Task 3.3 - Participant List UI
11. Task 1.5 - Google Maps Navigation
12. Task 3.4 - Enforce Schema Fields

**Week 4: Auth & Security**
13. Task 2.1 - Phone OTP Auth
14. Task 3.5 - Fix SDK Version Drift
15. Task 6.1 - Firebase Analytics
16. Task 6.2 - Firebase Messaging

**Week 5: PWA & Offline**
17. Task 4.1 - PWA Manifest
18. Task 4.2 - Service Worker Caching
19. Task 4.3 - Offline Queue

**Week 6: Map & Polish**
20. Task 5.1 - Map Display Tasks/Shuttles
21. Task 5.3 - Phone Masking
22. Task 6.3 - Audit Logging
23. Task 7.1 - Privacy Settings

**Week 7+: Optional Enhancements**
24. Task 7.2 - MFA Setup
25. Task 7.3 - CAP Integration
26. Task 7.4 - Geohash Dedup UX

---

## Progress Tracking

### Completion Checklist

**High Priority (Must Have)**
- [ ] Task 1.1 - My Shuttles Page
- [ ] Task 1.2 - My Tasks Page
- [ ] Task 1.3 - Admin Panel
- [ ] Task 1.4 - Create Shuttle Page
- [ ] Task 1.5 - Google Maps Navigation
- [ ] Task 1.6 - Shuttle Chat UI
- [ ] Task 2.1 - Phone OTP Auth
- [ ] Task 2.2 - Referral Code System
- [ ] Task 2.3 - Role Upgrade Flow
- [ ] Task 2.4 - Fix API Key Exposure
- [ ] Task 3.1 - Fix ShuttleModel Fields
- [ ] Task 3.4 - Enforce Schema Fields

**Medium Priority (Should Have)**
- [ ] Task 3.3 - Participant List UI
- [ ] Task 3.5 - Fix SDK Version Drift
- [ ] Task 4.1 - PWA Manifest
- [ ] Task 4.2 - Service Worker Caching
- [ ] Task 5.1 - Map Display Tasks/Shuttles
- [ ] Task 5.3 - Phone Masking
- [ ] Task 6.1 - Firebase Analytics
- [ ] Task 6.2 - Firebase Messaging
- [ ] Task 6.3 - Audit Logging

**Low Priority (Nice to Have)**
- [ ] Task 4.3 - Offline Queue
- [ ] Task 5.2 - Resource List Map Preview
- [ ] Task 7.1 - Privacy Settings
- [ ] Task 7.2 - MFA Setup
- [ ] Task 7.3 - CAP Integration
- [ ] Task 7.4 - Geohash Dedup UX

---

## Appendix: Database Schema Reference

### Key Tables (from `supabase_schema.sql`)

**Shuttles:**
```sql
CREATE TABLE shuttles (
  id uuid PRIMARY KEY,
  display_id text GENERATED ALWAYS AS ('S-' || left(id::text, 6)) STORED,
  title text NOT NULL,
  origin geography(point, 4326) NOT NULL,
  destination geography(point, 4326) NOT NULL,
  depart_at timestamptz NOT NULL,
  seats_total int NOT NULL,
  seats_taken int DEFAULT 0,
  vehicle jsonb,
  contact_name text,
  contact_phone_masked text,
  is_priority boolean DEFAULT false,
  created_by uuid NOT NULL REFERENCES auth.users(id)
);
```

**Role Upgrade Requests (needs creation):**
```sql
CREATE TABLE role_upgrade_requests (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES auth.users(id),
  current_role text NOT NULL,
  requested_role text NOT NULL,
  status text DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
  created_at timestamptz DEFAULT now()
);
```

**Referral Codes:**
```sql
CREATE TABLE referral_codes (
  id uuid PRIMARY KEY,
  code text UNIQUE NOT NULL,
  issuer_id uuid REFERENCES auth.users(id),
  expires_at timestamptz NOT NULL,
  is_active boolean DEFAULT true,
  max_uses int DEFAULT 1,
  used_count int DEFAULT 0
);
```

**Audit Logs:**
```sql
CREATE TABLE audit_logs (
  id uuid PRIMARY KEY,
  user_id uuid REFERENCES auth.users(id),
  action text NOT NULL,
  entity_type text,
  entity_id uuid,
  metadata jsonb,
  ip_address text,
  created_at timestamptz DEFAULT now()
);
```

---

## Contact & Support

For questions or clarifications on this roadmap, reference:
- **Spec Document:** `specs_feature.md`
- **Database Schema:** `supabase_schema.sql` (if exists)
- **Project Repository:** [GitHub URL]

**Last Updated:** 2025-01-21
**Maintainer:** Development Team
