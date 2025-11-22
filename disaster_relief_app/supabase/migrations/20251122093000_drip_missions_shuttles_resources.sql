set client_encoding = 'UTF8';
set check_function_bodies = off;

-- Enable PostGIS extension for geography types
create extension if not exists postgis;

-- DRIP modules: Missions (Tasks), Shuttles, Resource Points
-- Aligned to specs_arch.md and specs_feature.md (bilingual jsonb content, RBAC, 30-day chat TTL)

-- Helpers / roles
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

create or replace function public.is_superuser_or_above() returns boolean as $$
  select auth_role() in ('Superuser','Leader','Admin','Superadmin','Root');
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

-- Enums
do $$ begin
  create type public.mission_status as enum ('open','in_progress','done','canceled');
exception when duplicate_object then null;
end $$;

do $$ begin
  create type public.shuttle_status as enum ('open','in_progress','done','canceled');
exception when duplicate_object then null;
end $$;

do $$ begin
  create type public.shuttle_cost_type as enum ('free','share_gas');
exception when duplicate_object then null;
end $$;

do $$ begin
  create type public.resource_status as enum ('active','shortage','closed');
exception when duplicate_object then null;
end $$;

-- Drops (idempotent for re-run in dev)
drop table if exists public.mission_messages cascade;
drop table if exists public.mission_participants cascade;
drop table if exists public.missions cascade;
drop table if exists public.shuttle_messages cascade;
drop table if exists public.shuttle_participants cascade;
drop table if exists public.shuttles cascade;
drop table if exists public.resource_points cascade;
drop table if exists public.chat_rooms cascade;
drop table if exists public.notification_events cascade;

-- Chat rooms (30-day TTL)
create table public.chat_rooms (
  id uuid primary key default gen_random_uuid(),
  entity_type text not null check (entity_type in ('mission','shuttle')),
  entity_id uuid not null,
  expires_at timestamptz not null default (now() + interval '30 days'),
  created_by uuid references auth.users (id),
  created_at timestamptz default now()
);

create index chat_rooms_entity_idx on public.chat_rooms (entity_type, entity_id);
create index chat_rooms_expiry_idx on public.chat_rooms (expires_at);

-- Missions (Tasks)
create table public.missions (
  id uuid primary key default gen_random_uuid(),
  title jsonb not null,
  description jsonb,
  types text[] not null default '{}',
  status public.mission_status not null default 'open',
  priority boolean default false,
  requirements jsonb not null default '{"materials": [], "manpower_needed": 0, "manpower_current": 0}',
  location jsonb not null,
  location_point geography(point, 4326) generated always as (
    case
      when location ? 'lat' and location ? 'lng'
        then ST_SetSRID(ST_MakePoint((location->>'lng')::double precision, (location->>'lat')::double precision), 4326)::geography
      else null
    end
  ) stored,
  geohash text generated always as (
    case
      when location ? 'lat' and location ? 'lng'
        then public.geohash_6(
          ST_SetSRID(ST_MakePoint((location->>'lng')::double precision, (location->>'lat')::double precision), 4326)::geography
        )
      else null
    end
  ) stored,
  contact_name text,
  contact_phone_masked text,
  creator_id uuid references auth.users (id),
  chat_room_id uuid references public.chat_rooms (id) on delete set null,
  participant_count int not null default 0,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  constraint missions_title_locale check (title ? 'zh-TW' and title ? 'en-US'),
  constraint missions_description_locale check (description is null or (description ? 'zh-TW' and description ? 'en-US')),
  constraint missions_types_allowed check (types <@ array['rescue','medical','transport','clearing','other']::text[]),
  constraint missions_location_shape check (location ? 'lat' and location ? 'lng' and location ? 'address')
);

create index missions_location_idx on public.missions using gist (location_point);
create index missions_status_idx on public.missions (status, created_at);
create index missions_types_gin on public.missions using gin (types);

create table public.mission_participants (
  mission_id uuid references public.missions (id) on delete cascade,
  user_id uuid references auth.users (id) on delete cascade,
  is_visible boolean default true,
  joined_at timestamptz default now(),
  primary key (mission_id, user_id)
);

