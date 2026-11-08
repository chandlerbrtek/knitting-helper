-- Knitting Helper: database setup.
-- Paste this whole file into Supabase → SQL Editor → New query, then click Run.
-- Safe to run more than once.

-- One row per project. The project itself (counts, needles, yarn, pattern,
-- color, photo list) is stored as JSON in `data`.
create table if not exists public.projects (
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  id text not null,
  data jsonb not null default '{}'::jsonb,
  updated bigint not null,            -- time of last edit, in ms (newest edit wins)
  deleted boolean not null default false,  -- kept so deletes reach other devices
  primary key (user_id, id)
);

-- Per-account settings, e.g. custom needle sizes and yarn fibers.
create table if not exists public.settings (
  user_id uuid primary key default auth.uid() references auth.users (id) on delete cascade,
  custom jsonb not null default '{}'::jsonb
);

-- Each signed-in person can only see and change their own rows.
alter table public.projects enable row level security;
alter table public.settings enable row level security;

drop policy if exists "own projects" on public.projects;
create policy "own projects" on public.projects
  for all to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

drop policy if exists "own settings" on public.settings;
create policy "own settings" on public.settings
  for all to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

grant select, insert, update, delete on public.projects to authenticated;
grant select, insert, update, delete on public.settings to authenticated;

-- Private bucket for photos. Each person's photos go in a folder named
-- after their user id, and they can only touch that folder.
insert into storage.buckets (id, name, public)
values ('photos', 'photos', false)
on conflict (id) do nothing;

drop policy if exists "own photos select" on storage.objects;
create policy "own photos select" on storage.objects
  for select to authenticated
  using (bucket_id = 'photos' and (storage.foldername(name))[1] = auth.uid()::text);

drop policy if exists "own photos insert" on storage.objects;
create policy "own photos insert" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'photos' and (storage.foldername(name))[1] = auth.uid()::text);

drop policy if exists "own photos update" on storage.objects;
create policy "own photos update" on storage.objects
  for update to authenticated
  using (bucket_id = 'photos' and (storage.foldername(name))[1] = auth.uid()::text);

drop policy if exists "own photos delete" on storage.objects;
create policy "own photos delete" on storage.objects
  for delete to authenticated
  using (bucket_id = 'photos' and (storage.foldername(name))[1] = auth.uid()::text);
