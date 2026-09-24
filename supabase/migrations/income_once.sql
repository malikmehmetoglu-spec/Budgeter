-- Allow one-off (non-recurring) incomes, e.g. piecework paid as a lump sum.
alter table public.incomes drop constraint incomes_frequency_check;
alter table public.incomes add constraint incomes_frequency_check check (frequency in ('daily','monthly','yearly','once'));
