# Disaster Relief Platform - Development Task List

**Version:** 2025-11-21
**Status:** Active Development
**Tech Stack:** Flutter 3.38.1 + Supabase + Vercel
**Spec References:** `specs_feature.md`, `specs_arch.md`

---

## Project Health Summary

**Overall Compliance: 82%**

| Category | Score | Status |
|----------|-------|--------|
| Firebase Cleanup | 95% | ✅ Completed (需執行 flutter clean) |
| Multi-language Strategy | 85% | ⚠️ Logic OK, input needs fix |
| Database Schema | 70% | ❌ Missing critical tables |
| Business Logic | 80% | ⚠️ Core complete, details pending |
| RLS Policies | 90% | ✅ Comprehensive |
| RBAC System | 95% | ✅ Complete, route guard needed |
| Auth System | 75% | ⚠️ Email/OAuth OK, advanced features pending |
| Core Modules | 85% | ✅ Main features complete |
| UI Pages | 90% | ✅ Core pages complete |
| Code Quality | 85% | ⚠️ Good architecture, low test coverage |

---

## Critical Issues Found

### 🚨 Blockers (Must Fix)

1. **Missing `role_upgrade_requests` Table**
   - **Impact:** P12 Admin Panel review功能無法運作，P13 Profile申請升級失敗
   - **Files:** Database migration needed

2. **Referral Codes Schema Mismatch**
   - **Impact:** 推薦碼生成功能失敗（Repository期望 `max_uses`/`used_count` 欄位，但表格使用 `is_consumed` boolean）
   - **Files:** `supabase/migrations/`, `lib/features/admin/data/referral_code_repository.dart`

3. **Hardcoded Multilingual Content**
   - **Impact:** 創建公告和資源點時，中英文內容完全相同
   - **Files:** `lib/models/resource_point.dart`, `lib/features/resources/presentation/create_resource_screen.dart`

---

## Tech Stack Confirmation

### ✅ Correct Stack (Per specs_arch.md)

**Frontend:**
- Flutter 3.38.1 (Dart 3.10.0)
- Riverpod 2.x (State Management)
- GoRouter 14 (Navigation)
- Material 3 (UI Framework)
- Google Maps Flutter (Mobile/Desktop only, web deferred)
- Isar (Offline cache, native only)
- l10n (zh-TW / en-US)

**Backend:**
- Supabase PostgreSQL 15 + PostGIS
- Supabase Auth (Email/SMS/OAuth)
- Supabase Realtime (for subscriptions)
- Supabase Storage
- RLS (Row Level Security)
- Edge Functions (role promotion, notifications)

**Deployment:**
- Web: Vercel (via `vercel_build.sh`)
- Mobile: Android/iOS native builds
- **Absolutely NO Firebase**

### ❌ Removed Dependencies

The following Firebase packages have been removed from `pubspec.yaml`:
- `firebase_core: ^3.6.0` ✅ REMOVED
- `firebase_messaging: ^15.1.3` ✅ REMOVED
- `firebase_analytics: ^11.3.3` ✅ REMOVED

**Cleanup Required:**
```bash
flutter clean
flutter pub get
```

---

## Development Roadmap

---

## Phase 1: Critical Blockers (Week 1) - MUST FIX

### Task 1.1: Create `role_upgrade_requests` Database Table

**Priority:** 🔴 **CRITICAL**
**Estimated Time:** 2 hours
**Files to Create:** `supabase/migrations/20250122000000_add_role_upgrade_requests.sql`

