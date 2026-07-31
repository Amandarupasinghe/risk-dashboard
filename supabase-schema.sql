create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text not null unique,
  role text not null default 'viewer' check (role in ('admin','editor','viewer')),
  created_at timestamptz default now()
);

create table if not exists public.risks (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  department text not null,
  severity text not null,
  score integer not null,
  likelihood integer,
  impact integer,
  status text,
  category text,
  owner text,
  controls text,
  mitigation text,
  target text,
  last_updated text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists public.mitigations (
  id uuid primary key default gen_random_uuid(),
  risk_id uuid references public.risks(id) on delete cascade,
  action text not null,
  department text,
  status text default 'Planned',
  resources_required text,
  owner text,
  priority text,
  progress integer default 0,
  target text,
  budget integer default 0,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.profiles enable row level security;
alter table public.risks enable row level security;
alter table public.mitigations enable row level security;

create policy if not exists "Users can read their own profile" on public.profiles
for select using (auth.uid() = id);

create policy if not exists "Users can update their own profile" on public.profiles
for update using (auth.uid() = id) with check (auth.uid() = id);

create policy if not exists "Admins can manage profiles" on public.profiles
for all using (
  exists (
    select 1 from public.profiles p
    where p.id = auth.uid() and p.role = 'admin'
  )
) with check (
  exists (
    select 1 from public.profiles p
    where p.id = auth.uid() and p.role = 'admin'
  )
);

create policy if not exists "Authenticated users can read risks" on public.risks
for select to authenticated using (true);

create policy if not exists "Authenticated users can insert risks" on public.risks
for insert to authenticated with check (true);

create policy if not exists "Authenticated users can update risks" on public.risks
for update to authenticated using (true) with check (true);

create policy if not exists "Authenticated users can delete risks" on public.risks
for delete to authenticated using (true);

create policy if not exists "Authenticated users can read mitigations" on public.mitigations
for select to authenticated using (true);

create policy if not exists "Authenticated users can insert mitigations" on public.mitigations
for insert to authenticated with check (true);

create policy if not exists "Authenticated users can update mitigations" on public.mitigations
for update to authenticated using (true) with check (true);

create policy if not exists "Authenticated users can delete mitigations" on public.mitigations
for delete to authenticated using (true);


