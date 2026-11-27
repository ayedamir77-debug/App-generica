create extension if not exists pgcrypto;

create extension if not exists "uuid-ossp";

create table public.assets (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  client_id uuid,
  title text not null,
  address_url text,
  username text,
  secret text,
  notes text,
  created_at timestamp with time zone default now() not null
);

create table public.chat_messages (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  user_id uuid not null,
  body text not null,
  created_at timestamp with time zone default now() not null
);

create table public.checklists (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  name text not null,
  items jsonb default '[]'::jsonb not null,
  created_at timestamp with time zone default now() not null
);

create table public.clients (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  name text not null,
  phone text,
  email text,
  address text,
  notes text,
  created_at timestamp with time zone default now() not null,
  category text
);

create table public.comments (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  user_id uuid not null,
  ref_type text not null,
  ref_id uuid not null,
  body text not null,
  created_at timestamp with time zone default now() not null
);

create table public.companies (
  id uuid default gen_random_uuid() not null,
  name text not null,
  join_code text not null,
  owner_id uuid not null,
  created_at timestamp with time zone default now() not null,
  tax_regime text,
  iva_period text default 'trimestrale'::text not null,
  vat_number text,
  tax_code text,
  address text,
  phone text,
  email text,
  hourly_cost numeric,
  ai_enabled boolean default false not null,
  ai_provider text default 'claude'::text not null,
  track_pos boolean default false not null
);

create table public.documents (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  job_id uuid,
  kind text default 'altro'::text not null,
  title text,
  amount numeric,
  doc_date date,
  paid boolean default false not null,
  file_path text not null,
  file_name text,
  mime text,
  size bigint,
  uploaded_by uuid,
  created_at timestamp with time zone default now() not null,
  counterparty text,
  doc_number text,
  ocr_text text,
  items jsonb,
  phase text,
  vehicle_id uuid
);

create table public.expenses (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  expense_date date not null,
  category text not null,
  description text,
  amount numeric not null,
  vat_rate numeric default 0 not null,
  vat_amount numeric default 0 not null,
  doc_id uuid,
  created_at timestamp with time zone default now() not null
);

create table public.invoices (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  direction text not null,
  number text,
  doc_date date not null,
  due_date date,
  counterparty text not null,
  net numeric default 0 not null,
  vat_rate numeric default 0 not null,
  vat_amount numeric default 0 not null,
  total numeric default 0 not null,
  paid boolean default false not null,
  paid_date date,
  doc_id uuid,
  notes text,
  created_at timestamp with time zone default now() not null,
  job_id uuid
);

create table public.job_assignments (
  job_id uuid not null,
  user_id uuid not null
);

create table public.job_checklists (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  job_id uuid not null,
  name text not null,
  items jsonb default '[]'::jsonb not null,
  created_at timestamp with time zone default now() not null
);

create table public.job_materials (
  id uuid default gen_random_uuid() not null,
  job_id uuid not null,
  company_id uuid not null,
  description text not null,
  quantity numeric,
  unit text,
  added_by uuid,
  created_at timestamp with time zone default now() not null
);

create table public.jobs (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  client_id uuid,
  title text not null,
  description text,
  address text,
  start_at timestamp with time zone,
  end_at timestamp with time zone,
  status text default 'todo'::text not null,
  field_notes text,
  created_by uuid,
  created_at timestamp with time zone default now() not null
);

create table public.km_log (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  user_id uuid not null,
  day date default CURRENT_DATE not null,
  vehicle text,
  km_start numeric,
  km_end numeric,
  note text,
  created_at timestamp with time zone default now() not null
);

create table public.leave_requests (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  user_id uuid not null,
  kind text default 'ferie'::text not null,
  from_date date not null,
  to_date date not null,
  note text,
  status text default 'richiesta'::text not null,
  created_at timestamp with time zone default now() not null
);

create table public.library (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  category text default 'Altro'::text not null,
  brand text,
  model text,
  title text not null,
  note text,
  url text,
  file_path text,
  file_name text,
  ocr_text text,
  fav boolean default false not null,
  created_at timestamp with time zone default now() not null
);

create table public.posts (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  user_id uuid not null,
  body text not null,
  created_at timestamp with time zone default now() not null
);

create table public.profiles (
  id uuid not null,
  company_id uuid not null,
  full_name text not null,
  email text,
  role text not null,
  status text default 'pending'::text not null,
  created_at timestamp with time zone default now() not null
);

