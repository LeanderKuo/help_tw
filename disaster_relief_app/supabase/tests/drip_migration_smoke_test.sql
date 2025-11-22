\echo '== DRIP missions/shuttles/resources smoke test =='
\set ON_ERROR_STOP on

\set user_std    '00000000-0000-0000-0000-00000000a001'
\set user_leader '00000000-0000-0000-0000-00000000a002'
\set user_extra  '00000000-0000-0000-0000-00000000a003'

begin;

-- ---------------------------------------------------------------------------
-- Seed minimal users + profiles (idempotent)
-- ---------------------------------------------------------------------------
insert into auth.users (id, email, encrypted_password, email_confirmed_at, raw_user_meta_data, aud, role)
values
  (:'user_std', 'std@example.com', 'x', now(), '{}'::jsonb, 'authenticated', 'authenticated'),
  (:'user_leader', 'leader@example.com', 'x', now(), '{}'::jsonb, 'authenticated', 'authenticated'),
  (:'user_extra', 'extra@example.com', 'x', now(), '{}'::jsonb, 'authenticated', 'authenticated')
on conflict (id) do nothing;

insert into public.profiles_public (id)
values (:'user_std'), (:'user_leader'), (:'user_extra')
on conflict (id) do nothing;

update public.profiles_public set role = 'User' where id = :'user_std';
update public.profiles_public set role = 'Leader' where id = :'user_leader';
update public.profiles_public set role = 'User' where id = :'user_extra';

\echo 'Seeded test users/profiles (std, leader, extra)'

-- ---------------------------------------------------------------------------
-- Test 1: mission rate limit (User limited to 1/hour, Leader bypass)
-- ---------------------------------------------------------------------------
set local role authenticated;
select set_config('request.jwt.claims', json_build_object('sub', :'user_std')::text, true);

do $$
begin
  insert into public.missions (title, description, types, location, contact_name, contact_phone_masked, creator_id)
  values (
    jsonb_build_object('zh-TW','測試任務A','en-US','Mission A'),
    jsonb_build_object('zh-TW','描述A','en-US','Desc A'),
    array['rescue'],
    jsonb_build_object('lat',25.033,'lng',121.565,'address','Taipei 101'),
    'Alice','0912***789', :'user_std'
  );
  raise notice 'PASS: first mission for standard user created';

  begin
    insert into public.missions (title, description, types, location, contact_name, contact_phone_masked, creator_id)
    values (
      jsonb_build_object('zh-TW','測試任務B','en-US','Mission B'),
      jsonb_build_object('zh-TW','描述B','en-US','Desc B'),
      array['rescue'],
      jsonb_build_object('lat',25.034,'lng',121.566,'address','Taipei 101'),
      'Alice','0912***789', :'user_std'
    );
    raise exception 'FAIL: mission rate limit not enforced for standard user';
  exception
    when others then
      if position('Rate limit exceeded' in sqlerrm) > 0 then
        raise notice 'PASS: mission rate limit enforced for standard user';
      else
        raise;
      end if;
  end;
end $$;

reset role;
reset "request.jwt.claims";

set local role authenticated;
select set_config('request.jwt.claims', json_build_object('sub', :'user_leader')::text, true);

do $$
declare
  leader_count int;
begin
  insert into public.missions (title, description, types, location, contact_name, contact_phone_masked, creator_id)
  values (
    jsonb_build_object('zh-TW','領隊任務A','en-US','Leader Mission A'),
    jsonb_build_object('zh-TW','描述','en-US','Desc'),
    array['rescue'],
    jsonb_build_object('lat',25.04,'lng',121.56,'address','Taipei City Hall'),
    'Leo','0912***111', :'user_leader'
  );
  insert into public.missions (title, description, types, location, contact_name, contact_phone_masked, creator_id)
  values (
    jsonb_build_object('zh-TW','領隊任務B','en-US','Leader Mission B'),
    jsonb_build_object('zh-TW','描述','en-US','Desc'),
    array['medical'],
    jsonb_build_object('lat',25.041,'lng',121.561,'address','Taipei City Hall'),
    'Leo','0912***111', :'user_leader'
  );

  select count(*) into leader_count from public.missions where creator_id = :'user_leader';
  if leader_count < 2 then
    raise exception 'FAIL: leader should bypass mission rate limit (count = %)', leader_count;
  end if;
  raise notice 'PASS: leader bypassed mission rate limit';
end $$;

reset role;
reset "request.jwt.claims";

-- ---------------------------------------------------------------------------
-- Test 2: shuttle capacity guard + sync + notification_events
-- ---------------------------------------------------------------------------
set local role authenticated;
select set_config('request.jwt.claims', json_build_object('sub', :'user_leader')::text, true);

