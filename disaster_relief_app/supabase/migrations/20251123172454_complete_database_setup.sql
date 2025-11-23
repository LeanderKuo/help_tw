set client_encoding = 'UTF8';
set check_function_bodies = off;

-- Extensions
create extension if not exists "pgcrypto";
create extension if not exists "postgis";

-- Drop old objects so the file can be rerun safely
drop table if exists public.notification_events cascade;
drop table if exists public.chat_messages cascade;
drop table if exists public.chat_rooms cascade;
drop table if exists public.participants cascade;
drop table if exists public.missions cascade;
drop table if exists public.shuttles cascade;
drop table if exists public.resource_points cascade;
drop table if exists public.announcements cascade;
drop table if exists public.user_devices cascade;
drop table if exists public.user_settings cascade;
drop table if exists public.profiles_private cascade;
drop table if exists public.profiles_public cascade;

drop function if exists public.geohash_6(geography) cascade;
drop function if exists public.set_mission_geodata() cascade;
drop function if exists public.set_shuttle_geodata() cascade;
drop function if exists public.set_resource_geodata() cascade;
drop function if exists public.sync_mission_manpower() cascade;
drop function if exists public.sync_shuttle_capacity() cascade;
drop function if exists public.raise_mission_critical_update() cascade;
drop function if exists public.raise_shuttle_critical_update() cascade;
drop function if exists public.create_chat_room_for_entity() cascade;
drop function if exists public.prune_expired_messages() cascade;
drop function if exists public.auth_role() cascade;
drop function if exists public.is_leader_or_above() cascade;
drop function if exists public.is_admin_or_above() cascade;

-- Helper: short geohash
create or replace function public.geohash_6(p_geog geography) returns text
immutable
language sql as $$
  select case
    when p_geog is null then null
    else ST_GeoHash(p_geog::geometry, 6)
  end;
$$;

-- Helper: auth role lookup (kept minimal for policy checks)
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

-- 1) Identities & Preferences
create table public.profiles_public (
  id uuid primary key references auth.users (id) on delete cascade,
  display_id text generated always as ('U-' || substring(id::text, 1, 8)) stored,
  nickname text not null default 'User',
  role text not null default 'User' check (role in ('Root','Superadmin','Admin','Leader','Superuser','User','Visitor')),
  avatar_url text,
  locale text not null default 'zh-TW' check (locale in ('zh-TW','en-US')),
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

-- 2) Announcements (bilingual payloads)
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
  categories text[] not null default '{}',
  inventory jsonb not null default '[]',
  location geography(point, 4326),
  geohash text,
  status text not null default 'active' check (status in ('active','shortage','closed')),
  expiry_date timestamptz,
  created_by uuid references auth.users (id) on delete set null,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.resource_points
  add constraint resource_points_title_locale check (title ? 'zh-TW' and title ? 'en-US');

create index resource_points_location_idx on public.resource_points using gist (location);
create index resource_points_geohash_idx on public.resource_points (geohash);

-- 4) Missions
create table public.missions (
  id uuid default gen_random_uuid() primary key,
  creator_id uuid references auth.users (id) on delete set null,
  title jsonb not null,
  description jsonb,
  types text[] not null default '{}',
  status text not null default 'open' check (status in ('open','in_progress','done','canceled')),
  priority boolean default false,
  location jsonb,
  geohash text,
  requirements jsonb not null default '{"materials": [], "manpower_needed": 0, "manpower_current": 0}',
  interaction jsonb not null default '{"chat_room_id": null, "contact_phone_visible": false}',
  last_critical_update timestamptz,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.missions
  add constraint missions_title_locale check (title ? 'zh-TW' and title ? 'en-US');

create index missions_geohash_idx on public.missions (geohash);
create index missions_status_created_idx on public.missions (status, created_at desc);

-- 5) Shuttles
create table public.shuttles (
  id uuid default gen_random_uuid() primary key,
  creator_id uuid references auth.users (id) on delete set null,
  title jsonb not null,
  description jsonb,
  purposes text[] not null default '{}',
  vehicle_info jsonb,
  route jsonb,
  schedule jsonb,
  capacity jsonb not null default '{"total": 0, "taken": 0, "remaining": 0}',
  cost_info jsonb not null default '{"type": "free"}',
  status text not null default 'open' check (status in ('open','in_progress','done','canceled')),
  origin_geohash text,
  destination_geohash text,
  last_critical_update timestamptz,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  constraint shuttles_capacity_bounds check (
    coalesce((capacity->>'total')::int, 0) >= 0
    and coalesce((capacity->>'taken')::int, 0) >= 0
    and coalesce((capacity->>'taken')::int, 0) <= coalesce((capacity->>'total')::int, 0)
  )
);