create table public.push_config (
  id integer not null,
  public_key text not null,
  private_key text not null
);

create table public.push_subs (
  id uuid default gen_random_uuid() not null,
  user_id uuid not null,
  company_id uuid not null,
  endpoint text not null,
  p256dh text not null,
  auth text not null,
  created_at timestamp with time zone default now() not null
);

create table public.quotes (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  client_id uuid,
  job_id uuid,
  number text not null,
  title text,
  quote_date date default CURRENT_DATE not null,
  valid_until date,
  status text default 'bozza'::text not null,
  items jsonb default '[]'::jsonb not null,
  vat_rate numeric default 0 not null,
  notes text,
  created_at timestamp with time zone default now() not null
);

create table public.reports (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  user_id uuid not null,
  job_id uuid,
  day date default CURRENT_DATE not null,
  summary text,
  with_ids uuid[] default '{}'::uuid[] not null,
  materials jsonb default '[]'::jsonb not null,
  minutes integer,
  created_at timestamp with time zone default now() not null
);

create table public.stock (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  code text,
  description text not null,
  quantity numeric default 0 not null,
  unit text,
  location text,
  note text,
  updated_at timestamp with time zone default now() not null
);

create table public.time_entries (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  user_id uuid not null,
  job_id uuid,
  started_at timestamp with time zone default now() not null,
  ended_at timestamp with time zone,
  in_lat double precision,
  in_lng double precision,
  out_lat double precision,
  out_lng double precision
);

create table public.vehicle_deadlines (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  vehicle_id uuid not null,
  kind text default 'altro'::text not null,
  due_date date not null,
  notes text,
  done boolean default false not null,
  created_at timestamp with time zone default now() not null
);

create table public.vehicles (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  name text not null,
  plate text,
  kind text,
  notes text,
  created_at timestamp with time zone default now() not null
);

create table public.warranties (
  id uuid default gen_random_uuid() not null,
  company_id uuid not null,
  client_id uuid,
  kind text default 'manutenzione'::text not null,
  title text not null,
  due_date date not null,
  notes text,
  done boolean default false not null,
  created_at timestamp with time zone default now() not null
);

alter table assets add constraint assets_pkey PRIMARY KEY (id);

alter table chat_messages add constraint chat_messages_pkey PRIMARY KEY (id);

alter table checklists add constraint checklists_pkey PRIMARY KEY (id);

alter table clients add constraint clients_pkey PRIMARY KEY (id);

alter table comments add constraint comments_pkey PRIMARY KEY (id);

alter table companies add constraint companies_pkey PRIMARY KEY (id);

alter table documents add constraint documents_pkey PRIMARY KEY (id);

alter table expenses add constraint expenses_pkey PRIMARY KEY (id);

alter table invoices add constraint invoices_pkey PRIMARY KEY (id);

alter table job_assignments add constraint job_assignments_pkey PRIMARY KEY (job_id, user_id);

alter table job_checklists add constraint job_checklists_pkey PRIMARY KEY (id);

alter table job_materials add constraint job_materials_pkey PRIMARY KEY (id);

alter table jobs add constraint jobs_pkey PRIMARY KEY (id);

alter table km_log add constraint km_log_pkey PRIMARY KEY (id);

alter table leave_requests add constraint leave_requests_pkey PRIMARY KEY (id);

alter table library add constraint library_pkey PRIMARY KEY (id);

alter table posts add constraint posts_pkey PRIMARY KEY (id);

alter table profiles add constraint profiles_pkey PRIMARY KEY (id);

alter table push_config add constraint push_config_pkey PRIMARY KEY (id);

alter table push_subs add constraint push_subs_pkey PRIMARY KEY (id);

alter table quotes add constraint quotes_pkey PRIMARY KEY (id);

alter table reports add constraint reports_pkey PRIMARY KEY (id);

alter table stock add constraint stock_pkey PRIMARY KEY (id);

alter table time_entries add constraint time_entries_pkey PRIMARY KEY (id);

alter table vehicle_deadlines add constraint vehicle_deadlines_pkey PRIMARY KEY (id);

alter table vehicles add constraint vehicles_pkey PRIMARY KEY (id);

alter table warranties add constraint warranties_pkey PRIMARY KEY (id);