create table public.mission_messages (
  id uuid primary key default gen_random_uuid(),
  mission_id uuid references public.missions (id) on delete cascade,
  author_id uuid references auth.users (id),
  content text not null,
  created_at timestamptz default now(),
  expires_at timestamptz default (now() + interval '30 days')
);

create index mission_messages_idx on public.mission_messages (mission_id, created_at);
create index mission_messages_expiry_idx on public.mission_messages (expires_at);

-- Shuttles (Transportation)
create table public.shuttles (
  id uuid primary key default gen_random_uuid(),
  title jsonb not null,
  description jsonb,
  vehicle_info jsonb not null,
  purposes text[] not null default '{}',
  route jsonb not null,
  route_origin geography(point, 4326) generated always as (
    case
      when route ? 'origin' and route->'origin' ? 'lat' and route->'origin' ? 'lng'
        then ST_SetSRID(ST_MakePoint((route->'origin'->>'lng')::double precision, (route->'origin'->>'lat')::double precision), 4326)::geography
      else null
    end
  ) stored,
  route_destination geography(point, 4326) generated always as (
    case
      when route ? 'destination' and route->'destination' ? 'lat' and route->'destination' ? 'lng'
        then ST_SetSRID(ST_MakePoint((route->'destination'->>'lng')::double precision, (route->'destination'->>'lat')::double precision), 4326)::geography
      else null
    end
  ) stored,
  origin_geohash text generated always as (
    case
      when route ? 'origin' and route->'origin' ? 'lat' and route->'origin' ? 'lng'
        then public.geohash_6(
          ST_SetSRID(ST_MakePoint((route->'origin'->>'lng')::double precision, (route->'origin'->>'lat')::double precision), 4326)::geography
        )
      else null
    end
  ) stored,
  destination_geohash text generated always as (
    case
      when route ? 'destination' and route->'destination' ? 'lat' and route->'destination' ? 'lng'
        then public.geohash_6(
          ST_SetSRID(ST_MakePoint((route->'destination'->>'lng')::double precision, (route->'destination'->>'lat')::double precision), 4326)::geography
        )
      else null
    end
  ) stored,
  schedule jsonb not null,
  capacity jsonb not null default '{"total": 0, "taken": 0, "remaining": 0}',
  cost_type public.shuttle_cost_type not null default 'free',
  status public.shuttle_status not null default 'open',
  priority boolean default false,
  contact_name text,
  contact_phone_masked text,
  creator_id uuid references auth.users (id),
  chat_room_id uuid references public.chat_rooms (id) on delete set null,
  participants_snapshot uuid[] default '{}',
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  constraint shuttles_title_locale check (title ? 'zh-TW' and title ? 'en-US'),
  constraint shuttles_description_locale check (description is null or (description ? 'zh-TW' and description ? 'en-US')),
  constraint shuttles_purposes_allowed check (purposes <@ array['evacuation','medical_transport','supply_transport','volunteer_shuttle','other']::text[]),
  constraint shuttles_vehicle_allowed check (vehicle_info ? 'type' and vehicle_info->>'type' in ('bus','van','car','truck','other')),
  constraint shuttles_route_shape check (
    route ? 'origin' and route ? 'destination'
    and route->'origin' ? 'lat' and route->'origin' ? 'lng'
    and route->'destination' ? 'lat' and route->'destination' ? 'lng'
  ),
  constraint shuttles_schedule_shape check (schedule ? 'depart_at'),
  constraint shuttles_capacity_shape check (
    (capacity ? 'total') and (capacity ? 'taken') and (capacity ? 'remaining')
    and (capacity->>'taken')::int <= (capacity->>'total')::int
    and (capacity->>'remaining')::int = greatest((capacity->>'total')::int - (capacity->>'taken')::int, 0)
  )
);

create index shuttles_origin_idx on public.shuttles using gist (route_origin);
create index shuttles_destination_idx on public.shuttles using gist (route_destination);
create index shuttles_status_idx on public.shuttles (status, created_at);
create index shuttles_purposes_gin on public.shuttles using gin (purposes);

