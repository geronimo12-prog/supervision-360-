-- Ejecutar DESPUÉS de 01_escuelas_relevamiento.sql.
-- PRIVADO: sin cuentas autorizadas nadie puede consultar o modificar datos desde la app.
create table if not exists public.supervision_usuarios (
  usuario_id uuid primary key references auth.users(id) on delete cascade,
  nombre text not null default 'Silvia',
  creado_en timestamptz not null default now()
);
alter table public.supervision_usuarios enable row level security;
revoke all on public.supervision_usuarios from anon;
grant select on public.supervision_usuarios to authenticated;
drop policy if exists usuarios_ven_su_acceso on public.supervision_usuarios;
create policy usuarios_ven_su_acceso on public.supervision_usuarios for select to authenticated using (usuario_id = (select auth.uid()));

-- Comprobación de pertenencia. Esta tabla es solo administrada desde SQL Editor.
drop policy if exists supervision_lectura_escuelas on public.escuelas;
drop policy if exists supervision_escritura_escuelas on public.escuelas;
create policy supervision_lectura_escuelas on public.escuelas for select to authenticated
 using (exists (select 1 from public.supervision_usuarios a where a.usuario_id=(select auth.uid())));
create policy supervision_escritura_escuelas on public.escuelas for all to authenticated
 using (exists (select 1 from public.supervision_usuarios a where a.usuario_id=(select auth.uid())))
 with check (exists (select 1 from public.supervision_usuarios a where a.usuario_id=(select auth.uid())));
grant select, insert, update, delete on public.escuelas to authenticated;

drop policy if exists supervision_lectura_relevamientos on public.relevamientos_escuela;
create policy supervision_lectura_relevamientos on public.relevamientos_escuela for select to authenticated
 using (exists (select 1 from public.supervision_usuarios a where a.usuario_id=(select auth.uid())));
grant select on public.relevamientos_escuela to authenticated;

create table if not exists public.actividades (
 id uuid primary key default gen_random_uuid(),
 escuela_id uuid references public.escuelas(id) on delete set null,
 titulo text not null, tipo text not null default 'Actividad',
 fecha date not null, hora_inicio time, hora_fin time,
 destino text, cantidad_alumnos integer check (cantidad_alumnos is null or cantidad_alumnos>=0),
 descripcion text, estado text not null default 'Programada',
 creado_en timestamptz not null default now()
);
alter table public.actividades enable row level security;
revoke all on public.actividades from anon;
grant select,insert,update,delete on public.actividades to authenticated;
drop policy if exists supervision_actividades on public.actividades;
create policy supervision_actividades on public.actividades for all to authenticated
 using (exists (select 1 from public.supervision_usuarios a where a.usuario_id=(select auth.uid())))
 with check (exists (select 1 from public.supervision_usuarios a where a.usuario_id=(select auth.uid())));

-- Solo tras crear el usuario con email/contraseña en Authentication > Users,
-- obtener su UUID en Authentication > Users y ejecutar MANUALMENTE:
-- insert into public.supervision_usuarios(usuario_id,nombre)
-- values ('PEGAR-UUID-REAL-DEL-USUARIO', 'Silvia')
-- on conflict (usuario_id) do nothing;
-- No habilitar registro abierto en producción.