alter table companies add constraint companies_join_code_key UNIQUE (join_code);

alter table push_subs add constraint push_subs_endpoint_key UNIQUE (endpoint);

alter table chat_messages add constraint chat_messages_body_check CHECK (((length(body) >= 1) AND (length(body) <= 2000)));

alter table comments add constraint comments_ref_type_check CHECK ((ref_type = ANY (ARRAY['report'::text, 'post'::text])));

alter table companies add constraint companies_tax_regime_check CHECK ((tax_regime = ANY (ARRAY['forfettario'::text, 'semplificato'::text, 'ordinario'::text])));

alter table companies add constraint companies_iva_period_check CHECK ((iva_period = ANY (ARRAY['mensile'::text, 'trimestrale'::text])));

alter table documents add constraint documents_kind_check CHECK ((kind = ANY (ARRAY['foto'::text, 'bolla'::text, 'fattura'::text, 'preventivo'::text, 'scontrino'::text, 'conformita'::text, 'contratto'::text, 'firma'::text, 'rapporto'::text, 'altro'::text])));

alter table invoices add constraint invoices_direction_check CHECK ((direction = ANY (ARRAY['emessa'::text, 'ricevuta'::text])));

alter table leave_requests add constraint leave_requests_status_check CHECK ((status = ANY (ARRAY['richiesta'::text, 'ok'::text, 'no'::text])));

alter table profiles add constraint profiles_role_check CHECK ((role = ANY (ARRAY['owner'::text, 'employee'::text])));

alter table profiles add constraint profiles_status_check CHECK ((status = ANY (ARRAY['pending'::text, 'active'::text, 'rejected'::text])));

alter table quotes add constraint quotes_status_check CHECK ((status = ANY (ARRAY['bozza'::text, 'inviato'::text, 'accettato'::text, 'rifiutato'::text])));

alter table warranties add constraint warranties_kind_check CHECK ((kind = ANY (ARRAY['garanzia'::text, 'manutenzione'::text])));

alter table assets add constraint assets_client_id_fkey FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE SET NULL;

alter table assets add constraint assets_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table chat_messages add constraint chat_messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

alter table chat_messages add constraint chat_messages_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table checklists add constraint checklists_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table clients add constraint clients_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table comments add constraint comments_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table comments add constraint comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

alter table companies add constraint companies_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES auth.users(id) ON DELETE CASCADE;

alter table documents add constraint documents_job_id_fkey FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE SET NULL;

alter table documents add constraint documents_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table documents add constraint documents_vehicle_id_fkey FOREIGN KEY (vehicle_id) REFERENCES vehicles(id) ON DELETE SET NULL;

alter table documents add constraint documents_uploaded_by_fkey FOREIGN KEY (uploaded_by) REFERENCES profiles(id) ON DELETE SET NULL;

alter table expenses add constraint expenses_doc_id_fkey FOREIGN KEY (doc_id) REFERENCES documents(id) ON DELETE SET NULL;

alter table expenses add constraint expenses_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table invoices add constraint invoices_doc_id_fkey FOREIGN KEY (doc_id) REFERENCES documents(id) ON DELETE SET NULL;

alter table invoices add constraint invoices_job_id_fkey FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE SET NULL;

alter table invoices add constraint invoices_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table job_assignments add constraint job_assignments_job_id_fkey FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE;

alter table job_assignments add constraint job_assignments_user_id_fkey FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

alter table job_checklists add constraint job_checklists_job_id_fkey FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE;

alter table job_checklists add constraint job_checklists_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table job_materials add constraint job_materials_job_id_fkey FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE;

alter table job_materials add constraint job_materials_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table job_materials add constraint job_materials_added_by_fkey FOREIGN KEY (added_by) REFERENCES profiles(id) ON DELETE SET NULL;

alter table jobs add constraint jobs_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table jobs add constraint jobs_client_id_fkey FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE SET NULL;

alter table jobs add constraint jobs_created_by_fkey FOREIGN KEY (created_by) REFERENCES profiles(id) ON DELETE SET NULL;

alter table km_log add constraint km_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

alter table km_log add constraint km_log_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table leave_requests add constraint leave_requests_user_id_fkey FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

alter table leave_requests add constraint leave_requests_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table library add constraint library_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table posts add constraint posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

