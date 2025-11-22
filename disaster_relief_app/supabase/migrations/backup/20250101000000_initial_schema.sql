set client_encoding = 'UTF8';
set check_function_bodies = off;

-- Extensions
create extension if not exists "pgcrypto";
create extension if not exists "postgis";

-- Drop old objects so the file can be rerun safely
drop function if exists public.join_shuttle(uuid, text, boolean) cascade;
drop function if exists public.leave_shuttle(uuid) cascade;
drop function if exists public.check_task_rate_limit() cascade;
drop function if exists public.protect_task_priority() cascade;
drop function if exists public.ensure_shuttle_capacity() cascade;
drop function if exists public.sync_task_participant_count() cascade;
drop function if exists public.sync_shuttle_seats_taken() cascade;
drop function if exists public.auth_role() cascade;
drop function if exists public.is_leader_or_above() cascade;
drop function if exists public.is_admin_or_above() cascade;
drop function if exists public.mask_phone(text) cascade;
drop function if exists public.handle_new_user() cascade;
drop function if exists public.prune_expired_messages() cascade;
drop function if exists public.geohash_6(geography) cascade;

drop table if exists public.shuttle_messages cascade;
drop table if exists public.task_messages cascade;
drop table if exists public.shuttle_participants cascade;
drop table if exists public.task_participants cascade;
drop table if exists public.shuttles cascade;
drop table if exists public.tasks cascade;
drop table if exists public.resource_points cascade;
drop table if exists public.announcements cascade;
drop table if exists public.referral_codes cascade;
drop table if exists public.audit_logs cascade;
drop table if exists public.user_devices cascade;
drop table if exists public.user_settings cascade;
drop table if exists public.profiles_private cascade;
drop table if exists public.profiles_public cascade;

-- Helper function (must exist before generated columns)
create or replace function public.geohash_6(p_geog geography) returns text
immutable
language sql as $$
  select case
    when p_geog is null then null
    else ST_GeoHash(p_geog::geometry, 6)
  end;
$$;