create table public.shuttle_participants (
  shuttle_id uuid references public.shuttles (id) on delete cascade,
  user_id uuid references auth.users (id) on delete cascade,
  role text default 'passenger' check (role in ('driver','staff','passenger')),
  is_visible boolean default true,
  joined_at timestamptz default now(),
  primary key (shuttle_id, user_id)
);

create table public.shuttle_messages (
  id uuid primary key default gen_random_uuid(),
  shuttle_id uuid references public.shuttles (id) on delete cascade,
  author_id uuid references auth.users (id),
  content text not null,
  created_at timestamptz default now(),
  expires_at timestamptz default (now() + interval '30 days')
);

create index shuttle_messages_idx on public.shuttle_messages (shuttle_id, created_at);
create index shuttle_messages_expiry_idx on public.shuttle_messages (expires_at);

-- Resource Points
create table public.resource_points (
  id uuid primary key default gen_random_uuid(),
  title jsonb not null,
  description jsonb,
  categories text[] not null default '{}',
  status public.resource_status not null default 'active',
  expiry timestamptz default (now() + interval '30 days'),
  location geography(point, 4326) not null,
  geohash text generated always as (public.geohash_6(location)) stored,
  address text,
  contact_masked_phone text,
  created_by uuid references auth.users (id),
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  constraint resource_points_title_locale check (title ? 'zh-TW' and title ? 'en-US'),
  constraint resource_points_description_locale check (description is null or (description ? 'zh-TW' and description ? 'en-US')),
  constraint resource_points_categories_allowed check (categories <@ array['food','water','medical','shelter','power','other']::text[])
);

create index resource_points_location_idx on public.resource_points using gist (location);
create index resource_points_categories_gin on public.resource_points using gin (categories);

-- Notification events (consumed by Edge Function)
create table public.notification_events (
  id bigserial primary key,
  entity_type text not null check (entity_type in ('mission','shuttle')),
  entity_id uuid not null,
  payload jsonb not null,
  created_at timestamptz default now()
);

create index notification_events_entity_idx on public.notification_events (entity_type, entity_id, created_at);

-- Business logic functions
create or replace function public.check_mission_rate_limit() returns trigger as $$
declare
  recent_count int;
begin
  if public.is_leader_or_above() then
    return new;
  end if;

  select count(*) into recent_count
  from public.missions
  where creator_id = auth.uid()
    and created_at > (now() - interval '1 hour');

  if recent_count >= 1 then
    raise exception 'Rate limit exceeded: 1 mission per hour for standard users.';
  end if;
  return new;
end;
$$ language plpgsql;

create or replace function public.sync_mission_participants() returns trigger as $$
begin
  update public.missions
    set participant_count = (
      select count(*) from public.mission_participants where mission_id = coalesce(new.mission_id, old.mission_id)
    ),
    updated_at = now()
  where id = coalesce(new.mission_id, old.mission_id);
  return null;
end;
$$ language plpgsql;

create or replace function public.ensure_shuttle_capacity() returns trigger as $$
declare
  v_total int;
  v_taken int;
begin
  select (capacity->>'total')::int, (capacity->>'taken')::int
    into v_total, v_taken
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

create or replace function public.sync_shuttle_capacity() returns trigger as $$
declare
  v_id uuid;
  v_total int;
  v_taken int;
  v_remaining int;
begin
  v_id := coalesce(new.shuttle_id, old.shuttle_id);
  select (capacity->>'total')::int into v_total from public.shuttles where id = v_id;
  select count(*) into v_taken from public.shuttle_participants where shuttle_id = v_id;
  v_remaining := greatest(coalesce(v_total,0) - v_taken, 0);

  update public.shuttles
    set capacity = jsonb_build_object(
      'total', coalesce(v_total, 0),
      'taken', v_taken,
      'remaining', v_remaining
    ),
    participants_snapshot = (
      select coalesce(array_agg(user_id), '{}') from public.shuttle_participants where shuttle_id = v_id
    ),
    updated_at = now()
  where id = v_id;
  return null;
