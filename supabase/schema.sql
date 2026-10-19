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

-- ---------- Community suggestions: new professions and topics ----------
-- Users can suggest a profession/topic together with a question. Suggestions stay
-- unpublished until an admin approves the question that introduced them.

alter table public.professions add column if not exists is_published boolean not null default true;
alter table public.professions add column if not exists suggested_by uuid references public.profiles (id) on delete set null;
alter table public.topics add column if not exists is_published boolean not null default true;
alter table public.topics add column if not exists suggested_by uuid references public.profiles (id) on delete set null;

drop policy if exists "professions_read" on public.professions;
create policy "professions_read" on public.professions for select
  using (is_published or suggested_by = auth.uid() or public.is_admin());

drop policy if exists "topics_read" on public.topics;
create policy "topics_read" on public.topics for select
  using (is_published or suggested_by = auth.uid() or public.is_admin());

-- Returns the id of an existing profession with this slug, or creates an unpublished suggestion.
create or replace function public.suggest_profession(p_slug text, p_name text)
returns smallint
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_id smallint;
  v_name text := btrim(p_name);
begin
  if v_uid is null then raise exception 'AUTH_REQUIRED' using errcode = 'P0001'; end if;
  if char_length(v_name) not between 2 and 60
     or char_length(p_slug) > 80
     or p_slug !~ '^[a-z0-9]+(-[a-z0-9]+)*$' then
    raise exception 'INVALID_NAME' using errcode = 'P0001';
  end if;

  select id into v_id from public.professions where slug = p_slug;
  if v_id is not null then return v_id; end if;

  if (select count(*) from public.professions where suggested_by = v_uid and not is_published) >= 5 then
    raise exception 'SUGGESTION_LIMIT' using errcode = 'P0001';
  end if;

  insert into public.professions (slug, name, short_name, description, is_published, suggested_by)
  values (p_slug, v_name, v_name, v_name || ' pozisyonu için mülakat soruları ve cevapları.', false, v_uid)
  returning id into v_id;
  return v_id;
end;
$$;

-- Same as suggest_profession, for topics.
create or replace function public.suggest_topic(p_slug text, p_name text)
returns smallint
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_id smallint;
  v_name text := btrim(p_name);
begin
  if v_uid is null then raise exception 'AUTH_REQUIRED' using errcode = 'P0001'; end if;
  if char_length(v_name) not between 2 and 60
     or char_length(p_slug) > 80
     or p_slug !~ '^[a-z0-9]+(-[a-z0-9]+)*$' then
    raise exception 'INVALID_NAME' using errcode = 'P0001';
  end if;

  select id into v_id from public.topics where slug = p_slug;
  if v_id is not null then return v_id; end if;

  if (select count(*) from public.topics where suggested_by = v_uid and not is_published) >= 5 then
    raise exception 'SUGGESTION_LIMIT' using errcode = 'P0001';
  end if;

  insert into public.topics (slug, name, is_published, suggested_by)
  values (p_slug, v_name, false, v_uid)
  returning id into v_id;
  return v_id;
end;
$$;

revoke execute on function public.suggest_profession(text, text) from public, anon;
revoke execute on function public.suggest_topic(text, text) from public, anon;
grant execute on function public.suggest_profession(text, text) to authenticated;
grant execute on function public.suggest_topic(text, text) to authenticated;

-- ---------- Analytics and admin statistics ----------
-- Cookie-less page view counter: one row per day and path. No IP address or user id is stored.

create table if not exists public.page_view_daily (
  day       date not null,
  path      text not null check (char_length(path) between 1 and 200),
  views     integer not null default 0,
  visitors  integer not null default 0,
  primary key (day, path)
);

alter table public.page_view_daily enable row level security;

drop policy if exists "page_view_daily_admin_read" on public.page_view_daily;
create policy "page_view_daily_admin_read" on public.page_view_daily for select using (public.is_admin());

-- Called by every visitor's browser. p_new_visitor is true on a visitor's first page of the day.
create or replace function public.track_page_view(p_path text, p_new_visitor boolean)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if p_path is null or left(p_path, 1) <> '/' or char_length(p_path) > 200 then return; end if;
  insert into public.page_view_daily (day, path, views, visitors)
  values ((now() at time zone 'Europe/Istanbul')::date, p_path, 1, case when p_new_visitor then 1 else 0 end)
  on conflict (day, path) do update
    set views = page_view_daily.views + 1,
        visitors = page_view_daily.visitors + excluded.visitors;