**Migration SQL:**
```sql
-- Create role upgrade requests table
CREATE TABLE role_upgrade_requests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  current_role TEXT NOT NULL,
  requested_role TEXT NOT NULL,
  unit TEXT,  -- Organization/unit for Leader申請
  reason TEXT,  -- Justification
  referral_code TEXT,  -- Required for Leader→Admin
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
  reviewed_by UUID REFERENCES auth.users(id),
  reviewed_at TIMESTAMPTZ,
  review_reason TEXT,  -- Rejection reason
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Enable RLS
ALTER TABLE role_upgrade_requests ENABLE ROW LEVEL SECURITY;

-- Allow users to view their own requests
CREATE POLICY role_upgrade_select ON role_upgrade_requests
  FOR SELECT USING (
    auth.uid() = user_id OR is_admin_or_above()
  );

-- Allow users to create upgrade requests
CREATE POLICY role_upgrade_insert ON role_upgrade_requests
  FOR INSERT WITH CHECK (
    auth.uid() = user_id AND status = 'pending'
  );

-- Only Admin+ can update (review) requests
CREATE POLICY role_upgrade_update ON role_upgrade_requests
  FOR UPDATE USING (
    is_admin_or_above()
  );

-- Create index for pending requests查詢
CREATE INDEX idx_role_upgrade_pending
  ON role_upgrade_requests(status, created_at DESC)
  WHERE status = 'pending';

-- Add trigger to update timestamps
CREATE TRIGGER trg_role_upgrade_updated
  BEFORE UPDATE ON role_upgrade_requests
  FOR EACH ROW EXECUTE PROCEDURE update_updated_at();

-- Log approvals/rejections to audit_logs
CREATE OR REPLACE FUNCTION log_role_upgrade_review()
RETURNS TRIGGER AS $$
BEGIN
  IF (OLD.status = 'pending' AND NEW.status IN ('approved', 'rejected')) THEN
    INSERT INTO audit_logs (
      actor_id,
      action,
      target_type,
      target_id,
      meta
    ) VALUES (
      NEW.reviewed_by,
      CASE WHEN NEW.status = 'approved' THEN 'role_upgrade_approved'
           ELSE 'role_upgrade_rejected' END,
      'role_upgrade_request',
      NEW.id,
      jsonb_build_object(
        'user_id', NEW.user_id,
        'from_role', NEW.current_role,
        'to_role', NEW.requested_role,
        'reason', NEW.review_reason
      )
    );

    -- If approved, update user role
    IF NEW.status = 'approved' THEN
      UPDATE profiles_public
      SET role = NEW.requested_role, updated_at = now()
      WHERE id = NEW.user_id;
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER trg_log_role_upgrade_review
  AFTER UPDATE ON role_upgrade_requests
  FOR EACH ROW EXECUTE PROCEDURE log_role_upgrade_review();
```

**Acceptance Criteria:**
- Migration executes without errors
- Admin can query pending requests
- Users can view own requests
- Approval automatically updates `profiles_public.role`
- All reviews logged to `audit_logs`

---

### Task 1.2: Fix Referral Codes Schema Mismatch

**Priority:** 🔴 **CRITICAL**
**Estimated Time:** 2 hours
**Files to Modify:** `supabase/migrations/20250122000001_fix_referral_codes_schema.sql`

**Migration SQL:**
```sql
-- Add missing columns expected by ReferralCodeRepository
ALTER TABLE referral_codes
  ADD COLUMN max_uses INT DEFAULT 3,
  ADD COLUMN used_count INT DEFAULT 0,
  ADD COLUMN is_active BOOLEAN DEFAULT true;

-- Migrate existing data
UPDATE referral_codes SET
  used_count = CASE WHEN is_consumed THEN 1 ELSE 0 END,
  is_active = NOT is_consumed,
  max_uses = 1;  -- Legacy codes are single-use

-- Add constraint: used_count cannot exceed max_uses
ALTER TABLE referral_codes ADD CONSTRAINT check_referral_uses
  CHECK (used_count <= max_uses);

-- Create function to increment used_count
CREATE OR REPLACE FUNCTION increment_referral_usage(p_code TEXT)
RETURNS VOID AS $$
BEGIN
  UPDATE referral_codes
  SET
    used_count = used_count + 1,
    is_active = CASE WHEN (used_count + 1) >= max_uses THEN false ELSE true END,
    updated_at = now()
  WHERE code = p_code;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Update validation function
CREATE OR REPLACE FUNCTION validate_referral_code(p_code TEXT)
RETURNS jsonb AS $$
DECLARE
  v_code referral_codes;
BEGIN
  SELECT * INTO v_code
  FROM referral_codes
  WHERE code = p_code
    AND is_active = true
    AND expires_at > now()
    AND used_count < max_uses;

  RETURN jsonb_build_object(
    'is_valid', v_code IS NOT NULL,
    'issuer_id', v_code.issuer_id,
    'issued_for_role', v_code.issued_for_role,
    'remaining_uses', CASE WHEN v_code IS NOT NULL THEN v_code.max_uses - v_code.used_count ELSE 0 END
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

**Acceptance Criteria:**
- Existing codes migrated successfully
- `ReferralCodeRepository.generateCode()` works without errors
- `ReferralCodeRepository.validateAndRedeemCode()` correctly increments `used_count`
- Multi-use codes (max_uses=3) can be redeemed by multiple users

---

### Task 1.3: Fix Multilingual Content Input

**Priority:** 🔴 **CRITICAL**
**Estimated Time:** 4 hours
**Files to Modify:**
- `lib/models/resource_point.dart`
- `lib/models/announcement_model.dart` (需新增檔案)
- `lib/features/resources/presentation/create_resource_screen.dart`
- `lib/features/announcements/presentation/create_announcement_dialog.dart` (需新增檔案)

#### Step 1: Fix ResourcePoint Model

**File:** `lib/models/resource_point.dart`

```dart
// BEFORE (hardcoded same value for both languages)
Map<String, dynamic> toSupabasePayload() {
  return {
    'title': {locale: title, 'en-US': title},  // ❌ Wrong
    // ...
  };
}

