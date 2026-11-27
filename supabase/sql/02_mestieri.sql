-- Tabella dei mestieri (letta dall'app online) e mestiere dell'azienda
create table public.trades (id text primary key, name text not null, icon text not null default '🛠️', sort int not null default 50, active boolean not null default true, config jsonb not null default '{}'::jsonb, updated_at timestamptz not null default now());
alter table public.trades enable row level security;
create policy trades_read on public.trades for select to anon, authenticated using (active);
alter table public.companies add column trade text references public.trades(id) on update cascade;
-- set_company_trade(p_trade) e handle_new_user (con meta "trade"): vedi database Supabase "app-generica"
