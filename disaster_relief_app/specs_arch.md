-----

````markdown
# Disaster Resource Integration Platform (DRIP) — Full Stack Specifications
**File Name:** `specs_v1.md`
**Version:** 1.0.0 (Greenfield / Flutter + Supabase)
**Status:** Final / Ready for Dev
**Date:** 2025-11-19

> **Purpose:** Single Source of Truth (SSoT). This document guides the development of the Flutter App and Supabase Backend from scratch. It includes the complete Database Schema, Complex RBAC Implementation (RLS/Triggers), API Contracts, and Security Standards.

---

## 1. Tech Stack & Architecture Decisions

### 1.1 Frontend (Flutter App)

- **Framework:** Flutter (Stable Channel) / Dart 3+
- **State Management:** **Riverpod** (Generator mode recommended) - Handles business logic and state transitions.
- **Navigation:** **GoRouter** - Supports Deep Linking and Nested Routes.
- **Local Database:** **Isar** - Used for offline read-only cache (Cache-First for reads).
- **Map SDK:** **google_maps_flutter** - Requires API Key; integrates with Places API for accurate POI data.
- **Networking:** **supabase_flutter** (Auth, DB, Realtime) + **dio** (For Edge Function calls).

### 1.2 Backend (Supabase)

- **Database:** PostgreSQL 15+ (Primary Region: `asia-east1` or equivalent).
- **Extensions:** `postgis` (Geospatial operations), `pg_cron` (Scheduled cleanup).
- **Auth:** Supabase Auth (Email/Password + Phone OTP + Google).
- **Logic Layer:**
  - **RLS Policies:** Fundamental access control.
  - **Database Triggers (PL/pgSQL):** Handles Rate Limiting, Field-level protection, and Automatic Auditing.
  - **Edge Functions (Deno/TS):** Handles high-privilege operations (Role promotion, FCM Push forwarding).

---

## 2. Core Architecture Strategies

### 2.1 Offline-First Strategy (Network-First with Fallback)

1.  **Read Operations:**
    - The App requests data from Supabase first.
    - **Success:** Update UI and write to Isar local DB (overwriting old cache).
    - **Fail:** Read from Isar local DB and show "Last updated at..." toast.
2.  **Write Operations:**
    - **Strict Mode:** Creating Tasks, Joining Shuttles, and Sending Messages **require internet connection**.
    - **Drafts:** Only "Drafts" can be saved locally.

### 2.2 Realtime & Notifications

- **Shuttle Tracking:** Use **Supabase Realtime (Broadcast)** to stream coordinates. Do NOT write to the DB continuously to save costs. Only write to DB when `status` changes (Departed/Arrived).
- **Push Notifications (FCM):**
  - App stores Token in `user_devices` table.
  - Postgres Trigger listens to events (e.g., `INSERT ON task_messages`).
  - Trigger calls Edge Function → Edge Function sends payload to FCM.

---

## 3. Database Schema Design (PostgreSQL)

### 3.1 Users & Profiles

**Design Concept:** Separation of PII (Personally Identifiable Information). Public profiles are automatically masked.

```sql
-- 1. Public Profile (Readable by everyone)
CREATE TABLE profiles_public (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  display_id TEXT UNIQUE NOT NULL,       -- e.g., U-8821
  nickname TEXT NOT NULL,
  role TEXT DEFAULT 'User',              -- Visitor, User, Superuser, Leader, Admin, Superadmin
  avatar_url TEXT,
  masked_phone TEXT,                     -- System generated: 0912-***-789
  updated_at TIMESTAMPTZ
);

-- 2. Private Profile (Readable only by Owner and Admin)
CREATE TABLE profiles_private (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  full_name TEXT,
  real_phone TEXT,                       -- Plain text or Supabase Vault encrypted
  fcm_tokens TEXT[],                     -- Array for multi-device support
  privacy_settings JSONB DEFAULT '{"show_phone": false}',
  created_at TIMESTAMPTZ DEFAULT now()
);
```