// AFTER (accept separate translations)
Map<String, dynamic> toSupabasePayload({
  required String titleZh,
  required String titleEn,
  required String descriptionZh,
  required String descriptionEn,
}) {
  return {
    'title': {'zh-TW': titleZh, 'en-US': titleEn},
    'description': {'zh-TW': descriptionZh, 'en-US': descriptionEn},
    'category': category,
    'location': 'POINT($longitude $latitude)',
    'address': address,
    'contact_name': contactName,
    'contact_phone': contactPhone,
    'verified': verified,
  };
}
```

#### Step 2: Update CreateResourceScreen UI

**File:** `lib/features/resources/presentation/create_resource_screen.dart`

Add separate input fields:

```dart
class CreateResourceScreen extends ConsumerStatefulWidget {
  // ... existing code
}

class _CreateResourceScreenState extends ConsumerState<CreateResourceScreen> {
  final _titleZhController = TextEditingController();
  final _titleEnController = TextEditingController();
  final _descZhController = TextEditingController();
  final _descEnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.createResource)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Chinese Title
            TextField(
              controller: _titleZhController,
              decoration: InputDecoration(
                labelText: '標題 (中文) *',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // English Title
            TextField(
              controller: _titleEnController,
              decoration: InputDecoration(
                labelText: 'Title (English) *',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Chinese Description
            TextField(
              controller: _descZhController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: '描述 (中文) *',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // English Description
            TextField(
              controller: _descEnController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description (English) *',
                border: OutlineInputBorder(),
              ),
            ),

            // ... existing fields (location, category, contact)

            ElevatedButton(
              onPressed: _submitResource,
              child: Text(l10n.submit),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitResource() async {
    if (_titleZhController.text.isEmpty || _titleEnController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('請填寫中英文標題 / Please fill in both titles')),
      );
      return;
    }

    final payload = {
      'title': {
        'zh-TW': _titleZhController.text.trim(),
        'en-US': _titleEnController.text.trim(),
      },
      'description': {
        'zh-TW': _descZhController.text.trim(),
        'en-US': _descEnController.text.trim(),
      },
      // ... other fields
    };

    await ref.read(resourceRepositoryProvider).createResource(payload);
    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleZhController.dispose();
    _titleEnController.dispose();
    _descZhController.dispose();
    _descEnController.dispose();
    super.dispose();
  }
}
```

#### Step 3: Apply Same Pattern to Announcements

Create `lib/features/announcements/presentation/create_announcement_dialog.dart` with dual-language inputs.

**Acceptance Criteria:**
- Creating resource point with different Chinese/English titles works
- Database stores correct jsonb structure: `{'zh-TW': '中文', 'en-US': 'English'}`
- Switching app language displays correct translation
- Form validation requires both languages filled

---

### Task 1.4: Add Admin Route Guard

**Priority:** 🔴 **HIGH**
**Estimated Time:** 1 hour
**Files to Modify:** `lib/core/router/app_router.dart`

```dart
// BEFORE (no role check for /admin)
GoRoute(
  path: '/admin',
  builder: (context, state) => const AdminPanelScreen(),
),

// AFTER (redirect non-admins)
GoRoute(
  path: '/admin',
  builder: (context, state) => const AdminPanelScreen(),
  redirect: (context, state) async {
    final authRepository = ref.read(authRepositoryProvider);
    final user = authRepository.currentUser;

    if (user == null) return '/login';

    final profileRepository = ref.read(profileRepositoryProvider);
    final profile = await profileRepository.getProfile(user.id);

    if (!profile.role.isAdminOrAbove) {
      return '/home';  // Redirect non-admins
    }

    return null;  // Allow access
  },
),
```

**Acceptance Criteria:**
- Non-admin users redirected to `/home` when accessing `/admin`
- Admin+ users can access admin panel normally
- No console errors

---

## Phase 2: Database Enhancements (Week 2)

### Task 2.1: Configure pg_cron for Message Cleanup

**Priority:** 🟡 **MEDIUM**
**Estimated Time:** 1 hour
**Files to Create:** `supabase/migrations/20250122000003_setup_cron_jobs.sql`

```sql
-- Schedule daily cleanup at 2 AM
SELECT cron.schedule(
  'prune-expired-messages',
  '0 2 * * *',
  $$SELECT prune_expired_messages();$$
);

-- Verify cron job created
SELECT * FROM cron.job WHERE jobname = 'prune-expired-messages';
```

**Alternative (Manual Setup):**
1. Go to Supabase Dashboard → Database → Cron Jobs
2. Create new job:
   - Name: `prune-expired-messages`
   - Schedule: `0 2 * * *` (Daily at 2 AM)
   - Command: `SELECT prune_expired_messages();`

**Acceptance Criteria:**
- Cron job visible in `cron.job` table
- Messages older than 30 days deleted daily
- Check logs after first run

---

### Task 2.2: Add Shuttle Priority Guard Trigger

**Priority:** 🟡 **MEDIUM**
**Estimated Time:** 1 hour
**Files to Create:** `supabase/migrations/20250122000002_add_shuttle_priority_guard.sql`

```sql
-- Protect shuttle is_priority field (same as tasks)
CREATE OR REPLACE FUNCTION protect_shuttle_priority()
RETURNS TRIGGER AS $$
BEGIN
  IF (NEW.is_priority IS DISTINCT FROM OLD.is_priority)
     AND NOT is_leader_or_above() THEN
    RAISE EXCEPTION 'Permission denied: only Leader+ can change shuttle priority';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_shuttle_priority_protect
  BEFORE UPDATE ON shuttles
  FOR EACH ROW EXECUTE PROCEDURE protect_shuttle_priority();
```

**Acceptance Criteria:**
- Regular users cannot UPDATE `is_priority` field
- Leader+ can set priority without errors
- Error message displayed correctly in frontend

---

### Task 2.3: Auto-mask Phone Numbers in Database

**Priority:** 🟢 **LOW**
**Estimated Time:** 2 hours
**Files to Create:** `supabase/migrations/20250122000004_auto_mask_phones.sql`

```sql
-- Create trigger to auto-populate masked_phone from profiles_private
CREATE OR REPLACE FUNCTION sync_masked_phone()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.masked_phone IS NULL OR NEW.masked_phone = '' THEN
    SELECT mask_phone(real_phone) INTO NEW.masked_phone
    FROM profiles_private
    WHERE id = NEW.id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER trg_mask_phone_on_profile
  BEFORE INSERT OR UPDATE ON profiles_public
  FOR EACH ROW EXECUTE PROCEDURE sync_masked_phone();
```

**Acceptance Criteria:**
- Inserting profile without `masked_phone` auto-generates masked version
- `mask_phone()` function correctly formats Taiwan phone numbers
- No PII leak in public table

---

## Phase 3: UI/UX Improvements (Week 3)

### Task 3.1: Implement Resource Duplicate Detection Dialog

**Priority:** 🟡 **MEDIUM**
**Estimated Time:** 3 hours
**Files to Create:** `lib/features/resources/presentation/duplicate_resource_dialog.dart`

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DuplicateResourceDialog extends StatelessWidget {
  final List<ResourcePoint> nearbyResources;

  const DuplicateResourceDialog({required this.nearbyResources, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('發現附近資源點'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('以下資源點距離您小於 1.2 公里：'),
          SizedBox(height: 16),
          ...nearbyResources.map((r) => ListTile(
            title: Text(r.title),
            subtitle: Text('${r.distance.toStringAsFixed(0)} 公尺'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              context.go('/map/resources/${r.id}');
            },
          )),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('仍要建立新點'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('查看既有點'),
        ),
      ],
    );
  }
}
```

**Modify CreateResourceScreen:**

```dart
Future<void> _submitResource() async {
  // ... validation

  // Check for duplicates before submitting
  final geohash = Geohash.encode(latitude, longitude, precision: 6);
  final nearby = await ref.read(resourceRepositoryProvider)
    .findByGeohash(geohash);

  if (nearby.isNotEmpty) {
    final shouldCancel = await showDialog<bool>(
      context: context,
      builder: (_) => DuplicateResourceDialog(nearbyResources: nearby),
    );
    if (shouldCancel == true) return;  // User chose to view existing
  }

  // Proceed with creation
  await ref.read(resourceRepositoryProvider).createResource(payload);
}
```

**Acceptance Criteria:**
- Dialog shows when duplicate geohash detected
- User can navigate to existing resource point
- User can choose to create anyway

---

### Task 3.2: Implement Forgot Password Flow

**Priority:** 🟡 **MEDIUM**
**Estimated Time:** 2 hours
**Files to Create:** `lib/features/auth/presentation/forgot_password_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('重設密碼')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '請輸入您的註冊信箱，我們將發送重設連結',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 24),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _sendResetEmail,
              child: _isLoading
                ? CircularProgressIndicator()
                : Text('發送重設連結'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendResetEmail() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(authRepositoryProvider).resetPassword(email);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('重設連結已發送至 $email')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('發送失敗：$e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
```

**Update AuthRepository:**

```dart
Future<void> resetPassword(String email) async {
  await _supabase.auth.resetPasswordForEmail(
    email,
    redirectTo: 'your-app://reset-password',  // Configure deep link
  );
}
```

**Update LoginScreen:**

```dart
// Replace TODO comment with:
TextButton(
  onPressed: () => context.go('/forgot-password'),
  child: Text('忘記密碼？'),
),
```

**Add Route:**

```dart
GoRoute(
  path: '/forgot-password',
  builder: (context, state) => const ForgotPasswordScreen(),
),
```

**Acceptance Criteria:**
- User receives password reset email
- Email contains valid reset link
- Reset link opens app (deep linking configured)
- User can set new password

---

### Task 3.3: Extract Nested Widgets in Detail Screens

**Priority:** 🟢 **LOW**
**Estimated Time:** 4 hours
**Files to Modify:**
- `lib/features/shuttles/presentation/shuttle_detail_screen.dart`
- `lib/features/tasks/presentation/task_detail_screen.dart`

**Example Refactor (ShuttleDetailScreen):**

```dart
// BEFORE (deep nesting)
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        Container(
          child: Padding(
            child: Column(
              children: [
                Row(children: [...]),  // Deeply nested
                // ...
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// AFTER (extracted components)
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        _buildHeader(),
        _buildRouteInfo(),
        _buildParticipantsList(),
        _buildChatSection(),
      ],
    ),
  );
}

Widget _buildHeader() {
  return Container(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(shuttle.title, style: Theme.of(context).textTheme.headlineSmall),
        SizedBox(height: 8),
        _buildStatusBadge(),
      ],
    ),
  );
}

Widget _buildRouteInfo() {
  return Card(
    margin: EdgeInsets.all(16),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildLocationRow(Icons.my_location, shuttle.originAddress),
          Divider(),
          _buildLocationRow(Icons.place, shuttle.destinationAddress),
        ],
      ),
    ),
  );
}

Widget _buildLocationRow(IconData icon, String address) {
  return Row(
    children: [
      Icon(icon),
      SizedBox(width: 8),
      Expanded(child: Text(address)),
      IconButton(
        icon: Icon(Icons.navigation),
        onPressed: () => _launchNavigation(address),
      ),
    ],
  );
}

// ... more extracted methods
```

**Acceptance Criteria:**
- No widget tree deeper than 5 levels
- Each extracted method has single responsibility
- Code easier to read and maintain
- No functionality broken

---

## Phase 4: Testing & Quality (Week 4)

### Task 4.1: Add Integration Tests

**Priority:** 🟡 **MEDIUM**
**Estimated Time:** 8 hours
**Files to Create:**
- `integration_test/auth_flow_test.dart`
- `integration_test/task_lifecycle_test.dart`
- `integration_test/shuttle_booking_test.dart`

**Example Test (auth_flow_test.dart):**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:disaster_relief_platform/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Authentication Flow', () {
    testWidgets('User can register and login', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to register
      await tester.tap(find.text('註冊'));
      await tester.pumpAndSettle();

      // Fill registration form
      await tester.enterText(find.byKey(Key('email_field')), 'test@example.com');
      await tester.enterText(find.byKey(Key('password_field')), 'Test123456');
      await tester.enterText(find.byKey(Key('confirm_password_field')), 'Test123456');

      // Submit
      await tester.tap(find.text('註冊'));
      await tester.pumpAndSettle();

      // Verify success message
      expect(find.text('註冊成功'), findsOneWidget);

      // Login with same credentials
      await tester.tap(find.text('登入'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Key('login_email')), 'test@example.com');
      await tester.enterText(find.byKey(Key('login_password')), 'Test123456');
      await tester.tap(find.text('登入'));
      await tester.pumpAndSettle();

      // Verify redirected to home
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Admin can access admin panel', (tester) async {
      // ... test admin login and panel access
    });
  });
}
```

**Run Tests:**
```bash
flutter test integration_test/auth_flow_test.dart
```

**Acceptance Criteria:**
- All critical user flows covered
- Tests run without errors
- CI pipeline includes integration tests

---

### Task 4.2: Add Unit Tests for Repositories

**Priority:** 🟡 **MEDIUM**
**Estimated Time:** 6 hours
**Files to Create:**
- `test/features/tasks/task_repository_test.dart`
- `test/features/shuttles/shuttle_repository_test.dart`
- `test/features/admin/referral_code_repository_test.dart`

**Example Test:**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:disaster_relief_platform/features/tasks/data/task_repository.dart';

void main() {
  late TaskRepository repository;
  late MockSupabaseClient mockClient;

  setUp(() {
    mockClient = MockSupabaseClient();
    repository = TaskRepository(mockClient);
  });

  group('TaskRepository', () {
    test('createTask enforces rate limit for regular users', () async {
      // Arrange
      when(mockClient.auth.currentUser).thenReturn(
        MockUser(role: UserRole.user)
      );

      // Act & Assert
      await repository.createTask(task1);
      expect(
        () => repository.createTask(task2),  // Within 1 hour
        throwsA(isA<RateLimitException>()),
      );
    });

    test('createTask allows Leader+ without rate limit', () async {
      // Arrange
      when(mockClient.auth.currentUser).thenReturn(
        MockUser(role: UserRole.leader)
      );

      // Act
      await repository.createTask(task1);
      await repository.createTask(task2);  // Should succeed

      // Assert
      verify(mockClient.from('tasks').insert(any)).called(2);
    });
  });
}
```

