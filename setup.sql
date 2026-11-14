-- BOON-Petition: einmal im Supabase SQL Editor ausführen

create table if not exists public.signatures (
  id uuid primary key default gen_random_uuid(),
  name text not null check (char_length(btrim(name)) between 1 and 60),
  comment text not null default '' check (char_length(comment) <= 200),
  created_at timestamptz not null default now()
);

alter table public.signatures enable row level security;

-- Alle dürfen die Unterschriften lesen
create policy "Unterschriften lesen" on public.signatures
  for select to anon using (true);

-- Alle dürfen unterschreiben (nur neue Zeilen, kein Ändern/Löschen)
create policy "Unterschreiben" on public.signatures
  for insert to anon with check (true);

-- Löschen von Spam/Quatsch: im Supabase-Dashboard unter Table Editor → signatures
