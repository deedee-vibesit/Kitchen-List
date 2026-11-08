-- Run once in a new Supabase project. Add your two users separately.
begin;

create table public.kitchen_members (
  user_id uuid primary key references auth.users(id) on delete cascade,
  role text not null check (role in ('owner', 'shopper'))
);

create table public.kitchen_design (
  id integer primary key check (id = 1),
  value jsonb not null
);

insert into public.kitchen_design values (1, '{
  "stores":[
    {"id":"1","name":"Walmart"},
    {"id":"2","name":"Food Basics"},
    {"id":"3","name":"Dollarama"},
    {"id":"4","name":"Miscellaneous"}
  ],
  "artwork":{}
}');

create table public.kitchen_items (
  id uuid primary key default gen_random_uuid(),
  store_id text not null check (char_length(store_id) between 1 and 36),
  name text not null check (char_length(trim(name)) between 1 and 160),
  done boolean not null default false,
  created_at timestamptz not null default now()
);

alter table public.kitchen_members enable row level security;
alter table public.kitchen_design enable row level security;
alter table public.kitchen_items enable row level security;

revoke all on public.kitchen_members, public.kitchen_design, public.kitchen_items from anon, authenticated;
grant select on public.kitchen_members to authenticated;
grant select, update(value) on public.kitchen_design to authenticated;
grant select, insert(store_id,name,done), update(done), delete on public.kitchen_items to authenticated;

create policy own_membership on public.kitchen_members for select to authenticated
  using (user_id = (select auth.uid()));
create policy members_read_design on public.kitchen_design for select to authenticated
  using (exists (select 1 from public.kitchen_members where user_id = (select auth.uid())));
create policy owner_updates_design on public.kitchen_design for update to authenticated
  using (exists (select 1 from public.kitchen_members where user_id = (select auth.uid()) and role = 'owner'))
  with check (exists (select 1 from public.kitchen_members where user_id = (select auth.uid()) and role = 'owner'));
create policy members_use_items on public.kitchen_items for all to authenticated
  using (exists (select 1 from public.kitchen_members where user_id = (select auth.uid())))
  with check (exists (select 1 from public.kitchen_members where user_id = (select auth.uid())));

commit;

-- After creating both accounts in Authentication > Users, run separately
-- with the real emails in place of the examples:
--
-- insert into public.kitchen_members(user_id,role)
-- select id,'owner' from auth.users where lower(email) = lower('you@example.com')
-- union all
-- select id,'shopper' from auth.users where lower(email) = lower('friend@example.com');