alter table posts add constraint posts_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table profiles add constraint profiles_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table profiles add constraint profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;

alter table push_subs add constraint push_subs_user_id_fkey FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

alter table push_subs add constraint push_subs_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table quotes add constraint quotes_client_id_fkey FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE SET NULL;

alter table quotes add constraint quotes_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table quotes add constraint quotes_job_id_fkey FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE SET NULL;

alter table reports add constraint reports_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table reports add constraint reports_user_id_fkey FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

alter table reports add constraint reports_job_id_fkey FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE SET NULL;

alter table stock add constraint stock_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table time_entries add constraint time_entries_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table time_entries add constraint time_entries_user_id_fkey FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

alter table time_entries add constraint time_entries_job_id_fkey FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE SET NULL;

alter table vehicle_deadlines add constraint vehicle_deadlines_vehicle_id_fkey FOREIGN KEY (vehicle_id) REFERENCES vehicles(id) ON DELETE CASCADE;

alter table vehicle_deadlines add constraint vehicle_deadlines_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table vehicles add constraint vehicles_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table warranties add constraint warranties_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;

alter table warranties add constraint warranties_client_id_fkey FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE SET NULL;

CREATE INDEX chat_company_time ON public.chat_messages USING btree (company_id, created_at DESC);

CREATE INDEX comments_ref ON public.comments USING btree (ref_type, ref_id);

CREATE INDEX docs_company_date ON public.documents USING btree (company_id, doc_date DESC);

CREATE INDEX docs_company ON public.documents USING btree (company_id, created_at DESC);

CREATE INDEX expenses_company ON public.expenses USING btree (company_id, expense_date DESC);

CREATE INDEX invoices_company ON public.invoices USING btree (company_id, doc_date DESC);

CREATE INDEX jobs_company_start ON public.jobs USING btree (company_id, start_at);

CREATE INDEX library_company ON public.library USING btree (company_id);

CREATE INDEX quotes_company ON public.quotes USING btree (company_id, quote_date DESC);

CREATE INDEX reports_company_day ON public.reports USING btree (company_id, day DESC);

CREATE INDEX stock_company ON public.stock USING btree (company_id);

CREATE INDEX time_user ON public.time_entries USING btree (user_id, started_at DESC);

CREATE OR REPLACE FUNCTION public.clock_in(p_job uuid DEFAULT NULL::uuid)
  RETURNS void
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO 'public'
AS $function$
  declare v_company uuid := public.my_company();
  begin
  if v_company is null then raise exception 'Operazione non consentita'; end if;
  if exists (select 1 from public.time_entries where user_id = auth.uid() and ended_at is null) then
  raise exception 'Hai già una timbratura aperta';
  end if;
  if p_job is not null and public.job_company(p_job) is distinct from v_company then
  raise exception 'Lavoro non valido';
  end if;
  insert into public.time_entries (company_id, user_id, job_id) values (v_company, auth.uid(), p_job);
  end $function$
;

CREATE OR REPLACE FUNCTION public.clock_in_pos(p_job uuid, p_lat double precision, p_lng double precision)
  RETURNS void
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO 'public'
AS $function$
  begin
  perform public.clock_in(p_job);
  update public.time_entries set in_lat = p_lat, in_lng = p_lng
  where user_id = auth.uid() and ended_at is null;
  end $function$
;

CREATE OR REPLACE FUNCTION public.clock_out()
  RETURNS void
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO 'public'
AS $function$
  begin
  update public.time_entries set ended_at = now() where user_id = auth.uid() and ended_at is null;
  if not found then raise exception 'Nessuna timbratura aperta'; end if;
  end $function$
;

CREATE OR REPLACE FUNCTION public.clock_out_pos(p_lat double precision, p_lng double precision)
  RETURNS void
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO 'public'
AS $function$
  begin
  update public.time_entries set out_lat = p_lat, out_lng = p_lng
  where user_id = auth.uid() and ended_at is null;
  perform public.clock_out();
  end $function$
;

