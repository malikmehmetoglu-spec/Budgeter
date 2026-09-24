-- Cash box (الصندوق): manual entries plus confirmed income receipts.
alter table public.incomes add column pay_day smallint check (pay_day between 1 and 31);
create table public.cash (
  id uuid primary key default gen_random_uuid(),
  amount numeric not null,
  currency text not null check (currency in ('USD','SYP')),
  rate numeric not null,
  note text,
  moved_on date not null default current_date,
  income_id uuid references public.incomes(id) on delete set null,
  period text,
  created_at timestamptz not null default now(),
  unique (income_id, period)
);
alter table public.cash enable row level security;
create policy "open access" on public.cash for all to anon, authenticated using (true) with check (true);
grant select, insert, update, delete on public.cash to anon, authenticated;