end;
$$;

-- Fails unless the caller is an admin; used by every admin_* function below.
create or replace function public.assert_admin()
returns void
language plpgsql
stable
security definer
set search_path = public
as $$
begin
  if not public.is_admin() then raise exception 'ADMIN_ONLY' using errcode = '42501'; end if;
end;
$$;

create or replace function public.admin_overview()
returns json
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  v_today date := (now() at time zone 'Europe/Istanbul')::date;
begin
  perform public.assert_admin();
  return json_build_object(
    'questions_published', (select count(*) from public.questions where status = 'approved'),
    'questions_pending',   (select count(*) from public.questions where status = 'pending'),
    'users_total',         (select count(*) from auth.users),
    'users_last_7_days',   (select count(*) from auth.users where created_at >= now() - interval '7 days'),
    'views_today',         (select coalesce(sum(views), 0) from public.page_view_daily where day = v_today),
    'visitors_today',      (select coalesce(sum(visitors), 0) from public.page_view_daily where day = v_today),
    'views_30_days',       (select coalesce(sum(views), 0) from public.page_view_daily where day > v_today - 30),
    'visitors_30_days',    (select coalesce(sum(visitors), 0) from public.page_view_daily where day > v_today - 30)
  );
end;
$$;

-- Daily totals for the last p_days days, including days without traffic.
create or replace function public.admin_traffic(p_days integer)
returns table (day date, views bigint, visitors bigint)
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  v_today date := (now() at time zone 'Europe/Istanbul')::date;
begin
  perform public.assert_admin();
  return query
    select d::date, coalesce(sum(p.views), 0)::bigint, coalesce(sum(p.visitors), 0)::bigint
    from generate_series(v_today - (least(greatest(p_days, 1), 365) - 1), v_today, interval '1 day') as d
    left join public.page_view_daily p on p.day = d::date
    group by d
    order by d;
end;
$$;

create or replace function public.admin_top_pages(p_days integer, p_limit integer)
returns table (path text, views bigint, visitors bigint)
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  v_today date := (now() at time zone 'Europe/Istanbul')::date;
begin
  perform public.assert_admin();
  return query
    select p.path, sum(p.views)::bigint, sum(p.visitors)::bigint
    from public.page_view_daily p
    where p.day > v_today - least(greatest(p_days, 1), 365)
    group by p.path
    order by 2 desc, 1
    limit least(greatest(p_limit, 1), 100);
end;
$$;

create or replace function public.admin_list_users()
returns table (
  id uuid, email text, display_name text, role public.user_role,
  created_at timestamptz, last_sign_in_at timestamptz, email_confirmed boolean,
  approved_questions bigint, pending_questions bigint
)
language plpgsql
stable
security definer
set search_path = public
as $$
begin
  perform public.assert_admin();
  return query
    select u.id, u.email::text, p.display_name, p.role,
           u.created_at, u.last_sign_in_at, u.email_confirmed_at is not null,
           count(q.id) filter (where q.status = 'approved'),
           count(q.id) filter (where q.status = 'pending')
    from auth.users u
    join public.profiles p on p.id = u.id
    left join public.questions q on q.author_id = u.id
    group by u.id, p.display_name, p.role
    order by u.created_at desc;
end;
$$;

revoke execute on function public.track_page_view(text, boolean) from public;
grant execute on function public.track_page_view(text, boolean) to anon, authenticated;

revoke execute on function public.assert_admin() from public, anon;
revoke execute on function public.admin_overview() from public, anon;
revoke execute on function public.admin_traffic(integer) from public, anon;
revoke execute on function public.admin_top_pages(integer, integer) from public, anon;
revoke execute on function public.admin_list_users() from public, anon;
grant execute on function public.assert_admin() to authenticated;
grant execute on function public.admin_overview() to authenticated;
grant execute on function public.admin_traffic(integer) to authenticated;
grant execute on function public.admin_top_pages(integer, integer) to authenticated;
grant execute on function public.admin_list_users() to authenticated;

-- =====================================================================
-- To make yourself an admin (after signing up on the site):
--
--   update public.profiles set role = 'admin'
--   where id = (select id from auth.users where email = 'omertektas0824@gmail.com');
-- =====================================================================