CREATE OR REPLACE FUNCTION public.handle_new_user()
  RETURNS trigger
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO 'public'
AS $function$
  declare
  meta jsonb := coalesce(new.raw_user_meta_data, '{}'::jsonb);
  v_name text := coalesce(nullif(trim(meta->>'full_name'), ''), 'Senza nome');
  v_reg text := nullif(trim(meta->>'tax_regime'), '');
  v_company uuid;
  begin
  if v_reg is not null and v_reg not in ('forfettario','semplificato','ordinario') then v_reg := null; end if;
  if nullif(trim(meta->>'company_name'), '') is not null then
  insert into public.companies (name, join_code, owner_id, tax_regime)
  values (trim(meta->>'company_name'),
  'AZ-' || upper(substr(md5(random()::text || clock_timestamp()::text), 1, 6)),
  new.id, v_reg)
  returning id into v_company;
  insert into public.profiles (id, company_id, full_name, email, role, status)
  values (new.id, v_company, v_name, new.email, 'owner', 'active');
  elsif nullif(trim(meta->>'join_code'), '') is not null then
  select id into v_company from public.companies where join_code = upper(trim(meta->>'join_code'));
  if v_company is null then raise exception 'Codice azienda non valido'; end if;
  insert into public.profiles (id, company_id, full_name, email, role, status)
  values (new.id, v_company, v_name, new.email, 'employee', 'pending');
  else
  raise exception 'Registrazione incompleta';
  end if;
  return new;
  end $function$
;

CREATE OR REPLACE FUNCTION public.is_active_member(p_user uuid, p_company uuid)
  RETURNS boolean
  LANGUAGE sql
  STABLE SECURITY DEFINER
  SET search_path TO 'public'
AS $function$
  select exists (select 1 from public.profiles where id = p_user and company_id = p_company and status = 'active')
  $function$
;

CREATE OR REPLACE FUNCTION public.is_assigned(p_job uuid)
  RETURNS boolean
  LANGUAGE sql
  STABLE SECURITY DEFINER
  SET search_path TO 'public'
AS $function$
  select exists (select 1 from public.job_assignments where job_id = p_job and user_id = auth.uid())
  $function$
;

CREATE OR REPLACE FUNCTION public.job_company(p_job uuid)
  RETURNS uuid
  LANGUAGE sql
  STABLE SECURITY DEFINER
  SET search_path TO 'public'
AS $function$
  select company_id from public.jobs where id = p_job
  $function$
;

CREATE OR REPLACE FUNCTION public.my_company()
  RETURNS uuid
  LANGUAGE sql
  STABLE SECURITY DEFINER
  SET search_path TO 'public'
AS $function$
  select company_id from public.profiles where id = auth.uid() and status = 'active' limit 1
  $function$
;

CREATE OR REPLACE FUNCTION public.my_owned_company()
  RETURNS uuid
  LANGUAGE sql
  STABLE SECURITY DEFINER
  SET search_path TO 'public'
AS $function$
  select company_id from public.profiles
  where id = auth.uid() and role = 'owner' and status = 'active' limit 1
  $function$
;

CREATE OR REPLACE FUNCTION public.set_company_extra(p_hourly numeric, p_ai boolean, p_provider text, p_pos boolean)
  RETURNS void
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO 'public'
AS $function$
  declare v_co uuid := public.my_owned_company();
  begin
  if v_co is null then raise exception 'Operazione non consentita'; end if;
  if p_provider not in ('claude','gemini') then raise exception 'Motore non valido'; end if;
  update public.companies set hourly_cost = p_hourly, ai_enabled = coalesce(p_ai, false), ai_provider = p_provider, track_pos = coalesce(p_pos, false) where id = v_co;
  end $function$
;

CREATE OR REPLACE FUNCTION public.set_company_settings(p_regime text, p_iva_period text, p_vat text, p_tax_code text, p_address text, p_phone text, p_email text)
  RETURNS void
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO 'public'
AS $function$
  declare v uuid := public.my_owned_company();
  begin
  if v is null then raise exception 'Operazione non consentita'; end if;
  if p_regime not in ('forfettario','semplificato','ordinario') then raise exception 'Regime non valido'; end if;
  if p_iva_period not in ('mensile','trimestrale') then raise exception 'Periodo IVA non valido'; end if;
  update public.companies set
  tax_regime = p_regime, iva_period = p_iva_period,
  vat_number = nullif(trim(p_vat), ''), tax_code = nullif(trim(p_tax_code), ''),
  address = nullif(trim(p_address), ''), phone = nullif(trim(p_phone), ''), email = nullif(trim(p_email), '')
  where id = v;
  end $function$
;