**Acceptance Criteria:**
- Repository logic tested independently
- Mock Supabase client used
- Edge cases covered (rate limits, permissions, etc.)

---

## Phase 5: PWA & Deployment (Week 5)

### Task 5.1: Configure PWA Service Worker Cache

**Priority:** 🟡 **MEDIUM**
**Estimated Time:** 4 hours
**Files to Modify:** `web/service_worker.js`

**Replace Flutter default service worker:**

```javascript
importScripts('https://storage.googleapis.com/workbox-cdn/releases/6.5.4/workbox-sw.js');

// Cache static assets (images, fonts)
workbox.routing.registerRoute(
  ({request}) => request.destination === 'image' || request.destination === 'font',
  new workbox.strategies.CacheFirst({
    cacheName: 'static-assets',
    plugins: [
      new workbox.expiration.ExpirationPlugin({
        maxEntries: 60,
        maxAgeSeconds: 30 * 24 * 60 * 60,  // 30 days
      }),
    ],
  })
);

// Stale-while-revalidate for API calls
workbox.routing.registerRoute(
  ({url}) => url.origin === 'https://your-project.supabase.co',
  new workbox.strategies.StaleWhileRevalidate({
    cacheName: 'supabase-api',
    plugins: [
      new workbox.expiration.ExpirationPlugin({
        maxEntries: 100,
        maxAgeSeconds: 5 * 60,  // 5 minutes
      }),
    ],
  })
);

// Network-first for auth endpoints
workbox.routing.registerRoute(
  ({url}) => url.pathname.includes('/auth/'),
  new workbox.strategies.NetworkFirst({
    cacheName: 'auth-cache',
  })
);

// Precache Flutter build files
workbox.precaching.precacheAndRoute(self.__WB_MANIFEST);
```