### 3.2 Core Business Entities

```sql
-- 3. Resource Points
CREATE TABLE resource_points (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  type TEXT NOT NULL,                    -- water, shelter, medical
  location GEOGRAPHY(POINT) NOT NULL,    -- PostGIS
  is_temporary BOOLEAN DEFAULT false,
  expires_at TIMESTAMPTZ,
  created_by UUID REFERENCES auth.users(id)
);

-- 4. Tasks
CREATE TABLE tasks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  status TEXT DEFAULT 'open',            -- open, in_progress, done
  is_priority BOOLEAN DEFAULT false,     -- Protected Field: Only Leader+ can change
  location GEOGRAPHY(POINT),
  needed_roles TEXT[],
  author_id UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 5. Shuttles
CREATE TABLE shuttles (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  display_id TEXT GENERATED ALWAYS AS ('S-' || SUBSTRING(id::text, 1, 5)) STORED,
  title TEXT NOT NULL,
  status TEXT DEFAULT 'open',
  is_priority BOOLEAN DEFAULT false,     -- Protected Field
  origin_loc GEOGRAPHY(POINT) NOT NULL,
  dest_loc GEOGRAPHY(POINT) NOT NULL,
  depart_at TIMESTAMPTZ NOT NULL,
  seats_total INT NOT NULL,
  seats_taken INT DEFAULT 0,
  created_by UUID REFERENCES auth.users(id), -- Driver/Creator
  vehicle_info JSONB                     -- {plate: 'ABC-123'}
);

-- 6. Shuttle Participants (Join Table)
CREATE TABLE shuttle_participants (
  shuttle_id UUID REFERENCES shuttles(id),
  user_id UUID REFERENCES auth.users(id),
  role TEXT DEFAULT 'passenger',
  joined_at TIMESTAMPTZ DEFAULT now(),
  PRIMARY KEY (shuttle_id, user_id)
);
```

---

## 4\. Complex Security & RBAC Implementation

> **Core Section:** Implementation of Rate Limiting and Role Matrix.

### 4.1 Basic Helper Functions

```sql
-- Get Current User Role
CREATE OR REPLACE FUNCTION auth_role() RETURNS text AS $$
  SELECT role FROM profiles_public WHERE id = auth.uid();
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- Check if User is Leader or Above
CREATE OR REPLACE FUNCTION is_leader_or_above() RETURNS boolean AS $$
  SELECT auth_role() IN ('Leader', 'Admin', 'Superadmin');
$$ LANGUAGE sql STABLE SECURITY DEFINER;
```

### 4.2 Business Logic Protection (Triggers)

**A. Rate Limit**
_Rule: Standard Users/Superusers can only create 1 task per hour. Leaders and above are exempt._

```sql
CREATE OR REPLACE FUNCTION check_task_rate_limit() RETURNS TRIGGER AS $$
DECLARE
  recent_count int;
BEGIN
  -- Exemption List
  IF is_leader_or_above() THEN RETURN NEW; END IF;

  -- Check count in the last hour
  SELECT COUNT(*) INTO recent_count FROM tasks
  WHERE author_id = auth.uid() AND created_at > (now() - INTERVAL '1 hour');

  IF recent_count >= 1 THEN
    RAISE EXCEPTION 'Rate limit exceeded: 1 task per hour for standard users.';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_task_rate_limit BEFORE INSERT ON tasks
  FOR EACH ROW EXECUTE FUNCTION check_task_rate_limit();
```

**B. Field Level Security**
_Rule: Only Leaders and above can modify `is_priority`._

```sql
CREATE OR REPLACE FUNCTION protect_priority_field() RETURNS TRIGGER AS $$
BEGIN
  IF (NEW.is_priority IS DISTINCT FROM OLD.is_priority) AND NOT is_leader_or_above() THEN
    RAISE EXCEPTION 'Permission denied: Only Leaders can change priority.';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_protect_task_priority BEFORE UPDATE ON tasks
  FOR EACH ROW EXECUTE FUNCTION protect_priority_field();
```

