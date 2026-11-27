-- Elimina il proprio account (richiesto da Google Play).
-- Titolare: cancella anche gli account dei dipendenti e l'azienda (tutti i dati a cascata).
create or replace function public.delete_my_account()
returns void language plpgsql security definer set search_path = public, auth as $$
declare uid uuid := auth.uid();
begin
  if uid is null then raise exception 'Non autenticato'; end if;
  delete from auth.users where id in (
    select p.id from public.profiles p join public.companies c on c.id = p.company_id
    where c.owner_id = uid and p.id <> uid);
  delete from public.companies where owner_id = uid;
  delete from auth.users where id = uid;
end $$;
revoke execute on function public.delete_my_account() from public, anon;
grant execute on function public.delete_my_account() to authenticated;