**Update `web/index.html`:**

```html
<script>
  if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
      navigator.serviceWorker.register('/service_worker.js')
        .then(reg => console.log('SW registered:', reg))
        .catch(err => console.log('SW registration failed:', err));
    });
  }
</script>
```

**Acceptance Criteria:**
- App loads basic UI when offline
- Cached data displayed with "Offline Mode" indicator
- Online sync resumes when network returns

---

### Task 5.2: Add Web Map Fallback

**Priority:** 🟢 **LOW**
**Estimated Time:** 3 hours
**Files to Modify:** `lib/features/map/presentation/map_screen.dart`

```dart
import 'package:flutter/foundation.dart' show kIsWeb;

class MapScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kIsWeb) {
      return _buildWebFallback(context);
    }

    return _buildNativeMap(ref);
  }

  Widget _buildWebFallback(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.map, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            '地圖功能僅支援行動版',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 8),
          Text('請使用 Android 或 iOS 應用程式查看地圖'),
          SizedBox(height: 24),
          ElevatedButton.icon(
            icon: Icon(Icons.list),
            label: Text('查看列表'),
            onPressed: () => context.go('/map/resources'),
          ),
        ],
      ),
    );
  }

  Widget _buildNativeMap(WidgetRef ref) {
    // Existing GoogleMap implementation
    return GoogleMap(/* ... */);
  }
}
```