CREATE OR REPLACE FUNCTION public.set_member_status(p_user uuid, p_status text)
  RETURNS void
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO 'public'
AS $function$
  begin
  if p_status not in ('active','rejected') then
  raise exception 'Stato non valido';
  end if;
  update public.profiles
  set status = p_status
  where id = p_user
  and role = 'employee'
  and company_id = public.my_owned_company();
  if not found then
  raise exception 'Operazione non consentita';
  end if;
  end $function$
;

CREATE OR REPLACE FUNCTION public.set_my_name(p_name text)
  RETURNS void
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO 'public'
AS $function$
begin
  if coalesce(trim(p_name), '') = '' then raise exception 'Scrivi un nome'; end if;
  update public.profiles set full_name = trim(p_name) where id = auth.uid();
  end $function$
;

CREATE OR REPLACE FUNCTION public.update_job_progress(p_job uuid, p_status text, p_notes text)
  RETURNS void
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO 'public'
AS $function$
  begin
  if p_status not in ('todo','doing','done','void') then raise exception 'Stato non valido'; end if;
  if public.job_company(p_job) is distinct from public.my_company() then raise exception 'Operazione non consentita'; end if;
  update public.jobs set status = p_status, field_notes = p_notes where id = p_job;
  end $function$
;

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

alter table public.assets enable row level security;

alter table public.chat_messages enable row level security;

alter table public.checklists enable row level security;

alter table public.clients enable row level security;

alter table public.comments enable row level security;

alter table public.companies enable row level security;

alter table public.documents enable row level security;

alter table public.expenses enable row level security;

alter table public.invoices enable row level security;

alter table public.job_assignments enable row level security;

alter table public.job_checklists enable row level security;

alter table public.job_materials enable row level security;

alter table public.jobs enable row level security;

alter table public.km_log enable row level security;

alter table public.leave_requests enable row level security;

alter table public.library enable row level security;

alter table public.posts enable row level security;

alter table public.profiles enable row level security;

alter table public.push_config enable row level security;

alter table public.push_subs enable row level security;

alter table public.quotes enable row level security;

alter table public.reports enable row level security;

alter table public.stock enable row level security;

alter table public.time_entries enable row level security;

alter table public.vehicle_deadlines enable row level security;

alter table public.vehicles enable row level security;

alter table public.warranties enable row level security;

create policy assets_member on public.assets as PERMISSIVE for ALL to public using ((company_id = my_company())) with check ((company_id = my_company()));

create policy chat_sel on public.chat_messages as PERMISSIVE for SELECT to public using ((company_id = my_company()));

create policy chat_ins on public.chat_messages as PERMISSIVE for INSERT to public with check (((company_id = my_company()) AND (user_id = auth.uid())));

create policy chat_del on public.chat_messages as PERMISSIVE for DELETE to public using (((company_id = my_company()) AND ((user_id = auth.uid()) OR (company_id = my_owned_company()))));

create policy checklists_member on public.checklists as PERMISSIVE for ALL to public using ((company_id = my_company())) with check ((company_id = my_company()));

create policy clients_member_update on public.clients as PERMISSIVE for UPDATE to public using ((company_id = my_company())) with check ((company_id = my_company()));

create policy clients_member_insert on public.clients as PERMISSIVE for INSERT to public with check ((company_id = my_company()));

create policy clients_select on public.clients as PERMISSIVE for SELECT to public using ((company_id = my_company()));

create policy clients_write on public.clients as PERMISSIVE for ALL to public using ((company_id = my_owned_company())) with check ((company_id = my_owned_company()));

create policy comments_del on public.comments as PERMISSIVE for DELETE to public using (((company_id = my_company()) AND ((user_id = auth.uid()) OR (company_id = my_owned_company()))));

create policy comments_sel on public.comments as PERMISSIVE for SELECT to public using ((company_id = my_company()));

create policy comments_ins on public.comments as PERMISSIVE for INSERT to public with check (((company_id = my_company()) AND (user_id = auth.uid())));

create policy comments_upd on public.comments as PERMISSIVE for UPDATE to public using (((company_id = my_company()) AND ((user_id = auth.uid()) OR (company_id = my_owned_company())))) with check ((company_id = my_company()));

create policy "azienda propria" on public.companies as PERMISSIVE for SELECT to public using ((id IN ( SELECT profiles.company_id
   FROM profiles
  WHERE (profiles.id = auth.uid()))));