insert into public.shuttles (
  title, description, vehicle_info, purposes, route, schedule, capacity,
  contact_name, contact_phone_masked, creator_id, status
) values (
  jsonb_build_object('zh-TW','測試班車','en-US','Test Shuttle'),
  jsonb_build_object('zh-TW','描述','en-US','Desc'),
  jsonb_build_object('type','van','plate','ABC-1234'),
  array['evacuation'],
  jsonb_build_object(
    'origin', jsonb_build_object('lat',25.04,'lng',121.55,'address','Point A'),
    'destination', jsonb_build_object('lat',25.05,'lng',121.56,'address','Point B')
  ),
  jsonb_build_object('depart_at', now() + interval '1 hour'),
  jsonb_build_object('total',1,'taken',0,'remaining',1),
  'Leo','0912***111', :'user_leader', 'open'
) returning id \gset shuttle_

\echo 'Created shuttle :shuttle_id'

set local role authenticated;
select set_config('request.jwt.claims', json_build_object('sub', :'user_std')::text, true);
insert into public.shuttle_participants (shuttle_id, user_id, role)
values (:'shuttle_id', :'user_std', 'passenger');
\echo 'Joined shuttle as standard user (should succeed)'

set local role authenticated;
select set_config('request.jwt.claims', json_build_object('sub', :'user_extra')::text, true);

do $$
begin
  begin
    insert into public.shuttle_participants (shuttle_id, user_id, role)
    values (:'shuttle_id', :'user_extra', 'passenger');
    raise exception 'FAIL: shuttle capacity trigger did not block second join';
  exception
    when others then
      if position('Shuttle is full' in sqlerrm) > 0 then
        raise notice 'PASS: capacity guard blocked extra participant';
      else
        raise;
      end if;
  end;
end $$;

set local role authenticated;
select set_config('request.jwt.claims', json_build_object('sub', :'user_leader')::text, true);

do $$
declare
  remaining int;
  snapshot_count int;
begin
  select (capacity->>'remaining')::int, cardinality(participants_snapshot)
    into remaining, snapshot_count
  from public.shuttles
  where id = :'shuttle_id';

  if remaining <> 0 then
    raise exception 'FAIL: remaining seats expected 0, got %', remaining;
  end if;
  if snapshot_count <> 1 then
    raise exception 'FAIL: participants_snapshot expected 1, got %', snapshot_count;
  end if;
  raise notice 'PASS: capacity sync + snapshot ok';
end $$;

do $$
declare
  before_count int;
  after_count int;
begin
  select count(*) into before_count from public.notification_events
    where entity_type = 'shuttle' and entity_id = :'shuttle_id'::uuid;

  update public.shuttles set status = 'in_progress' where id = :'shuttle_id';
  update public.shuttles set route = jsonb_build_object(
    'origin', jsonb_build_object('lat',25.06,'lng',121.55,'address','Point A2'),
    'destination', jsonb_build_object('lat',25.07,'lng',121.57,'address','Point B2')
  )
  where id = :'shuttle_id';

  select count(*) into after_count from public.notification_events
    where entity_type = 'shuttle' and entity_id = :'shuttle_id'::uuid;

  if after_count <= before_count then
    raise exception 'FAIL: notification_events not written on in-progress route change';
  end if;
  raise notice 'PASS: notification_events logged on shuttle change';
end $$;

reset role;
reset "request.jwt.claims";

-- ---------------------------------------------------------------------------
-- Test 3: resource point geohash + RLS insert
-- ---------------------------------------------------------------------------
set local role authenticated;
select set_config('request.jwt.claims', json_build_object('sub', :'user_std')::text, true);

insert into public.resource_points (
  title, description, categories, location, address, contact_masked_phone, created_by
) values (
  jsonb_build_object('zh-TW','測試資源點','en-US','Test Resource'),
  jsonb_build_object('zh-TW','備註','en-US','Note'),
  array['water','medical'],
  ST_GeogFromText('SRID=4326;POINT(121.543 25.034)'),
  'Test address',
  '0912***222',
  :'user_std'
) returning id \gset res_

do $$
declare
  gh text;
begin
  select geohash into gh from public.resource_points where id = :'res_id';
  if gh is null or length(gh) <> 6 then
    raise exception 'FAIL: resource geohash missing or invalid (%).', gh;
  end if;
  raise notice 'PASS: resource geohash generated (%)', gh;
end $$;

reset role;
reset "request.jwt.claims";

rollback;
\echo '== DRIP smoke test finished (transaction rolled back) =='