**Acceptance Criteria:**
- Web users see friendly message instead of crash
- Native platforms show full map functionality
- List view accessible from web fallback

---

### Task 5.3: Create .env.example Template

**Priority:** 🟡 **MEDIUM**
**Estimated Time:** 30 minutes
**Files to Create:** `.env.example`

```env
# Supabase Configuration
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here

# Google Maps API Key
GOOGLE_MAPS_API_KEY=your-maps-api-key-here

# Optional: Sentry DSN for error tracking
# SENTRY_DSN=https://...

# Optional: Environment (development/staging/production)
# APP_ENV=development
```

**Update README.md:**

```markdown
## Setup

1. Clone repository
2. Copy `.env.example` to `.env`:
   ```bash
   cp .env.example .env
   ```
3. Fill in your Supabase credentials and Google Maps API key
4. Run:
   ```bash
   flutter pub get
   flutter run
   ```

## Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `SUPABASE_URL` | Yes | Your Supabase project URL |
| `SUPABASE_ANON_KEY` | Yes | Public anon key from Supabase |
| `GOOGLE_MAPS_API_KEY` | Yes | Google Maps API key (with Maps SDK enabled) |
```

**Acceptance Criteria:**
- `.env.example` committed to repo
- `.env` in `.gitignore` (already done)
- README instructions clear

