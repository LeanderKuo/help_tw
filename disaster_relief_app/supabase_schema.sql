-- Enable PostGIS for location features
create extension if not exists postgis;

-- 1. PROFILES (Public & Private)
-- Public profile information (visible to authenticated users)
create table public.profiles_public (
  id uuid references auth.users on delete cascade not null primary key,
  display_id text unique, -- e.g., U-12345
  nickname text,
  role text default 'User', -- 'Root', 'Superadmin', 'Admin', 'Leader', 'Superuser', 'User', 'Visitor'
  avatar_url text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- Private profile information (visible only to the user and admins)
create table public.profiles_private (
  id uuid references auth.users on delete cascade not null primary key,
  email text,
  full_name text,
  real_phone text,
  masked_phone text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- 2. RESOURCE POINTS
create table public.resource_points (
  id uuid default gen_random_uuid() primary key,
  title text not null,
  description text,
  type text default 'Other', -- 'Water', 'Shelter', 'Medical', 'Food', 'Other'
  latitude double precision not null,
  longitude double precision not null,
  location geography(Point, 4326), -- PostGIS point for efficient querying
  is_active boolean default true,
  images text[] default '{}',
  created_by uuid references auth.users,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- Index for spatial queries
create index resource_points_geo_index on public.resource_points using GIST (location);

-- 3. TASKS
create table public.tasks (
  id uuid default gen_random_uuid() primary key,
  title text not null,
  description text,
  status text default 'Open', -- 'Open', 'In Progress', 'Completed', 'Cancelled'
  priority text default 'Normal', -- 'Low', 'Normal', 'High', 'Emergency'
  latitude double precision,
  longitude double precision,
  location geography(Point, 4326),
  images text[] default '{}',
  assigned_to uuid references auth.users,
  created_by uuid references auth.users,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- 4. SHUTTLES
create table public.shuttles (
  id uuid default gen_random_uuid() primary key,
  title text not null,
  description text,
  status text default 'Scheduled', -- 'Scheduled', 'En Route', 'Arrived', 'Cancelled'
  route_start_lat double precision,
  route_start_lng double precision,
  route_end_lat double precision,
  route_end_lng double precision,
  departure_time timestamptz,
  capacity int default 0,
  seats_taken int default 0,
  driver_id uuid references auth.users,
  created_by uuid references auth.users,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- 5. SHUTTLE PARTICIPANTS
create table public.shuttle_participants (
  shuttle_id uuid references public.shuttles on delete cascade,
  user_id uuid references auth.users on delete cascade,
  status text default 'Joined', -- 'Joined', 'Cancelled'
  joined_at timestamptz default now(),
  primary key (shuttle_id, user_id)
);

-- 6. CHAT MESSAGES (Task & Shuttle Chat)
create table public.chat_messages (
  id uuid default gen_random_uuid() primary key,
  task_id uuid references public.tasks on delete cascade,
  shuttle_id uuid references public.shuttles on delete cascade,
  sender_id uuid references auth.users,
  content text,
  image_url text,
  created_at timestamptz default now()
);

-- Enable Row Level Security (RLS)
alter table profiles_public enable row level security;
alter table profiles_private enable row level security;
alter table resource_points enable row level security;
alter table tasks enable row level security;
alter table shuttles enable row level security;
alter table shuttle_participants enable row level security;
alter table chat_messages enable row level security;

-- Basic Policies (Open for now for development, tighten later)
create policy "Public profiles are viewable by everyone" on profiles_public for select using (true);
create policy "Users can insert their own public profile" on profiles_public for insert with check (auth.uid() = id);
create policy "Users can update their own public profile" on profiles_public for update using (auth.uid() = id);

create policy "Private profiles are viewable by owner" on profiles_private for select using (auth.uid() = id);
create policy "Users can insert their own private profile" on profiles_private for insert with check (auth.uid() = id);
create policy "Users can update their own private profile" on profiles_private for update using (auth.uid() = id);

create policy "Resource points are viewable by everyone" on resource_points for select using (true);
create policy "Authenticated users can insert resource points" on resource_points for insert with check (auth.role() = 'authenticated');

create policy "Tasks are viewable by everyone" on tasks for select using (true);
create policy "Authenticated users can insert tasks" on tasks for insert with check (auth.role() = 'authenticated');

create policy "Shuttles are viewable by everyone" on shuttles for select using (true);
create policy "Authenticated users can insert shuttles" on shuttles for insert with check (auth.role() = 'authenticated');

-- Trigger to automatically create profile entries on signup
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles_public (id, display_id, nickname, role)
  values (new.id, 'U-' || substring(new.id::text from 1 for 8), split_part(new.email, '@', 1), 'User');
  
  insert into public.profiles_private (id, email)
  values (new.id, new.email);
  
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- Function to update location column from lat/lng
create or replace function update_location_column()
returns trigger as $$
begin
  if new.latitude is not null and new.longitude is not null then
    new.location = ST_SetSRID(ST_MakePoint(new.longitude, new.latitude), 4326);
  end if;
  return new;
end;
$$ language plpgsql;

create trigger update_resource_location
  before insert or update on resource_points
  for each row execute procedure update_location_column();

create trigger update_task_location
  before insert or update on tasks
  for each row execute procedure update_location_column();
