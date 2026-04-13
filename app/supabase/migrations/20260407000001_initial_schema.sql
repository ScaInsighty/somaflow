-- =============================================================
-- Somaflow — Migración inicial del schema
-- Fecha: 2026-04-07
-- Módulo 2: Diseño de Arquitectura y Estructura de Datos
-- =============================================================

-- gen_random_uuid() es nativo en PostgreSQL 13+ (disponible en Supabase sin extensiones)

-- =============================================================
-- ENUMS
-- =============================================================

create type edad_rango_enum as enum (
  '18-25', '26-35', '36-45', '46-55', '56+'
);

create type segmento_sn_enum as enum (
  'dorsal', 'simpatico', 'ventral'
);

create type estado_cuestionario_enum as enum (
  'regulado', 'colapsado', 'activado'
);

create type tipo_contenido_enum as enum (
  'rutina_30dias', 'regulacion_rapida'
);

create type categoria_rr_enum as enum (
  'ansiedad_activacion',
  'desbordado',
  'mente_acelerada',
  'tension_corporal',
  'cansado_sin_energia',
  'sueno',
  'volver_al_presente'
);

create type tipo_encuesta_enum as enum (
  'pre', 'post', 'pre_compra'
);

create type tipo_mensaje_wa_enum as enum (
  'bienvenida',
  'progreso',
  'reactivacion',
  'regulacion_rapida',
  'protocolo_crisis_n1',
  'protocolo_crisis_n2',
  'protocolo_crisis_n3',
  'alerta_interna'
);

create type estado_envio_enum as enum (
  'pendiente', 'enviado', 'fallido'
);

-- =============================================================
-- TABLA: usuarios
-- =============================================================

create table usuarios (
  id                    uuid primary key default gen_random_uuid(),
  nombre                text not null,
  correo                text not null unique,
  telefono              text,
  edad_rango            edad_rango_enum,
  pais                  text,
  fecha_registro        timestamptz not null default now(),
  fecha_inicio_programa date,
  segmento_sn           segmento_sn_enum,
  estado_cuestionario   estado_cuestionario_enum,
  opt_in_whatsapp       boolean not null default false,
  activo                boolean not null default true,

  constraint telefono_requerido_si_whatsapp
    check (opt_in_whatsapp = false or telefono is not null)
);

comment on table usuarios is 'Usuarios registrados en el programa Somaflow';
comment on column usuarios.segmento_sn is 'Resultado del Test del Sistema Nervioso — determina el orden de presentación de las rutinas';
comment on column usuarios.activo is 'Soft delete — no se borra físicamente para cumplir Ley 1581';

-- =============================================================
-- TABLA: contenidos
-- =============================================================

create table contenidos (
  id                uuid primary key default gen_random_uuid(),
  titulo            text not null,
  url_video_drive   text not null,
  url_pdf           text,
  duracion_minutos  int,
  tipo              tipo_contenido_enum not null,
  categoria_rr      categoria_rr_enum,
  activo            boolean not null default true,
  created_at        timestamptz not null default now(),

  constraint categoria_rr_solo_si_regulacion
    check (tipo = 'rutina_30dias' or categoria_rr is not null)
);

comment on table contenidos is 'Videos y materiales del programa — 30 rutinas + videos de Regulación Rápida';
comment on column contenidos.categoria_rr is 'Obligatorio cuando tipo = regulacion_rapida';

-- =============================================================
-- TABLA: secuencias
-- Mapea (segmento_sn, posición) → contenido para personalización
-- =============================================================

create table secuencias (
  id            uuid primary key default gen_random_uuid(),
  segmento_sn   segmento_sn_enum not null,
  posicion      int not null check (posicion >= 1 and posicion <= 30),
  contenido_id  uuid not null references contenidos(id) on delete restrict,

  unique (segmento_sn, posicion),
  unique (segmento_sn, contenido_id)
);

comment on table secuencias is 'Define el orden de las 30 rutinas por tipo de Sistema Nervioso. Silvia configura 3 secuencias (una por segmento) desde el panel admin.';

-- =============================================================
-- TABLA: progreso
-- =============================================================

create table progreso (
  id                  uuid primary key default gen_random_uuid(),
  usuario_id          uuid not null references usuarios(id) on delete cascade,
  posicion_programa   int not null check (posicion_programa >= 1 and posicion_programa <= 30),
  contenido_id        uuid not null references contenidos(id) on delete restrict,
  fecha_practica      date not null default current_date,
  completado          boolean not null default false,
  created_at          timestamptz not null default now(),

  unique (usuario_id, posicion_programa)
);

comment on table progreso is 'Registro de rutinas completadas por usuario. posicion_programa = día N en su secuencia personalizada.';