-- 1) Identities & Preferences (UTF-8 / bilingual ready)
create table public.profiles_public (
  id uuid primary key references auth.users (id) on delete cascade,
  display_id text generated always as ('U-' || substring(id::text, 1, 8)) stored,
  nickname text not null default 'User',
  role text not null default 'User' check (role in ('Root','Superadmin','Admin','Leader','Superuser','User','Visitor')),
  masked_phone text,
  locale text not null default 'zh-TW' check (locale in ('zh-TW','en-US')),
  avatar_url text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table public.profiles_private (
  id uuid primary key references auth.users (id) on delete cascade,
  email text,
  full_name text,
  real_phone text,
  privacy_settings jsonb not null default '{"show_phone": false, "show_email": false}',
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table public.user_settings (
  user_id uuid primary key references auth.users (id) on delete cascade,
  language text not null default 'zh-TW' check (language in ('zh-TW','en-US')),
  timezone text default 'Asia/Taipei',
  push_enabled boolean default true,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table public.user_devices (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users (id) on delete cascade,
  fcm_token text unique,
  platform text,
  locale text default 'zh-TW',
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create index idx_user_devices_user on public.user_devices (user_id);

-- 2) Announcements (supports zh-TW / en-US payloads)
create table public.announcements (
  id uuid default gen_random_uuid() primary key,
  type text not null check (type in ('general','emergency')),
  title jsonb not null,
  body jsonb not null,
  is_active boolean default true,
  is_pinned boolean default false,
  starts_at timestamptz default now(),
  ends_at timestamptz,
  created_by uuid references auth.users (id),
  created_at timestamptz default now()
);

alter table public.announcements
  add constraint announcements_title_locale check (title ? 'zh-TW' and title ? 'en-US'),
  add constraint announcements_body_locale check (body ? 'zh-TW' and body ? 'en-US');

create unique index announcements_emergency_active_idx
  on public.announcements (type)
  where type = 'emergency' and is_active;

-- 3) Resource Points
create table public.resource_points (
  id uuid default gen_random_uuid() primary key,
  title jsonb not null,
  description jsonb,
  category text not null check (category in ('permanent','temporary')),
  resource_type text not null default 'other',
  address text,
  location geography(point, 4326) not null,
  geohash text,
  is_active boolean default true,
  expires_at timestamptz,
  contact_masked_phone text,
  tags text[] default '{}',
  created_by uuid references auth.users (id),
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.resource_points
  add constraint resource_points_title_locale check (title ? 'zh-TW' and title ? 'en-US');

create index resource_points_location_idx on public.resource_points using gist (location);
create unique index resource_points_geohash_unique
  on public.resource_points (geohash)
  where is_active;

-- 4) Tasks
create table public.tasks (
  id uuid default gen_random_uuid() primary key,
  display_id text generated always as ('T-' || substring(id::text, 1, 6)) stored,
  title text not null,
  description text,
  status text not null default 'open' check (status in ('open','in_progress','done','canceled')),
  is_priority boolean default false,
  role_label text default '任務發起人',
  location geography(point, 4326),
  geohash text,
  address text,
  materials_status text default '穩定' check (materials_status in ('穩定','不足','急缺','未知')),
  needed_roles text[] default '{}',
  required_participants int default 0,
  author_id uuid references auth.users (id),
  participant_count int not null default 0,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create index tasks_location_idx on public.tasks using gist (location);
create index tasks_status_depart_idx on public.tasks (status, created_at);

create table public.task_participants (
  task_id uuid references public.tasks (id) on delete cascade,
  user_id uuid references auth.users (id) on delete cascade,
  is_visible boolean default true,
  joined_at timestamptz default now(),
  primary key (task_id, user_id)
);

create table public.task_messages (
  id uuid default gen_random_uuid() primary key,
  task_id uuid references public.tasks (id) on delete cascade,
  author_id uuid references auth.users (id),
  content text not null,
  created_at timestamptz default now(),
  expires_at timestamptz default (now() + interval '30 days')
);

create index task_messages_task_idx on public.task_messages (task_id, created_at);
create index task_messages_expiry_idx on public.task_messages (expires_at);

-- 5) Shuttles
create table public.shuttles (
  id uuid default gen_random_uuid() primary key,
  display_id text generated always as ('S-' || substring(id::text, 1, 6)) stored,
  title text not null,
  description text,
  status text not null default 'open' check (status in ('open','in_progress','done','canceled')),
  is_priority boolean default false,
  origin geography(point, 4326) not null,
  origin_geohash text,
  destination geography(point, 4326) not null,
  destination_geohash text,
  origin_address text,
  destination_address text,
  depart_at timestamptz not null,
  signup_deadline timestamptz,
  arrive_at timestamptz,
  cost_type text default 'free' check (cost_type in ('free','share_gas','paid')),
  fare_total numeric,
  fare_per_person numeric,
  seats_total int not null,
  seats_taken int not null default 0,
  vehicle jsonb,
  contact_name text,
  contact_phone_masked text,
  created_by uuid references auth.users (id),
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  expires_at timestamptz,
  constraint seats_not_negative check (seats_total >= 0 and seats_taken >= 0),
  constraint seats_not_overbooked check (seats_taken <= seats_total)
);

create index shuttles_origin_idx on public.shuttles using gist (origin);
create index shuttles_destination_idx on public.shuttles using gist (destination);
create index shuttles_status_depart_idx on public.shuttles (status, depart_at);

create table public.shuttle_participants (
  shuttle_id uuid references public.shuttles (id) on delete cascade,
  user_id uuid references auth.users (id) on delete cascade,
  role text default 'passenger' check (role in ('driver','staff','passenger')),
  is_visible boolean default true,
  joined_at timestamptz default now(),
  primary key (shuttle_id, user_id)
);

create table public.shuttle_messages (
  id uuid default gen_random_uuid() primary key,
  shuttle_id uuid references public.shuttles (id) on delete cascade,
  author_id uuid references auth.users (id),
  content text not null,
  created_at timestamptz default now(),
  expires_at timestamptz default (now() + interval '30 days')
);

create index shuttle_messages_idx on public.shuttle_messages (shuttle_id, created_at);
create index shuttle_messages_expiry_idx on public.shuttle_messages (expires_at);

-- 6) Referral codes & Audit logs
create table public.referral_codes (
  code text primary key,
  issuer_id uuid references auth.users (id),
  issued_for_role text not null check (issued_for_role in ('Superuser','Leader','Admin')),
  expires_at timestamptz not null,
  is_consumed boolean default false,
  redeemed_by uuid references auth.users (id),
  redeemed_at timestamptz,
  created_at timestamptz default now()
);

create unique index referral_codes_active_per_issuer
  on public.referral_codes (issuer_id)
  where is_consumed = false;

create table public.audit_logs (
  id bigserial primary key,
  actor_id uuid,
  action text not null,
  target_type text,
  target_id uuid,
  meta jsonb,
  created_at timestamptz default now()
);

-- Helper Functions
create or replace function public.geohash_6(p_geog geography) returns text
immutable
language sql as $$
  select case
    when p_geog is null then null
    else ST_GeoHash(p_geog::geometry, 6)
  end;
$$;

create or replace function public.auth_role() returns text as $$
  select coalesce(
    (select role from public.profiles_public where id = auth.uid()),
    'Visitor'
  );
$$ language sql stable security definer;

create or replace function public.is_leader_or_above() returns boolean as $$
  select auth_role() in ('Leader','Admin','Superadmin','Root');
$$ language sql stable security definer;

create or replace function public.is_admin_or_above() returns boolean as $$
  select auth_role() in ('Admin','Superadmin','Root');
$$ language sql stable security definer;

create or replace function public.mask_phone(p_phone text) returns text as $$
  select case
    when p_phone is null then null
    when length(p_phone) < 5 then '***'
    else substring(p_phone from 1 for 4) || repeat('*', greatest(length(p_phone) - 7, 3)) || substring(p_phone from length(p_phone)-2 for 3)
  end;
$$ language sql immutable;

-- Rate limit: non-leader users can only create 1 task per hour
create or replace function public.check_task_rate_limit() returns trigger as $$
declare
  recent_count int;
begin
  if is_leader_or_above() then
    return new;
  end if;

  select count(*) into recent_count
  from public.tasks
  where author_id = auth.uid()
    and created_at > (now() - interval '1 hour');

  if recent_count >= 1 then
    raise exception 'Rate limit exceeded: 1 task per hour for standard users.';
  end if;
  return new;
end;
$$ language plpgsql;

-- Protect task priority flag
create or replace function public.protect_task_priority() returns trigger as $$
begin
  if (new.is_priority is distinct from old.is_priority) and not is_leader_or_above() then
    raise exception 'Permission denied: only Leader+ can change priority flag.';
  end if;
  return new;
end;
$$ language plpgsql;

-- Maintain participant counts on tasks
create or replace function public.sync_task_participant_count() returns trigger as $$
declare
  v_task_id uuid;
begin
  v_task_id := coalesce(new.task_id, old.task_id);
  update public.tasks
    set participant_count = (
      select count(*) from public.task_participants where task_id = v_task_id
    ),
    updated_at = now()
  where id = v_task_id;
  return null;
end;
$$ language plpgsql;

-- Enforce shuttle capacity before insert
create or replace function public.ensure_shuttle_capacity() returns trigger as $$
declare
  v_total int;
  v_taken int;
begin
  select seats_total, seats_taken into v_total, v_taken
  from public.shuttles
  where id = new.shuttle_id
  for update;

  if v_total is null then
    raise exception 'Shuttle not found';
  end if;

  if v_taken >= v_total then
    raise exception 'Shuttle is full';
  end if;
  return new;
end;
$$ language plpgsql;

-- Maintain seats_taken on shuttles
create or replace function public.sync_shuttle_seats_taken() returns trigger as $$
declare
  v_shuttle uuid;
begin
  v_shuttle := coalesce(new.shuttle_id, old.shuttle_id);
  update public.shuttles
    set seats_taken = (
      select count(*) from public.shuttle_participants where shuttle_id = v_shuttle
    ),
    updated_at = now()
  where id = v_shuttle;
  return null;
end;
$$ language plpgsql;

-- Maintain geohash on resource_points
create or replace function public.set_resource_geohash() returns trigger as $$
begin
  new.geohash := public.geohash_6(new.location);
  return new;
end;
$$ language plpgsql;

-- Maintain geohash on tasks
create or replace function public.set_task_geohash() returns trigger as $$
begin
  new.geohash := public.geohash_6(new.location);
  return new;
end;
$$ language plpgsql;

-- Maintain geohash and expires_at on shuttles
create or replace function public.set_shuttle_geodata() returns trigger as $$
begin
  new.origin_geohash := public.geohash_6(new.origin);
  new.destination_geohash := public.geohash_6(new.destination);
  new.expires_at := new.depart_at + interval '7 days';
  return new;
end;
$$ language plpgsql;

-- RPC: join shuttle with capacity check
create or replace function public.join_shuttle(p_shuttle_id uuid, p_role text default 'passenger', p_is_visible boolean default true)
returns void as $$
declare
  v_shuttle public.shuttles%rowtype;
begin
  select * into v_shuttle from public.shuttles where id = p_shuttle_id for update;
  if not found then
    raise exception 'Shuttle not found';
  end if;
  if v_shuttle.seats_taken >= v_shuttle.seats_total then
    raise exception 'Shuttle is full';
  end if;

  insert into public.shuttle_participants (shuttle_id, user_id, role, is_visible)
  values (p_shuttle_id, auth.uid(), coalesce(p_role, 'passenger'), coalesce(p_is_visible, true))
  on conflict do nothing;

  update public.shuttles
    set seats_taken = (
      select count(*) from public.shuttle_participants where shuttle_id = p_shuttle_id
    ),
    updated_at = now()
  where id = p_shuttle_id;
end;
$$ language plpgsql security definer;

create or replace function public.leave_shuttle(p_shuttle_id uuid) returns void as $$
begin
  delete from public.shuttle_participants
  where shuttle_id = p_shuttle_id
    and user_id = auth.uid();

  update public.shuttles
    set seats_taken = (
      select count(*) from public.shuttle_participants where shuttle_id = p_shuttle_id
    ),
    updated_at = now()
  where id = p_shuttle_id;
end;
$$ language plpgsql security definer;

-- Auto purge expired messages (callable via cron)
create or replace function public.prune_expired_messages() returns void as $$
begin
  delete from public.task_messages where expires_at <= now();
  delete from public.shuttle_messages where expires_at <= now();
end;
$$ language plpgsql security definer;

-- Bootstrap profiles/settings on auth signup
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles_public (id, nickname, role, masked_phone)
  values (new.id, split_part(new.email, '@', 1), 'User', null)
  on conflict do nothing;

  insert into public.profiles_private (id, email, real_phone)
  values (new.id, new.email, null)
  on conflict do nothing;

  insert into public.user_settings (user_id)
  values (new.id)
  on conflict do nothing;

  return new;
end;
$$ language plpgsql security definer;

-- Triggers
create trigger trg_task_rate_limit
  before insert on public.tasks
  for each row execute procedure public.check_task_rate_limit();

create trigger trg_task_priority_protect
  before update on public.tasks
  for each row execute procedure public.protect_task_priority();

create trigger trg_task_participants_sync
  after insert or delete on public.task_participants
  for each row execute procedure public.sync_task_participant_count();

create trigger trg_resource_geohash
  before insert or update on public.resource_points
  for each row execute procedure public.set_resource_geohash();

create trigger trg_task_geohash
  before insert or update on public.tasks
  for each row execute procedure public.set_task_geohash();

create trigger trg_shuttle_geodata
  before insert or update on public.shuttles
  for each row execute procedure public.set_shuttle_geodata();

create trigger trg_shuttle_capacity
  before insert on public.shuttle_participants
  for each row execute procedure public.ensure_shuttle_capacity();

create trigger trg_shuttle_seats_sync
  after insert or delete on public.shuttle_participants
  for each row execute procedure public.sync_shuttle_seats_taken();

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- Row Level Security
alter table public.profiles_public enable row level security;
alter table public.profiles_private enable row level security;
alter table public.user_settings enable row level security;
alter table public.user_devices enable row level security;
alter table public.announcements enable row level security;
alter table public.resource_points enable row level security;
alter table public.tasks enable row level security;
alter table public.task_participants enable row level security;
alter table public.task_messages enable row level security;
alter table public.shuttles enable row level security;
alter table public.shuttle_participants enable row level security;
alter table public.shuttle_messages enable row level security;
alter table public.referral_codes enable row level security;
alter table public.audit_logs enable row level security;

-- profiles_public
create policy profiles_public_select on public.profiles_public
  for select using (true);
create policy profiles_public_insert on public.profiles_public
  for insert with check (auth.uid() = id);
create policy profiles_public_update on public.profiles_public
  for update using (auth.uid() = id or is_admin_or_above());

-- profiles_private
create policy profiles_private_select on public.profiles_private
  for select using (auth.uid() = id or is_admin_or_above());
create policy profiles_private_insert on public.profiles_private
  for insert with check (auth.uid() = id or is_admin_or_above());
create policy profiles_private_update on public.profiles_private
  for update using (auth.uid() = id or is_admin_or_above());

-- user_settings
create policy user_settings_select on public.user_settings
  for select using (auth.uid() = user_id);
create policy user_settings_modify on public.user_settings
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- user_devices
create policy user_devices_select on public.user_devices
  for select using (auth.uid() = user_id);
create policy user_devices_modify on public.user_devices
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- announcements
create policy announcements_select on public.announcements
  for select using (true);
create policy announcements_admin_manage on public.announcements
  for all using (is_admin_or_above()) with check (is_admin_or_above());

-- resource_points
create policy resource_points_select on public.resource_points
  for select using (true);
create policy resource_points_insert on public.resource_points
  for insert with check (auth.uid() is not null and created_by = auth.uid());
create policy resource_points_update on public.resource_points
  for update using (auth.uid() = created_by or is_leader_or_above());
create policy resource_points_delete on public.resource_points
  for delete using (auth.uid() = created_by or is_leader_or_above());

-- tasks
create policy tasks_select on public.tasks
  for select using (true);
create policy tasks_insert on public.tasks
  for insert with check (auth.uid() is not null and author_id = auth.uid());
create policy tasks_update on public.tasks
  for update using (auth.uid() = author_id or is_leader_or_above());
create policy tasks_delete on public.tasks
  for delete using (auth.uid() = author_id or is_leader_or_above());

-- task_participants
create policy task_participants_select on public.task_participants
  for select using (
    auth.uid() is not null and (
      user_id = auth.uid()
      or is_leader_or_above()
      or exists (select 1 from public.tasks t where t.id = task_id and t.author_id = auth.uid())
    )
  );
create policy task_participants_insert on public.task_participants
  for insert with check (auth.uid() is not null and auth.uid() = user_id);
create policy task_participants_delete on public.task_participants
  for delete using (auth.uid() = user_id or is_leader_or_above());

-- task_messages
create policy task_messages_select on public.task_messages
  for select using (
    auth.uid() is not null and (
      is_leader_or_above()
      or exists (select 1 from public.task_participants tp where tp.task_id = task_id and tp.user_id = auth.uid())
      or exists (select 1 from public.tasks t where t.id = task_id and t.author_id = auth.uid())
    )
  );
create policy task_messages_insert on public.task_messages
  for insert with check (
    auth.uid() is not null and (
      exists (select 1 from public.task_participants tp where tp.task_id = task_id and tp.user_id = auth.uid())
      or exists (select 1 from public.tasks t where t.id = task_id and t.author_id = auth.uid())
      or is_leader_or_above()
    )
  );

-- shuttles
create policy shuttles_select on public.shuttles
  for select using (auth.uid() is not null);
create policy shuttles_insert on public.shuttles
  for insert with check (auth.uid() is not null and created_by = auth.uid());
create policy shuttles_update on public.shuttles
  for update using (auth.uid() = created_by or is_leader_or_above());
create policy shuttles_delete on public.shuttles
  for delete using (auth.uid() = created_by or is_leader_or_above());

-- shuttle_participants
create policy shuttle_participants_select on public.shuttle_participants
  for select using (
    auth.uid() is not null and (
      user_id = auth.uid()
      or is_leader_or_above()
      or exists (select 1 from public.shuttles s where s.id = shuttle_id and s.created_by = auth.uid())
    )
  );
create policy shuttle_participants_insert on public.shuttle_participants
  for insert with check (auth.uid() is not null and auth.uid() = user_id);
create policy shuttle_participants_delete on public.shuttle_participants
  for delete using (auth.uid() = user_id or is_leader_or_above());

-- shuttle_messages
create policy shuttle_messages_select on public.shuttle_messages
  for select using (
    auth.uid() is not null and (
      is_leader_or_above()
      or exists (select 1 from public.shuttle_participants sp where sp.shuttle_id = shuttle_id and sp.user_id = auth.uid())
      or exists (select 1 from public.shuttles s where s.id = shuttle_id and s.created_by = auth.uid())
    )
  );
create policy shuttle_messages_insert on public.shuttle_messages
  for insert with check (
    auth.uid() is not null and (
      exists (select 1 from public.shuttle_participants sp where sp.shuttle_id = shuttle_id and sp.user_id = auth.uid())
      or exists (select 1 from public.shuttles s where s.id = shuttle_id and s.created_by = auth.uid())
      or is_leader_or_above()
    )
  );

-- referral_codes
create policy referral_codes_admin_only on public.referral_codes
  for all using (is_admin_or_above()) with check (is_admin_or_above());

-- audit_logs
create policy audit_logs_insert on public.audit_logs
  for insert with check (auth.uid() is not null);
create policy audit_logs_admin_read on public.audit_logs
  for select using (is_admin_or_above());

comment on function public.prune_expired_messages is 'Call via pg_cron @daily to enforce 30-day chat retention.';