create policy doc_delete on public.documents as PERMISSIVE for DELETE to public using (((company_id = my_owned_company()) OR (uploaded_by = auth.uid())));

create policy doc_update on public.documents as PERMISSIVE for UPDATE to public using ((company_id = my_owned_company())) with check ((company_id = my_owned_company()));

create policy doc_select on public.documents as PERMISSIVE for SELECT to public using (((company_id = my_owned_company()) OR ((company_id = my_company()) AND ((uploaded_by = auth.uid()) OR (job_id IS NOT NULL)))));

create policy doc_insert on public.documents as PERMISSIVE for INSERT to public with check (((uploaded_by = auth.uid()) AND (company_id = my_company()) AND ((job_id IS NULL) OR (job_company(job_id) = company_id))));

create policy expenses_owner on public.expenses as PERMISSIVE for ALL to public using ((company_id = my_owned_company())) with check ((company_id = my_owned_company()));

create policy invoices_owner on public.invoices as PERMISSIVE for ALL to public using ((company_id = my_owned_company())) with check ((company_id = my_owned_company()));

create policy assign_select on public.job_assignments as PERMISSIVE for SELECT to public using (((user_id = auth.uid()) OR (job_company(job_id) = my_owned_company())));

create policy assign_member_delete on public.job_assignments as PERMISSIVE for DELETE to public using ((job_company(job_id) = my_company()));

create policy assign_member_insert on public.job_assignments as PERMISSIVE for INSERT to public with check ((job_company(job_id) = my_company()));

create policy assign_write on public.job_assignments as PERMISSIVE for ALL to public using ((job_company(job_id) = my_owned_company())) with check (((job_company(job_id) = my_owned_company()) AND is_active_member(user_id, job_company(job_id))));

create policy job_checklists_member on public.job_checklists as PERMISSIVE for ALL to public using ((company_id = my_company())) with check ((company_id = my_company()));

create policy mat_delete on public.job_materials as PERMISSIVE for DELETE to public using (((company_id = my_owned_company()) OR (added_by = auth.uid())));

create policy mat_select on public.job_materials as PERMISSIVE for SELECT to public using ((job_company(job_id) = my_company()));

create policy mat_insert on public.job_materials as PERMISSIVE for INSERT to public with check (((added_by = auth.uid()) AND (company_id = job_company(job_id)) AND (company_id = my_company())));

create policy jobs_select on public.jobs as PERMISSIVE for SELECT to public using ((company_id = my_company()));

create policy jobs_member_insert on public.jobs as PERMISSIVE for INSERT to public with check (((company_id = my_company()) AND (created_by = auth.uid())));

create policy jobs_write on public.jobs as PERMISSIVE for ALL to public using ((company_id = my_owned_company())) with check ((company_id = my_owned_company()));

create policy jobs_member_update_urgent on public.jobs as PERMISSIVE for UPDATE to public using (((company_id = my_company()) AND (title ~~ '🚨%'::text))) with check (((company_id = my_company()) AND (title ~~ '🚨%'::text)));

create policy jobs_member_update on public.jobs as PERMISSIVE for UPDATE to public using ((company_id = my_company())) with check ((company_id = my_company()));

create policy km_ins on public.km_log as PERMISSIVE for INSERT to public with check (((company_id = my_company()) AND (user_id = auth.uid())));

create policy km_sel on public.km_log as PERMISSIVE for SELECT to public using (((company_id = my_owned_company()) OR ((company_id = my_company()) AND (user_id = auth.uid()))));

create policy km_del on public.km_log as PERMISSIVE for DELETE to public using (((company_id = my_owned_company()) OR ((company_id = my_company()) AND (user_id = auth.uid()))));

create policy leave_sel on public.leave_requests as PERMISSIVE for SELECT to public using ((company_id = my_company()));

create policy leave_ins on public.leave_requests as PERMISSIVE for INSERT to public with check (((company_id = my_company()) AND (user_id = auth.uid()) AND (status = 'richiesta'::text)));

create policy leave_del on public.leave_requests as PERMISSIVE for DELETE to public using (((company_id = my_company()) AND ((company_id = my_owned_company()) OR ((user_id = auth.uid()) AND (status = 'richiesta'::text)))));

create policy leave_upd on public.leave_requests as PERMISSIVE for UPDATE to public using ((company_id = my_owned_company())) with check ((company_id = my_owned_company()));

