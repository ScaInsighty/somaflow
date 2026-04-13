---
description: Revisar esquemas de base de datos, queries SQL y migraciones. Usa el agente database-reviewer para verificar índices, tipos de datos, RLS (Supabase), seguridad y performance. Incluye patrones específicos para Supabase (Somaflow) y Railway PostgreSQL (Cuesta-Lawyers).
---

Invoca el agente `database-reviewer` para revisar el código de base de datos indicado.

Si el usuario no especificó qué revisar, buscar en el contexto actual:
- Archivos de migración (*.sql, migration files de Supabase, Prisma, Drizzle)
- Queries SQL en el código
- Definiciones de schema o modelos

El agente debe:
1. Identificar el cliente/proyecto para aplicar reglas específicas:
   - **Somaflow (Supabase):** verificar RLS, políticas con `(SELECT auth.uid())`, esquema de tipos de sistema nervioso
   - **Cuesta-Lawyers (Railway):** verificar audit trails, soft delete, deduplicación con UNIQUE constraints
   - **Fits-LLC:** verificar estructura para migración futura de Sheets a PostgreSQL

2. Aplicar el checklist completo del agente database-reviewer:
   - Performance (índices, N+1, EXPLAIN ANALYZE)
   - Schema design (tipos de datos correctos, constraints)
   - Seguridad (RLS, permisos, queries parametrizados)
   - Migraciones (expand-contract, CONCURRENTLY, batch updates)

3. Presentar findings por severidad con ejemplos de fix

Para migraciones: usar también la skill `database-migrations` para verificar que el proceso sea seguro para producción.
