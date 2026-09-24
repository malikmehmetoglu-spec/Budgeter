-- Personal single-user app: no login. All tables are open to the public (anon) key.
do $$
declare t text;
begin
  foreach t in array array['categories','word_map','incomes','expenses','debts','debt_payments','savings'] loop
    execute format('drop policy if exists "own rows" on public.%I', t);
    execute format('alter table public.%I drop column user_id cascade', t);
    execute format('create policy "open access" on public.%I for all to anon, authenticated using (true) with check (true)', t);
  end loop;
end $$;
alter table public.word_map add primary key (word);
drop policy if exists "read rates" on public.rates;
drop policy if exists "manual rate" on public.rates;
drop policy if exists "manual rate update" on public.rates;
create policy "read rates" on public.rates for select to anon, authenticated using (true);
create policy "manual rate" on public.rates for insert to anon, authenticated with check (source = 'manual');
create policy "manual rate update" on public.rates for update to anon, authenticated using (true) with check (source = 'manual');
grant execute on function public.fetch_usd_rate() to anon;