alter table public.shuttles
  add constraint shuttles_title_locale check (title ? 'zh-TW' and title ? 'en-US');

create index shuttles_status_depart_idx on public.shuttles (status, created_at desc);
create index shuttles_origin_geohash_idx on public.shuttles (origin_geohash);
create index shuttles_destination_geohash_idx on public.shuttles (destination_geohash);

-- 6) Unified Participants (missions / shuttles)
create table public.participants (
  entity_id uuid not null,
  entity_type text not null check (entity_type in ('mission','shuttle')),
  user_id uuid not null references auth.users (id) on delete cascade,
  role text not null default 'helper' check (role in ('driver','passenger','helper','commander')),
  status text not null default 'joined' check (status in ('joined','waitlist','approved')),
  is_contact_visible boolean default false,
  joined_at timestamptz default now(),
  primary key (entity_id, entity_type, user_id)
);

-- 7) Chat Rooms & Messages
create table public.chat_rooms (
  id uuid default gen_random_uuid() primary key,
  entity_id uuid not null,
  entity_type text not null check (entity_type in ('mission','shuttle')),
  created_at timestamptz default now(),
  unique (entity_id, entity_type)
);

create table public.chat_messages (
  id uuid default gen_random_uuid() primary key,
  chat_room_id uuid references public.chat_rooms (id) on delete cascade,
  sender_id uuid references auth.users (id) on delete set null,
  content text,
  image_url text,
  created_at timestamptz default now(),
  expires_at timestamptz default (now() + interval '30 days')
);

create index chat_messages_room_idx on public.chat_messages (chat_room_id, created_at);
create index chat_messages_expiry_idx on public.chat_messages (expires_at);

-- 8) Notification events (for critical updates)
create table public.notification_events (
  id bigserial primary key,
  entity_type text not null check (entity_type in ('mission','shuttle')),
  entity_id uuid not null,
  payload jsonb not null,
  created_at timestamptz default now()
);

-- Helper: derive geography + geohash for missions
create or replace function public.set_mission_geodata() returns trigger as $$
declare
  v_lat numeric;
  v_lng numeric;
  v_geog geography;
begin
  if new.location is null then
    new.geohash := null;
    return new;
  end if;

  v_lat := nullif(new.location->>'lat', '')::numeric;
  v_lng := nullif(new.location->>'lng', '')::numeric;
  if v_lat is null or v_lng is null then
    new.geohash := null;
    return new;
  end if;

  v_geog := ST_SetSRID(ST_MakePoint(v_lng, v_lat), 4326)::geography;
  new.geohash := public.geohash_6(v_geog);
  return new;
end;
$$ language plpgsql;

-- Helper: derive geohash for shuttles (origin/destination)
create or replace function public.set_shuttle_geodata() returns trigger as $$
declare
  v_orig_lat numeric;
  v_orig_lng numeric;
  v_dest_lat numeric;
  v_dest_lng numeric;
begin
  if new.route is not null then
    v_orig_lat := nullif((new.route->'origin'->>'lat'), '')::numeric;
    v_orig_lng := nullif((new.route->'origin'->>'lng'), '')::numeric;
    v_dest_lat := nullif((new.route->'destination'->>'lat'), '')::numeric;
    v_dest_lng := nullif((new.route->'destination'->>'lng'), '')::numeric;
  end if;

  if v_orig_lat is not null and v_orig_lng is not null then
    new.origin_geohash := public.geohash_6(ST_SetSRID(ST_MakePoint(v_orig_lng, v_orig_lat), 4326)::geography);
  else
    new.origin_geohash := null;
  end if;

  if v_dest_lat is not null and v_dest_lng is not null then
    new.destination_geohash := public.geohash_6(ST_SetSRID(ST_MakePoint(v_dest_lng, v_dest_lat), 4326)::geography);
  else
    new.destination_geohash := null;
  end if;

  return new;
end;
$$ language plpgsql;

-- Helper: derive geohash for resource_points
create or replace function public.set_resource_geodata() returns trigger as $$
begin
  if new.location is null then
    new.geohash := null;
    return new;
  end if;
  new.geohash := public.geohash_6(new.location);
  return new;
end;
$$ language plpgsql;

-- Sync manpower_current inside missions.requirements based on joined participants
create or replace function public.sync_mission_manpower() returns trigger as $$
declare
  v_mission uuid;
  v_count int;
begin
  if coalesce(new.entity_type, old.entity_type) <> 'mission' then
    return null;
  end if;

  v_mission := coalesce(new.entity_id, old.entity_id);
  select count(*) into v_count
  from public.participants
  where entity_id = v_mission
    and entity_type = 'mission'
    and status = 'joined';

  update public.missions
    set requirements = jsonb_set(
          coalesce(requirements, '{"materials": [], "manpower_needed": 0, "manpower_current": 0}'::jsonb),
          '{manpower_current}',
          to_jsonb(v_count),
          true
        ),
        updated_at = now()
  where id = v_mission;
  return null;
