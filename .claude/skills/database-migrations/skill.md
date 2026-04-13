---
name: database-migrations
description: Mejores prácticas para migraciones de base de datos seguras, sin downtime, en PostgreSQL y Supabase. Usar cuando se creen o modifiquen tablas, columnas, índices, o cuando se planifiquen cambios en producción. Relevante para Somaflow (Supabase en producción) y Cuesta-Lawyers (Railway PostgreSQL con datos legales).
origin: ecc-source (adapted for Insighty AI)
---

# Database Migration Patterns

Cambios de schema de base de datos seguros y sin downtime para sistemas en producción.

## Cuándo Activar

- Creando o modificando tablas en Supabase (Somaflow)
- Modificando schema en Railway PostgreSQL (Cuesta-Lawyers)
- Planeando migración de Google Sheets a PostgreSQL (Fits-LLC futuro)
- Agregando/quitando columnas o índices
- Corriendo migraciones de datos (backfill, transformación)
- Planeando cambios de schema sin downtime

## Principios Core

1. **Todo cambio es una migración** — nunca alterar base de datos de producción manualmente
2. **Migraciones son forward-only en producción** — los rollbacks usan nuevas migraciones forward
3. **Schema y data migrations son separadas** — nunca mezclar DDL y DML en una migración
4. **Testear contra datos de tamaño real** — una migración que funciona en 100 filas puede bloquear con 10M
5. **Las migraciones son inmutables una vez desplegadas** — nunca editar una migración ya ejecutada en producción

## Checklist de Seguridad de Migración

Antes de aplicar cualquier migración:

- [ ] Migración tiene UP y DOWN (o marcada explícitamente como irreversible)
- [ ] Sin full table locks en tablas grandes (usar operaciones concurrentes)
- [ ] Nuevas columnas tienen defaults o son nullable (nunca agregar NOT NULL sin default)
- [ ] Índices creados concurrentemente (no inline con CREATE TABLE para tablas existentes)
- [ ] Backfill de datos es una migración separada del cambio de schema
- [ ] Testeado contra copia de datos de producción
- [ ] Plan de rollback documentado

## Patrones PostgreSQL/Supabase

### Agregar una Columna Seguramente

```sql
-- BIEN: Columna nullable, sin lock
ALTER TABLE users ADD COLUMN avatar_url TEXT;

-- BIEN: Columna con default (Postgres 11+ es instantáneo, sin rewrite)
ALTER TABLE users ADD COLUMN is_active BOOLEAN NOT NULL DEFAULT true;

-- MAL: NOT NULL sin default en tabla existente (requiere full rewrite + lock)
ALTER TABLE users ADD COLUMN role TEXT NOT NULL;
```

### Agregar un Índice sin Downtime

```sql
-- MAL: Bloquea writes en tablas grandes
CREATE INDEX idx_users_email ON users (email);

-- BIEN: Non-blocking, permite writes concurrentes
CREATE INDEX CONCURRENTLY idx_users_email ON users (email);

-- Nota: CONCURRENTLY no puede correr dentro de un bloque de transacción
-- Supabase: usar migraciones SQL directas para operaciones CONCURRENTLY
```

### Renombrar una Columna (Zero-Downtime)

Nunca renombrar directamente en producción. Usar el patrón expand-contract:

```sql
-- Paso 1: Agregar nueva columna (migración 001)
ALTER TABLE profiles ADD COLUMN display_name TEXT;

-- Paso 2: Backfill de datos (migración 002, data migration separada)
UPDATE profiles SET display_name = username WHERE display_name IS NULL;

-- Paso 3: Actualizar código de aplicación para leer/escribir ambas columnas
-- Desplegar cambios de aplicación

-- Paso 4: Dejar de escribir a columna vieja, droparla (migración 003)
ALTER TABLE profiles DROP COLUMN username;
```

### Migraciones de Datos Grandes

```sql
-- MAL: Actualiza todas las filas en una transacción (lockea tabla)
UPDATE users SET normalized_email = LOWER(email);

-- BIEN: Batch update con progreso
DO $$
DECLARE
  batch_size INT := 10000;
  rows_updated INT;
BEGIN
  LOOP
    UPDATE users
    SET normalized_email = LOWER(email)
    WHERE id IN (
      SELECT id FROM users
      WHERE normalized_email IS NULL
      LIMIT batch_size
      FOR UPDATE SKIP LOCKED
    );
    GET DIAGNOSTICS rows_updated = ROW_COUNT;
    RAISE NOTICE 'Updated % rows', rows_updated;
    EXIT WHEN rows_updated = 0;
    COMMIT;
  END LOOP;
END $$;
```

## Supabase (Somaflow)

### Workflow con Supabase CLI