---

## Phase 6: Optional Enhancements

### Task 6.1: Upgrade Flutter Packages

**Priority:** 🟢 **LOW**
**Estimated Time:** 4 hours
**Files to Modify:** `pubspec.yaml`

**Current → Target Versions:**
- Riverpod: `2.5.1` → `3.0.0`
- GoRouter: `14.2.7` → `17.0.0`
- Isar: `2.5.0` → `3.0.0` (with web WASM support)

**Migration Steps:**

1. Update `pubspec.yaml`:
   ```yaml
   dependencies:
     flutter_riverpod: ^3.0.0
     riverpod_annotation: ^3.0.0
     go_router: ^17.0.0
     isar: ^3.0.0
     isar_flutter_libs: ^3.0.0

   dev_dependencies:
     riverpod_generator: ^3.0.0
   ```

2. Run migration:
   ```bash
   flutter pub upgrade
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. Fix breaking changes (refer to migration guides):
   - Riverpod 3.0: `ref.watch` → `ref.listen` for side effects
   - GoRouter 17.0: Route configuration changes
   - Isar 3.0: New WASM support configuration

**Acceptance Criteria:**
- All packages updated successfully
- No compilation errors
- All tests pass
- Web build works with Isar WASM

---

### Task 6.2: Implement Phone OTP Authentication

**Priority:** 🟢 **LOW**
**Estimated Time:** 6 hours
**Files to Modify:** `lib/features/auth/presentation/phone_login_screen.dart`

**Complete Implementation:**

```dart
class PhoneLoginScreen extends ConsumerStatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  ConsumerState<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends ConsumerState<PhoneLoginScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _otpSent = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('手機號碼登入')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: _otpSent ? _buildOtpInput() : _buildPhoneInput(),
      ),
    );
  }

  Widget _buildPhoneInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: '手機號碼',
            prefix: Text('+886 '),
            hintText: '912345678',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 24),
        ElevatedButton(
          onPressed: _isLoading ? null : _sendOtp,
          child: _isLoading
            ? CircularProgressIndicator()
            : Text('發送驗證碼'),
        ),
      ],
    );
  }

  Widget _buildOtpInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('驗證碼已發送至 +886${_phoneController.text}'),
        SizedBox(height: 16),
        TextField(
          controller: _otpController,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: InputDecoration(
            labelText: '6位數驗證碼',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 24),
        ElevatedButton(
          onPressed: _isLoading ? null : _verifyOtp,
          child: _isLoading
            ? CircularProgressIndicator()
            : Text('驗證並登入'),
        ),
        TextButton(
          onPressed: _isLoading ? null : _sendOtp,
          child: Text('重新發送驗證碼'),
        ),
      ],
    );
  }

  Future<void> _sendOtp() async {
    final phone = '+886${_phoneController.text.trim()}';
    if (_phoneController.text.length != 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('請輸入正確的手機號碼')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(authRepositoryProvider).sendOtp(phone);
      setState(() {
        _otpSent = true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('發送失敗：$e')),
      );
    }
  }

  Future<void> _verifyOtp() async {
    final phone = '+886${_phoneController.text.trim()}';
    final otp = _otpController.text.trim();

    if (otp.length != 6) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(authRepositoryProvider).verifyOtp(phone, otp);
      if (mounted) context.go('/home');
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('驗證失敗：$e')),
      );
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }
}
```

**Update AuthRepository:**

```dart
Future<void> sendOtp(String phone) async {
  await _supabase.auth.signInWithOtp(phone: phone);
}