end;
$$ language plpgsql;

create or replace function public.log_critical_change() returns trigger as $$
declare
  changed_fields text[] := '{}';
begin
  if TG_TABLE_NAME = 'missions' then
    if new.location is distinct from old.location then
      changed_fields := array_append(changed_fields, 'location');
    end if;
  elsif TG_TABLE_NAME = 'shuttles' then
    if new.route is distinct from old.route then
      changed_fields := array_append(changed_fields, 'route');
    end if;
    if new.schedule is distinct from old.schedule then
      changed_fields := array_append(changed_fields, 'schedule');
    end if;
    if new.capacity is distinct from old.capacity then
      changed_fields := array_append(changed_fields, 'capacity');
    end if;
  end if;

  if array_length(changed_fields, 1) is not null and old.status = 'in_progress' then
    insert into public.notification_events (entity_type, entity_id, payload)
    values (
      case when TG_TABLE_NAME = 'missions' then 'mission' else 'shuttle' end,
      new.id,
      jsonb_build_object(
        'changed_fields', changed_fields,
        'status', new.status,
        'updated_at', now()
      )
    );
  end if;
  return new;
end;
$$ language plpgsql;

create or replace function public.bump_updated_at() returns trigger as $$
begin
  new.updated_at := now();
  return new;
end;
$$ language plpgsql;

create or replace function public.prune_expired_chat() returns void as $$
begin
  delete from public.mission_messages where expires_at <= now();
  delete from public.shuttle_messages where expires_at <= now();
  delete from public.chat_rooms where expires_at <= now();
end;
$$ language plpgsql security definer;

-- Triggers
create trigger trg_mission_rate_limit
  before insert on public.missions
  for each row execute procedure public.check_mission_rate_limit();

create trigger trg_mission_updated_at
  before update on public.missions
  for each row execute procedure public.bump_updated_at();

create trigger trg_mission_participants_sync
  after insert or delete on public.mission_participants
  for each row execute procedure public.sync_mission_participants();

create trigger trg_mission_notify_change
  after update on public.missions
  for each row when (old.status = 'in_progress') execute procedure public.log_critical_change();

create trigger trg_shuttle_updated_at
  before update on public.shuttles
  for each row execute procedure public.bump_updated_at();

create trigger trg_shuttle_capacity_check
  before insert on public.shuttle_participants
  for each row execute procedure public.ensure_shuttle_capacity();

create trigger trg_shuttle_capacity_sync
  after insert or delete on public.shuttle_participants
  for each row execute procedure public.sync_shuttle_capacity();

create trigger trg_shuttle_notify_change
  after update on public.shuttles
  for each row when (old.status = 'in_progress') execute procedure public.log_critical_change();

create trigger trg_resource_points_updated_at
  before update on public.resource_points
  for each row execute procedure public.bump_updated_at();

-- RLS
alter table public.chat_rooms enable row level security;
alter table public.missions enable row level security;
alter table public.mission_participants enable row level security;
alter table public.mission_messages enable row level security;
alter table public.shuttles enable row level security;
alter table public.shuttle_participants enable row level security;
alter table public.shuttle_messages enable row level security;
alter table public.resource_points enable row level security;
alter table public.notification_events enable row level security;

-- chat_rooms
create policy chat_rooms_read on public.chat_rooms
  for select using (true);
create policy chat_rooms_write on public.chat_rooms
  for all using (auth.uid() is not null and created_by = auth.uid()) with check (auth.uid() is not null and created_by = auth.uid());

-- missions
create policy missions_select on public.missions
  for select using (true);
create policy missions_insert on public.missions
  for insert with check (auth.uid() is not null and creator_id = auth.uid());
create policy missions_update on public.missions
  for update using (
    auth.uid() is not null and (
      creator_id = auth.uid()
      or public.is_leader_or_above()
    )
  );
create policy missions_delete on public.missions
  for delete using (auth.uid() is not null and (creator_id = auth.uid() or public.is_leader_or_above()));