-- =============================================================
-- TABLA: respuestas_encuesta
-- =============================================================

create table respuestas_encuesta (
  id           uuid primary key default gen_random_uuid(),
  usuario_id   uuid not null references usuarios(id) on delete cascade,
  progreso_id  uuid references progreso(id) on delete set null,
  tipo         tipo_encuesta_enum not null,
  respuestas_json jsonb not null,
  fecha        timestamptz not null default now()
);

comment on table respuestas_encuesta is 'Respuestas a encuestas pre/post rutina y encuesta pre-compra (test SN). Estructura flexible vía jsonb.';
comment on column respuestas_encuesta.progreso_id is 'Null cuando es encuesta pre-compra (test del Sistema Nervioso)';

-- =============================================================
-- TABLA: envios_whatsapp
-- =============================================================

create table envios_whatsapp (
  id             uuid primary key default gen_random_uuid(),
  usuario_id     uuid not null references usuarios(id) on delete cascade,
  tipo_mensaje   tipo_mensaje_wa_enum not null,
  estado         estado_envio_enum not null default 'pendiente',
  fecha_envio    timestamptz,
  metadata_json  jsonb,
  created_at     timestamptz not null default now()
);

comment on table envios_whatsapp is 'Registro de todos los mensajes WhatsApp enviados o intentados. Usado por n8n para evitar duplicados y por el dashboard de Silvia.';
comment on column envios_whatsapp.metadata_json is 'Datos contextuales: keyword detectada, nivel de crisis, posición_programa, etc.';

-- =============================================================
-- TABLA: alertas_silvia
-- Mensajes de usuarios sin keyword detectada
-- =============================================================

create table alertas_silvia (
  id               uuid primary key default gen_random_uuid(),
  usuario_id       uuid not null references usuarios(id) on delete cascade,
  mensaje_usuario  text not null,
  revisado         boolean not null default false,
  created_at       timestamptz not null default now()
);

comment on table alertas_silvia is 'Mensajes de usuarios al bot sin keyword detectada. n8n inserta aquí y dispara email a Silvia para revisión manual.';

-- =============================================================
-- ÍNDICES
-- =============================================================

-- Consulta frecuente: ¿en qué día va el usuario?
create index idx_progreso_usuario_posicion
  on progreso(usuario_id, posicion_programa);

-- Verificar si ya se envió un tipo de mensaje a un usuario
create index idx_envios_wa_usuario_tipo_fecha
  on envios_whatsapp(usuario_id, tipo_mensaje, fecha_envio);

-- Alertas pendientes de revisión por Silvia
create index idx_alertas_silvia_pendientes
  on alertas_silvia(revisado, created_at)
  where revisado = false;

-- Búsqueda de usuarios activos con WhatsApp opt-in (n8n)
create index idx_usuarios_activos_whatsapp
  on usuarios(activo, opt_in_whatsapp)
  where activo = true and opt_in_whatsapp = true;

-- Contenidos activos por tipo (admin panel)
create index idx_contenidos_tipo_activo
  on contenidos(tipo, activo)
  where activo = true;

-- =============================================================
-- ROW LEVEL SECURITY (RLS)
-- =============================================================

alter table usuarios enable row level security;
alter table contenidos enable row level security;
alter table secuencias enable row level security;
alter table progreso enable row level security;
alter table respuestas_encuesta enable row level security;
alter table envios_whatsapp enable row level security;
alter table alertas_silvia enable row level security;

-- Usuarios: cada usuario solo ve y edita sus propios datos
create policy "usuarios_select_own" on usuarios
  for select using (auth.uid() = id);

create policy "usuarios_update_own" on usuarios
  for update using (auth.uid() = id);

-- Contenidos: lectura pública para usuarios autenticados
create policy "contenidos_select_authenticated" on contenidos
  for select to authenticated using (activo = true);

-- Secuencias: lectura pública para usuarios autenticados
create policy "secuencias_select_authenticated" on secuencias
  for select to authenticated using (true);

-- Progreso: cada usuario solo ve y crea su propio progreso
create policy "progreso_select_own" on progreso
  for select using (auth.uid() = usuario_id);

create policy "progreso_insert_own" on progreso
  for insert with check (auth.uid() = usuario_id);

create policy "progreso_update_own" on progreso
  for update using (auth.uid() = usuario_id);

-- Respuestas: cada usuario solo ve y crea sus propias respuestas
create policy "respuestas_select_own" on respuestas_encuesta
  for select using (auth.uid() = usuario_id);

create policy "respuestas_insert_own" on respuestas_encuesta
  for insert with check (auth.uid() = usuario_id);

-- envios_whatsapp y alertas_silvia: solo acceso via service_role (n8n + admin)
-- Sin políticas de usuario final → requieren service_role key