### 4.3 RLS Policy Matrix

**Tasks**

- **User+**: Create (subject to Rate Limit), Edit Own.
- **Leader+**: Manage All.

<!-- end list -->

```sql
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read" ON tasks FOR SELECT USING (true);

CREATE POLICY "Auth create" ON tasks FOR INSERT
  WITH CHECK ( auth.uid() IS NOT NULL );

CREATE POLICY "Owner or Leader update" ON tasks FOR UPDATE
  USING ( auth.uid() = author_id OR is_leader_or_above() );

CREATE POLICY "Owner or Leader delete" ON tasks FOR DELETE
  USING ( auth.uid() = author_id OR is_leader_or_above() );
```

**Shuttles**

- **Visitor**: No Access.
- **User+**: Create, Manage Own.
- **Leader+**: Manage All.

<!-- end list -->

```sql
ALTER TABLE shuttles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Auth read" ON shuttles FOR SELECT
  USING ( auth.uid() IS NOT NULL ); -- Visitor cannot see

CREATE POLICY "Auth create" ON shuttles FOR INSERT
  WITH CHECK ( auth.uid() IS NOT NULL );

CREATE POLICY "Owner or Leader manage" ON shuttles FOR ALL
  USING ( auth.uid() = created_by OR is_leader_or_above() );
```

---

## 5\. API & RPC Contracts

Since the Client cannot directly modify high-privilege fields (like Roles), we use Database Functions or Edge Functions.

### 5.1 Role Promotion (RPC)

**Function Name:** `admin_appoint_role`
**Type:** Database Function (Security Definer)
**Params:** `target_uid (uuid)`, `new_role (text)`
**Logic:**

1.  Check if Caller is `Superadmin` (if promoting to Leader) or `Leader+` (if promoting to Superuser).
2.  Update `profiles_public`.

### 5.2 Join Shuttle (RPC)

**Function Name:** `join_shuttle`
**Logic:** Atomic Transaction.

1.  Lock the Shuttle Row (`FOR UPDATE`).
2.  Check `seats_taken < seats_total`.
3.  Insert into `shuttle_participants`.
4.  Update `seats_taken = seats_taken + 1`.

---

## 6\. UI/UX Specifications (Flutter Implementation)

**Navigation Graph (GoRouter)**

```text
/login
/home (Tabs)
  ├─ /announcements
  ├─ /tasks
  │   ├─ /create
  │   └─ /:taskId (Detail & Chat)
  ├─ /shuttles
  │   ├─ /create
  │   ├─ /my-shuttles (Tabs: Created/Joined/History)
  │   └─ /:shuttleId (Detail & Realtime Map)
  └─ /profile
      └─ /admin-panel (Guard: Role >= Admin)
```

**Role-Based UI Components**

- **FAB (Create Task):** Wrapped in `ConsumerWidget` listening to `userProvider`. Hidden if Role == Visitor.
- **Priority Checkbox:** `enabled` only if `is_leader_or_above() == true`.
- **Admin Panel:** Visible only to Admin+, used for role approval and referral code generation.

---

## 7\. Development Roadmap

1.  **Week 1: Infrastructure**
    - Supabase init & SQL Deployment (Apply Schema & RLS above).
    - Flutter init & Auth Flow (Login/Register/Profile Sync).
2.  **Week 2: Core Features**
    - Resource Points Map (Google Maps).
    - Tasks CRUD + Rate Limit Testing (Unit Test Focus).
3.  **Week 3: Shuttle System**
    - Shuttle CRUD.
    - RPC `join_shuttle` Integration.
    - Realtime Location Broadcasting.
4.  **Week 4: Final Polish & Delivery**
    - Offline Caching (Isar).
    - Push Notifications (Edge Functions).
    - Full System Penetration Testing (Permissions).

---

**End of Specification**

```

```