-- mission_participants
create policy mission_participants_select on public.mission_participants
  for select using (
    auth.uid() is not null and (
      user_id = auth.uid()
      or public.is_leader_or_above()
      or exists (select 1 from public.missions m where m.id = mission_id and m.creator_id = auth.uid())
    )
  );
create policy mission_participants_insert on public.mission_participants
  for insert with check (auth.uid() is not null and auth.uid() = user_id);
create policy mission_participants_delete on public.mission_participants
  for delete using (auth.uid() is not null and (user_id = auth.uid() or public.is_leader_or_above()));

-- mission_messages
create policy mission_messages_select on public.mission_messages
  for select using (
    auth.uid() is not null and (
      public.is_leader_or_above()
      or exists (select 1 from public.mission_participants mp where mp.mission_id = mission_id and mp.user_id = auth.uid())
      or exists (select 1 from public.missions m where m.id = mission_id and m.creator_id = auth.uid())
    )
  );
create policy mission_messages_insert on public.mission_messages
  for insert with check (
    auth.uid() is not null and (
      exists (select 1 from public.mission_participants mp where mp.mission_id = mission_id and mp.user_id = auth.uid())
      or exists (select 1 from public.missions m where m.id = mission_id and m.creator_id = auth.uid())
      or public.is_leader_or_above()
    )
  );

-- shuttles
create policy shuttles_select on public.shuttles
  for select using (auth.uid() is not null);
create policy shuttles_insert on public.shuttles
  for insert with check (auth.uid() is not null and creator_id = auth.uid());
create policy shuttles_update on public.shuttles
  for update using (
    auth.uid() is not null and (
      creator_id = auth.uid()
      or public.is_leader_or_above()
    )
  );
create policy shuttles_delete on public.shuttles
  for delete using (auth.uid() is not null and (creator_id = auth.uid() or public.is_leader_or_above()));

-- shuttle_participants
create policy shuttle_participants_select on public.shuttle_participants
  for select using (
    auth.uid() is not null and (
      user_id = auth.uid()
      or public.is_leader_or_above()
      or exists (select 1 from public.shuttles s where s.id = shuttle_id and s.creator_id = auth.uid())
    )
  );
create policy shuttle_participants_insert on public.shuttle_participants
  for insert with check (auth.uid() is not null and auth.uid() = user_id);
create policy shuttle_participants_delete on public.shuttle_participants
  for delete using (auth.uid() is not null and (user_id = auth.uid() or public.is_leader_or_above()));

-- shuttle_messages
create policy shuttle_messages_select on public.shuttle_messages
  for select using (
    auth.uid() is not null and (
      public.is_leader_or_above()
      or exists (select 1 from public.shuttle_participants sp where sp.shuttle_id = shuttle_id and sp.user_id = auth.uid())
      or exists (select 1 from public.shuttles s where s.id = shuttle_id and s.creator_id = auth.uid())
    )
  );
create policy shuttle_messages_insert on public.shuttle_messages
  for insert with check (
    auth.uid() is not null and (
      exists (select 1 from public.shuttle_participants sp where sp.shuttle_id = shuttle_id and sp.user_id = auth.uid())
      or exists (select 1 from public.shuttles s where s.id = shuttle_id and s.creator_id = auth.uid())
      or public.is_leader_or_above()
    )
  );

-- resource_points
create policy resource_points_select on public.resource_points
  for select using (true);
create policy resource_points_insert on public.resource_points
  for insert with check (auth.uid() is not null and created_by = auth.uid());
create policy resource_points_update on public.resource_points
  for update using (
    auth.uid() is not null and (
      created_by = auth.uid()
      or public.is_leader_or_above()
    )
  );
create policy resource_points_delete on public.resource_points
  for delete using (auth.uid() is not null and (created_by = auth.uid() or public.is_leader_or_above()));

-- notification_events
create policy notification_events_read on public.notification_events
  for select using (auth.uid() is not null and public.is_leader_or_above());
create policy notification_events_insert on public.notification_events
  for insert with check (auth.uid() is not null);

comment on function public.prune_expired_chat is 'Scheduled to enforce 30-day TTL on chat rooms and messages.';