end;
$$ language plpgsql;

-- Sync shuttle capacity.taken/remaining based on joined participants
create or replace function public.sync_shuttle_capacity() returns trigger as $$
declare
  v_shuttle uuid;
  v_taken int;
  v_total int;
  v_remaining int;
  v_capacity jsonb;
begin
  if coalesce(new.entity_type, old.entity_type) <> 'shuttle' then
    return null;
  end if;

  v_shuttle := coalesce(new.entity_id, old.entity_id);

  select count(*) into v_taken
  from public.participants
  where entity_id = v_shuttle
    and entity_type = 'shuttle'
    and status = 'joined';

  select coalesce((capacity->>'total')::int, 0) into v_total
  from public.shuttles where id = v_shuttle;

  v_remaining := greatest(v_total - v_taken, 0);
  v_capacity := jsonb_build_object(
    'total', v_total,
    'taken', v_taken,
    'remaining', v_remaining
  );

  update public.shuttles
    set capacity = v_capacity,
        updated_at = now()
  where id = v_shuttle;

  return null;
end;
$$ language plpgsql;

-- Critical update notifier for missions
create or replace function public.raise_mission_critical_update() returns trigger as $$
declare
  v_fields text[] := '{}';
begin
  if new.status = 'in_progress' then
    if new.location is distinct from old.location then
      v_fields := array_append(v_fields, 'location');
      new.last_critical_update := now();
    end if;
  end if;

  if array_length(v_fields, 1) is null then
    return new;
  end if;

  insert into public.notification_events (entity_type, entity_id, payload)
  values (
    'mission',
    new.id,
    jsonb_build_object(
      'changed_fields', v_fields,
      'status', new.status,
      'updated_at', now()
    )
  );
  return new;
end;
$$ language plpgsql;

-- Critical update notifier for shuttles (schedule/route)
create or replace function public.raise_shuttle_critical_update() returns trigger as $$
declare
  v_fields text[] := '{}';
begin
  if new.status = 'in_progress' then
    if new.route is distinct from old.route then
      v_fields := array_append(v_fields, 'route');
    end if;
    if new.schedule is distinct from old.schedule then
      v_fields := array_append(v_fields, 'schedule');
    end if;
    if array_length(v_fields, 1) > 0 then
      new.last_critical_update := now();
    end if;
  end if;

  if array_length(v_fields, 1) is null then
    return new;
  end if;

  insert into public.notification_events (entity_type, entity_id, payload)
  values (
    'shuttle',
    new.id,
    jsonb_build_object(
      'changed_fields', v_fields,
      'status', new.status,
      'updated_at', now()
    )
  );
  return new;
end;
$$ language plpgsql;

-- Auto-create a chat room for each entity and wire mission.interaction.chat_room_id
create or replace function public.create_chat_room_for_entity() returns trigger as $$
declare
  v_room_id uuid;
  v_entity_type text;
begin
  v_entity_type := case
    when tg_table_name = 'missions' then 'mission'
    when tg_table_name = 'shuttles' then 'shuttle'
    else tg_table_name
  end;

  -- Insert chat room if missing
  insert into public.chat_rooms (entity_id, entity_type)
  values (new.id, v_entity_type)
  on conflict (entity_id, entity_type) do update set entity_id = excluded.entity_id
  returning id into v_room_id;

  if tg_table_name = 'missions' then
    update public.missions
      set interaction = jsonb_set(
            coalesce(interaction, '{}'::jsonb),
            '{chat_room_id}',
            to_jsonb(v_room_id::text),
            true
          ),
          updated_at = now()
    where id = new.id;
  end if;
  return null;
end;
$$ language plpgsql;

-- Purge expired chat messages (callable by cron)
create or replace function public.prune_expired_messages() returns void as $$
begin
  delete from public.chat_messages where expires_at <= now();
end;
$$ language plpgsql security definer;

-- Triggers
create trigger trg_mission_geodata
  before insert or update on public.missions
  for each row execute procedure public.set_mission_geodata();

create trigger trg_shuttle_geodata
  before insert or update on public.shuttles
  for each row execute procedure public.set_shuttle_geodata();

create trigger trg_resource_geodata
  before insert or update on public.resource_points
  for each row execute procedure public.set_resource_geodata();

create trigger trg_participants_mission_sync
  after insert or delete or update on public.participants
  for each row execute procedure public.sync_mission_manpower();

create trigger trg_participants_shuttle_sync
  after insert or delete or update on public.participants
  for each row execute procedure public.sync_shuttle_capacity();