```bash
# Crear nueva migración
supabase migration new add_user_nervous_system_type

# Aplicar migraciones pendientes en desarrollo
supabase db push

# Aplicar en producción
supabase db push --db-url postgresql://...

# Ver estado de migraciones
supabase migration list

# Generar tipos TypeScript desde schema
supabase gen types typescript --local > types/supabase.ts
```

### RLS en Migraciones (Somaflow)

```sql
-- Al crear una tabla nueva, SIEMPRE agregar RLS
ALTER TABLE practices ENABLE ROW LEVEL SECURITY;

-- Políticas: usar (SELECT auth.uid()) para performance
CREATE POLICY "users_own_practices" ON practices
  FOR ALL USING ((SELECT auth.uid()) = user_id);

-- Para datos de solo lectura pública
CREATE POLICY "public_read" ON nervous_system_tests
  FOR SELECT USING (true);
```

### Consideraciones para Somaflow

```sql
-- Tabla de usuarios con tipo de sistema nervioso (3 tipos × 3 estados = 9 combinaciones)
ALTER TABLE profiles 
  ADD COLUMN nervous_system_type TEXT CHECK (nervous_system_type IN ('type_a', 'type_b', 'type_c')),
  ADD COLUMN emotional_state TEXT CHECK (emotional_state IN ('calm', 'activated', 'freeze'));

-- Índice para queries frecuentes de contenido personalizado
CREATE INDEX CONCURRENTLY idx_profiles_ns_type 
  ON profiles (nervous_system_type, emotional_state) 
  WHERE nervous_system_type IS NOT NULL;

-- Tabla de progreso de 30 días (soft delete para no perder datos de usuario)
ALTER TABLE practice_progress ADD COLUMN deleted_at TIMESTAMPTZ;
CREATE INDEX CONCURRENTLY idx_practice_progress_active 
  ON practice_progress (user_id) 
  WHERE deleted_at IS NULL;
```

## Railway PostgreSQL (Cuesta-Lawyers)

### Consideraciones de Compliance Legal

```sql
-- Audit trail: NUNCA borrar registros de proceso de marcas
-- Usar soft delete
ALTER TABLE trademark_applications ADD COLUMN deleted_at TIMESTAMPTZ;
ALTER TABLE trademark_applications ADD COLUMN deleted_by TEXT;

-- Trazabilidad completa de cada estado
CREATE TABLE trademark_status_history (
  id BIGSERIAL PRIMARY KEY,
  trademark_id BIGINT NOT NULL REFERENCES trademark_applications(id),
  old_status TEXT,
  new_status TEXT NOT NULL,
  changed_by TEXT NOT NULL,
  changed_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  notes TEXT
);

CREATE INDEX idx_trademark_status_history_trademark_id 
  ON trademark_status_history (trademark_id);

-- Deduplicación: constraint único en combinación de campos clave
ALTER TABLE trademark_applications 
  ADD CONSTRAINT unique_trademark_per_client 
  UNIQUE (client_id, trademark_name, ompi_class);
```

## Estrategia Zero-Downtime (Expand-Contract)

Para cambios críticos en producción, seguir el patrón expand-contract:

```
Fase 1: EXPAND
  - Agregar nueva columna/tabla (nullable o con default)
  - Deploy: app escribe a AMBAS columnas (vieja y nueva)
  - Backfill de datos existentes

Fase 2: MIGRATE
  - Deploy: app lee de NUEVA, escribe a AMBAS
  - Verificar consistencia de datos

Fase 3: CONTRACT
  - Deploy: app solo usa NUEVA
  - Dropear columna/tabla vieja en migración separada
```

### Ejemplo de Timeline

```
Día 1: Migración agrega columna new_status (nullable)
Día 1: Deploy app v2 — escribe a status Y new_status
Día 2: Correr migración de backfill para filas existentes
Día 3: Deploy app v3 — lee solo de new_status
Día 7: Migración dropea columna status vieja
```

## Anti-Patrones

| Anti-Patrón | Por qué falla | Mejor enfoque |
|-------------|--------------|---------------|
| SQL manual en producción | Sin audit trail, no repetible | Siempre usar migration files |
| Editar migraciones desplegadas | Causa drift entre entornos | Crear nueva migración |
| NOT NULL sin default | Lockea tabla, reescribe todas las filas | Agregar nullable, backfill, luego constraint |
| Índice inline en tabla grande | Bloquea writes durante build | CREATE INDEX CONCURRENTLY |
| Schema + data en una migración | Difícil hacer rollback, transacciones largas | Migraciones separadas |
| Dropear columna antes de quitar código | Errores en app en producción | Quitar código primero, dropear columna en próximo deploy |
