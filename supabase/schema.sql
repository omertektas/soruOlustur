-- =====================================================================
-- Mülakat Defteri — database schema
-- Run in Supabase: SQL Editor → New query → paste this file → Run.
-- Then run seed.sql. This file is idempotent (safe to run again).
-- =====================================================================

-- ---------- Types ----------
do $$ begin
  create type public.difficulty as enum ('easy', 'medium', 'hard');
exception when duplicate_object then null; end $$;

do $$ begin
  create type public.question_status as enum ('pending', 'approved', 'rejected');
exception when duplicate_object then null; end $$;

do $$ begin
  create type public.user_role as enum ('user', 'admin');
exception when duplicate_object then null; end $$;

-- ---------- Tables ----------

-- Professions, e.g. Frontend Developer, Electrical-Electronics Engineer
create table if not exists public.professions (
  id           smallint generated always as identity primary key,
  slug         text not null unique,
  name         text not null,
  short_name   text not null,
  description  text not null,
  sort_order   smallint not null default 100,
  created_at   timestamptz not null default now()
);

-- Topics, e.g. JavaScript, Circuit Analysis, TCP/IP (shared across professions)
create table if not exists public.topics (
  id          smallint generated always as identity primary key,
  slug        text not null unique,
  name        text not null,
  created_at  timestamptz not null default now()
);

-- User profiles (one-to-one with auth.users)
create table if not exists public.profiles (
  id            uuid primary key references auth.users (id) on delete cascade,
  display_name  text not null default 'Anonim',
  role          public.user_role not null default 'user',
  created_at    timestamptz not null default now()
);

-- Questions
create table if not exists public.questions (
  id                uuid primary key default gen_random_uuid(),
  slug              text not null unique,
  title             text not null check (char_length(title) between 10 and 200),
  answer            text not null check (char_length(answer) between 20 and 10000),
  tip               text check (tip is null or char_length(tip) <= 400),
  difficulty        public.difficulty not null,
  profession_id     smallint not null references public.professions (id) on delete restrict,
  topic_id          smallint not null references public.topics (id) on delete restrict,
  status            public.question_status not null default 'pending',
  author_id         uuid references public.profiles (id) on delete set null,
  reviewed_by       uuid references public.profiles (id) on delete set null,
  reviewed_at       timestamptz,
  rejection_reason  text,
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now()
);

create index if not exists questions_status_profession_idx on public.questions (status, profession_id);
create index if not exists questions_status_topic_idx on public.questions (status, topic_id);
create index if not exists questions_author_idx on public.questions (author_id);
create index if not exists questions_created_idx on public.questions (created_at desc);

-- ---------- Helper functions ----------

-- Is the current user an admin?
create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from public.profiles where id = auth.uid() and role = 'admin'
  );
$$;

-- Create a profile for every new auth user
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, display_name)
  values (
    new.id,
    coalesce(nullif(trim(new.raw_user_meta_data ->> 'display_name'), ''), split_part(new.email, '@', 1))
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- Keep updated_at current
create or replace function public.touch_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists questions_touch_updated_at on public.questions;
create trigger questions_touch_updated_at
  before update on public.questions
  for each row execute function public.touch_updated_at();

-- ---------- Row Level Security ----------
alter table public.professions enable row level security;
alter table public.topics      enable row level security;
alter table public.profiles    enable row level security;
alter table public.questions   enable row level security;

-- Professions and topics: public read, admin write
drop policy if exists "professions_read" on public.professions;
create policy "professions_read" on public.professions for select using (true);
drop policy if exists "professions_admin_write" on public.professions;
create policy "professions_admin_write" on public.professions for all
  using (public.is_admin()) with check (public.is_admin());

drop policy if exists "topics_read" on public.topics;
create policy "topics_read" on public.topics for select using (true);
drop policy if exists "topics_admin_write" on public.topics;
create policy "topics_admin_write" on public.topics for all
  using (public.is_admin()) with check (public.is_admin());

-- Profiles: display names are public; users may only change their own
drop policy if exists "profiles_read" on public.profiles;
create policy "profiles_read" on public.profiles for select using (true);
drop policy if exists "profiles_update_own" on public.profiles;
create policy "profiles_update_own" on public.profiles for update
  using (auth.uid() = id) with check (auth.uid() = id);

-- Clients must never be able to change the role column
revoke update on public.profiles from authenticated, anon;
grant update (display_name) on public.profiles to authenticated;

-- Questions
drop policy if exists "questions_read" on public.questions;
create policy "questions_read" on public.questions for select using (
  status = 'approved' or author_id = auth.uid() or public.is_admin()
);

-- Signed-in users may only insert their own questions, always as pending
drop policy if exists "questions_insert_own_pending" on public.questions;
create policy "questions_insert_own_pending" on public.questions for insert
  to authenticated
  with check (
    author_id = auth.uid()
    and status = 'pending'
    and reviewed_by is null
    and reviewed_at is null
  );

-- Approve / reject / edit / delete: admins only
drop policy if exists "questions_admin_update" on public.questions;
create policy "questions_admin_update" on public.questions for update
  using (public.is_admin()) with check (public.is_admin());

drop policy if exists "questions_admin_delete" on public.questions;
create policy "questions_admin_delete" on public.questions for delete
  using (public.is_admin());

-- Spam guard: at most 10 pending questions per user
create or replace function public.limit_pending_questions()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if new.author_id is not null and (
    select count(*) from public.questions
    where author_id = new.author_id and status = 'pending'
  ) >= 10 then
    raise exception 'PENDING_LIMIT' using errcode = 'P0001';
  end if;
  return new;
end;
$$;

drop trigger if exists questions_limit_pending on public.questions;
create trigger questions_limit_pending
  before insert on public.questions
  for each row execute function public.limit_pending_questions();

-- =====================================================================
-- To make yourself an admin (after signing up on the site):
--
--   update public.profiles set role = 'admin'
--   where id = (select id from auth.users where email = 'omertektas0824@gmail.com');
-- =====================================================================