create trigger trg_mission_critical_update
  before update on public.missions
  for each row execute procedure public.raise_mission_critical_update();

create trigger trg_shuttle_critical_update
  before update on public.shuttles
  for each row execute procedure public.raise_shuttle_critical_update();

create trigger trg_mission_chat_room
  after insert on public.missions
  for each row execute procedure public.create_chat_room_for_entity();

create trigger trg_shuttle_chat_room
  after insert on public.shuttles
  for each row execute procedure public.create_chat_room_for_entity();

-- Row Level Security
alter table public.profiles_public enable row level security;
alter table public.profiles_private enable row level security;
alter table public.user_settings enable row level security;
alter table public.user_devices enable row level security;
alter table public.announcements enable row level security;
alter table public.resource_points enable row level security;
alter table public.missions enable row level security;
alter table public.shuttles enable row level security;
alter table public.participants enable row level security;
alter table public.chat_rooms enable row level security;
alter table public.chat_messages enable row level security;
alter table public.notification_events enable row level security;

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

-- missions
create policy missions_select on public.missions
  for select using (true);
create policy missions_insert on public.missions
  for insert with check (auth.uid() is not null and creator_id = auth.uid());
create policy missions_update on public.missions
  for update using (auth.uid() = creator_id or is_leader_or_above());
create policy missions_delete on public.missions
  for delete using (auth.uid() = creator_id or is_leader_or_above());

-- shuttles
create policy shuttles_select on public.shuttles
  for select using (true);
create policy shuttles_insert on public.shuttles
  for insert with check (auth.uid() is not null and creator_id = auth.uid());
create policy shuttles_update on public.shuttles
  for update using (auth.uid() = creator_id or is_leader_or_above());
create policy shuttles_delete on public.shuttles
  for delete using (auth.uid() = creator_id or is_leader_or_above());

-- participants
create policy participants_select on public.participants
  for select using (
    auth.uid() is not null and (
      user_id = auth.uid()
      or is_leader_or_above()
      or (
        entity_type = 'mission' and exists (
          select 1 from public.missions m where m.id = entity_id and m.creator_id = auth.uid()
        )
      )
      or (
        entity_type = 'shuttle' and exists (
          select 1 from public.shuttles s where s.id = entity_id and s.creator_id = auth.uid()
        )
      )
    )
  );
create policy participants_insert on public.participants
  for insert with check (auth.uid() is not null and auth.uid() = user_id);
create policy participants_update on public.participants
  for update using (
    auth.uid() = user_id
    or is_leader_or_above()
    or (
      entity_type = 'mission' and exists (
        select 1 from public.missions m where m.id = entity_id and m.creator_id = auth.uid()
      )
    )
    or (
      entity_type = 'shuttle' and exists (
        select 1 from public.shuttles s where s.id = entity_id and s.creator_id = auth.uid()
      )
    )
  );
create policy participants_delete on public.participants
  for delete using (
    auth.uid() = user_id
    or is_leader_or_above()
    or (
      entity_type = 'mission' and exists (
        select 1 from public.missions m where m.id = entity_id and m.creator_id = auth.uid()
      )
    )
    or (
      entity_type = 'shuttle' and exists (
        select 1 from public.shuttles s where s.id = entity_id and s.creator_id = auth.uid()
      )
    )
  );

-- chat_rooms
create policy chat_rooms_select on public.chat_rooms
  for select using (
    auth.uid() is not null and (
      is_leader_or_above()
      or exists (
        select 1 from public.participants p
        where p.entity_id = entity_id
          and p.entity_type = chat_rooms.entity_type
          and p.user_id = auth.uid()
          and p.status = 'joined'
      )
    )
  );

-- chat_messages
create policy chat_messages_select on public.chat_messages
  for select using (
    auth.uid() is not null and (
      is_leader_or_above()
      or exists (
        select 1
        from public.chat_rooms r
        join public.participants p
          on p.entity_id = r.entity_id
         and p.entity_type = r.entity_type
        where r.id = chat_messages.chat_room_id
          and p.user_id = auth.uid()
          and p.status = 'joined'
      )
    )
  );
create policy chat_messages_insert on public.chat_messages
  for insert with check (
    auth.uid() is not null and (
      is_leader_or_above()
      or exists (
        select 1
        from public.chat_rooms r
        join public.participants p
          on p.entity_id = r.entity_id
         and p.entity_type = r.entity_type
        where r.id = chat_messages.chat_room_id
          and p.user_id = auth.uid()
          and p.status = 'joined'
      )
    )
  );

-- notification_events (readable by service/leader; writes via triggers)
create policy notification_events_select on public.notification_events
  for select using (is_leader_or_above());