create policy library_member on public.library as PERMISSIVE for ALL to public using ((company_id = my_company())) with check ((company_id = my_company()));

create policy lib_select on storage.objects as PERMISSIVE for SELECT to authenticated using (((bucket_id = 'docs'::text) AND ((storage.foldername(name))[1] = (my_company())::text) AND ((storage.foldername(name))[2] = 'lib'::text)));

create policy lib_delete on storage.objects as PERMISSIVE for DELETE to authenticated using (((bucket_id = 'docs'::text) AND ((storage.foldername(name))[1] = (my_company())::text) AND ((storage.foldername(name))[2] = 'lib'::text)));

create policy docs_insert on storage.objects as PERMISSIVE for INSERT to authenticated with check (((bucket_id = 'docs'::text) AND ((storage.foldername(name))[1] = (my_company())::text)));

create policy docs_delete on storage.objects as PERMISSIVE for DELETE to authenticated using (((bucket_id = 'docs'::text) AND ((storage.foldername(name))[1] = (my_owned_company())::text)));

create policy docs_select on storage.objects as PERMISSIVE for SELECT to authenticated using (((bucket_id = 'docs'::text) AND (EXISTS ( SELECT 1
   FROM documents d
  WHERE (d.file_path = objects.name)))));

create policy posts_del on public.posts as PERMISSIVE for DELETE to public using (((company_id = my_company()) AND ((user_id = auth.uid()) OR (company_id = my_owned_company()))));

create policy posts_sel on public.posts as PERMISSIVE for SELECT to public using ((company_id = my_company()));

create policy posts_ins on public.posts as PERMISSIVE for INSERT to public with check (((company_id = my_company()) AND (user_id = auth.uid())));

create policy posts_upd on public.posts as PERMISSIVE for UPDATE to public using (((company_id = my_company()) AND ((user_id = auth.uid()) OR (company_id = my_owned_company())))) with check ((company_id = my_company()));

create policy "titolare vede team" on public.profiles as PERMISSIVE for SELECT to public using ((company_id = my_owned_company()));

create policy "colleghi vedono colleghi" on public.profiles as PERMISSIVE for SELECT to public using (((company_id = my_company()) AND (status = 'active'::text)));

create policy "profilo proprio" on public.profiles as PERMISSIVE for SELECT to public using ((id = auth.uid()));

create policy "push proprie" on public.push_subs as PERMISSIVE for ALL to authenticated using ((user_id = auth.uid())) with check (((user_id = auth.uid()) AND (company_id = my_company())));

create policy quotes_owner on public.quotes as PERMISSIVE for ALL to public using ((company_id = my_owned_company())) with check ((company_id = my_owned_company()));

create policy reports_ins on public.reports as PERMISSIVE for INSERT to public with check (((company_id = my_company()) AND (user_id = auth.uid())));

create policy reports_del on public.reports as PERMISSIVE for DELETE to public using (((company_id = my_company()) AND ((user_id = auth.uid()) OR (company_id = my_owned_company()))));

create policy reports_sel on public.reports as PERMISSIVE for SELECT to public using ((company_id = my_company()));

create policy reports_upd on public.reports as PERMISSIVE for UPDATE to public using (((company_id = my_company()) AND ((user_id = auth.uid()) OR (company_id = my_owned_company())))) with check ((company_id = my_company()));

create policy stock_member on public.stock as PERMISSIVE for ALL to public using ((company_id = my_company())) with check ((company_id = my_company()));

create policy time_select on public.time_entries as PERMISSIVE for SELECT to public using (((user_id = auth.uid()) OR (company_id = my_owned_company())));

create policy time_delete on public.time_entries as PERMISSIVE for DELETE to public using ((company_id = my_owned_company()));

create policy vdl_member on public.vehicle_deadlines as PERMISSIVE for ALL to public using ((company_id = my_company())) with check ((company_id = my_company()));

create policy vehicles_member on public.vehicles as PERMISSIVE for ALL to public using ((company_id = my_company())) with check ((company_id = my_company()));

create policy warranties_member on public.warranties as PERMISSIVE for ALL to public using ((company_id = my_company())) with check ((company_id = my_company()));

insert into storage.buckets(id,name,public,file_size_limit) values ('docs','docs',false,10485760);