Future<void> verifyOtp(String phone, String token) async {
  await _supabase.auth.verifyOTP(
    phone: phone,
    token: token,
    type: OtpType.sms,
  );
}
```

**Acceptance Criteria:**
- Users receive SMS with 6-digit code
- OTP expires after 5 minutes
- Rate limiting prevents spam (1 SMS per minute)
- Successful verification logs user in

---

## Code Quality Guidelines

### Clean Code Principles

1. **Early Return Pattern** (reduce nesting)
   ```dart
   // ❌ Bad
   void processUser(User? user) {
     if (user != null) {
       if (user.isActive) {
         // process...
       }
     }
   }

   // ✅ Good
   void processUser(User? user) {
     if (user == null) return;
     if (!user.isActive) return;
     // process...
   }
   ```

2. **Extract Method** (single responsibility)
   ```dart
   // ❌ Bad
   Widget build(BuildContext context) {
     return Column(
       children: [
         // 50 lines of complex UI...
       ],
     );
   }

   // ✅ Good
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

3. **Avoid Deep Nesting** (max 3-4 levels)
   ```dart
   // ❌ Bad
   return Container(
     child: Padding(
       child: Column(
         children: [
           Row(
             children: [
               Expanded(
                 child: Container(/* ... */),
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

---

## Progress Tracking

### Critical Blockers (Week 1)
- [ ] Task 1.1 - Create `role_upgrade_requests` Table
- [ ] Task 1.2 - Fix Referral Codes Schema
- [ ] Task 1.3 - Fix Multilingual Content Input
- [ ] Task 1.4 - Add Admin Route Guard

### Database Enhancements (Week 2)
- [ ] Task 2.1 - Configure pg_cron
- [ ] Task 2.2 - Add Shuttle Priority Guard
- [ ] Task 2.3 - Auto-mask Phone Numbers

### UI/UX Improvements (Week 3)
- [ ] Task 3.1 - Resource Duplicate Detection
- [ ] Task 3.2 - Forgot Password Flow
- [ ] Task 3.3 - Extract Nested Widgets

### Testing & Quality (Week 4)
- [ ] Task 4.1 - Integration Tests
- [ ] Task 4.2 - Unit Tests

### PWA & Deployment (Week 5)
- [ ] Task 5.1 - Service Worker Cache
- [ ] Task 5.2 - Web Map Fallback
- [ ] Task 5.3 - .env.example Template

### Optional Enhancements
- [ ] Task 6.1 - Upgrade Flutter Packages
- [ ] Task 6.2 - Phone OTP Authentication

---

## Deployment Checklist

### Before Production

- [ ] All Critical Blockers completed
- [ ] Integration tests passing
- [ ] Environment variables configured in Vercel
- [ ] Supabase RLS policies reviewed
- [ ] Database migrations executed on production
- [ ] pg_cron jobs configured
- [ ] Google Maps API key restricted (HTTP referrers)
- [ ] Sentry error tracking configured (optional)
- [ ] Performance testing completed
- [ ] Security audit completed

### Vercel Configuration

```bash
# Environment Variables to set in Vercel Dashboard
SUPABASE_URL=https://your-prod-project.supabase.co
SUPABASE_ANON_KEY=eyJ...
GOOGLE_MAPS_API_KEY=AIza...
```

### Build Command

```bash
bash vercel_build.sh
```

### Supabase Production Setup

1. Enable Point-in-Time Recovery (PITR)
2. Configure daily backups
3. Set up monitoring alerts
4. Review audit logs retention policy
5. Enable email confirmations for new registrations

---

## Contact & Support

**Tech Stack:**
- Frontend: Flutter 3.38.1 + Riverpod 2.x + GoRouter 14
- Backend: Supabase (PostgreSQL 15 + PostGIS + Realtime)
- Deployment: Vercel (Web), Native (Android/iOS)

**Spec Documents:**
- `specs_feature.md` - Feature requirements
- `specs_arch.md` - Architecture specifications

**Last Updated:** 2025-11-21
**Project Status:** 82% Complete
**Next Milestone:** Complete Critical Blockers (Week 1)
