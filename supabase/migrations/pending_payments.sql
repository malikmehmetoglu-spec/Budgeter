-- Pending expected payments: shown as messages until confirmed with "تم", then moved into the cash box.
create table public.pending (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  amount numeric not null check (amount > 0),
  currency text not null check (currency in ('USD','SYP')),
  direction smallint not null default 1 check (direction in (1,-1)),
  expected_on date,
  note text,
  created_at timestamptz not null default now()
);
alter table public.pending enable row level security;
create policy "open access" on public.pending for all to anon, authenticated using (true) with check (true);
grant select, insert, update, delete on public.pending to anon, authenticated;
