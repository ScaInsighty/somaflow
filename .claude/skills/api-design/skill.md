---
name: api-design
description: Patrones de diseño REST API incluyendo naming de recursos, status codes, paginación, filtros, respuestas de error, versionado y rate limiting. Usar cuando se diseñen nuevos endpoints, se revisen contratos API, o se preparen especificaciones OpenAPI/Postman. Relevante para Cuesta-Lawyers (entrega OpenAPI + Postman para Claro SuperApp) y Somaflow (API Next.js).
origin: ecc-source (adapted for Insighty AI)
---

# API Design Patterns

Convenciones y mejores prácticas para diseñar APIs REST consistentes y orientadas al desarrollador.

## Cuándo Activar

- Diseñando nuevos endpoints API
- Revisando contratos API existentes
- Preparando especificaciones OpenAPI/Postman (especialmente Cuesta-Lawyers M6)
- Implementando paginación, filtros o sorting
- Planificando estrategia de versionado
- Construyendo APIs públicas o para partners (ej: Claro SuperApp)

## Diseño de Recursos

### Estructura de URLs

```
# Los recursos son sustantivos, plural, lowercase, kebab-case
GET    /api/v1/trademarks
GET    /api/v1/trademarks/:id
POST   /api/v1/trademarks
PUT    /api/v1/trademarks/:id
PATCH  /api/v1/trademarks/:id
DELETE /api/v1/trademarks/:id

# Sub-recursos para relaciones
GET    /api/v1/trademarks/:id/documents
POST   /api/v1/trademarks/:id/documents

# Acciones que no mapean a CRUD (usar verbos con moderación)
POST   /api/v1/trademarks/:id/submit-for-review
POST   /api/v1/auth/login
POST   /api/v1/auth/refresh
```

### Reglas de Naming

```
# BIEN
/api/v1/team-members          # kebab-case para recursos multi-palabra
/api/v1/candidates?status=active  # query params para filtros
/api/v1/jobs/123/candidates       # recursos anidados para ownership

# MAL
/api/v1/getCandidates             # verbo en URL
/api/v1/candidate                 # singular (usar plural)
/api/v1/team_members              # snake_case en URLs
```

## HTTP Methods y Status Codes

### Semántica de Métodos

| Método | Idempotente | Safe | Usar para |
|--------|-----------|------|---------|
| GET | Sí | Sí | Recuperar recursos |
| POST | No | No | Crear recursos, trigger de acciones |
| PUT | Sí | No | Reemplazo completo de un recurso |
| PATCH | No | No | Actualización parcial |
| DELETE | Sí | No | Eliminar un recurso |

### Status Codes de Referencia

```
# Éxito
200 OK                    — GET, PUT, PATCH (con response body)
201 Created               — POST (incluir Location header)
204 No Content            — DELETE, PUT (sin response body)

# Errores de cliente
400 Bad Request           — Fallo de validación, JSON malformado
401 Unauthorized          — Auth faltante o inválida
403 Forbidden             — Autenticado pero no autorizado
404 Not Found             — Recurso no existe
409 Conflict              — Entrada duplicada, conflicto de estado
422 Unprocessable Entity  — Semánticamente inválido
429 Too Many Requests     — Rate limit excedido

# Errores de servidor
500 Internal Server Error — Fallo inesperado (nunca exponer detalles)
502 Bad Gateway           — Servicio upstream falló
503 Service Unavailable   — Sobrecarga temporal, incluir Retry-After
```

## Formato de Respuesta

### Respuesta Exitosa

```json
{
  "data": {
    "id": "abc-123",
    "trademark_name": "MARCA XYZ",
    "ompi_class": 35,
    "status": "pending_review",
    "created_at": "2026-03-27T10:30:00Z"
  }
}
```

### Respuesta de Colección (con Paginación)

```json
{
  "data": [
    { "id": "abc-123", "trademark_name": "MARCA XYZ" },
    { "id": "def-456", "trademark_name": "MARCA ABC" }
  ],
  "meta": {
    "total": 142,
    "page": 1,
    "per_page": 20,
    "total_pages": 8
  },
  "links": {
    "self": "/api/v1/trademarks?page=1&per_page=20",
    "next": "/api/v1/trademarks?page=2&per_page=20",
    "last": "/api/v1/trademarks?page=8&per_page=20"
  }
}
```

### Respuesta de Error

```json
{
  "error": {
    "code": "validation_error",
    "message": "La solicitud contiene campos inválidos",
    "details": [
      {
        "field": "trademark_name",
        "message": "El nombre de marca es requerido",
        "code": "required"
      },
      {
        "field": "ompi_class",
        "message": "La clase debe estar entre 1 y 45",
        "code": "out_of_range"
      }
    ]
  }
}
```

## Paginación

### Offset-Based (Simple, para datasets pequeños)

```
GET /api/v1/trademarks?page=2&per_page=20
```

**Pros:** Fácil de implementar, soporta "ir a página N"
**Cons:** Lento en offsets grandes, inconsistente con inserts concurrentes

### Cursor-Based (Escalable, para feeds y listas grandes)

```
GET /api/v1/candidates?cursor=eyJpZCI6MTIzfQ&limit=20
```

**Cuándo usar cuál:**

| Caso de uso | Tipo de paginación |
|-------------|-------------------|
| Admin dashboards, datasets pequeños (<10K) | Offset |
| Feeds infinitos, datasets grandes | Cursor |
| APIs públicas (Claro SuperApp) | Cursor por defecto |

## Autenticación y Autorización

### OAuth 2.0 + PKCE (para Cuesta-Lawyers / Claro SuperApp)

```
# Flow recomendado para integraciones con SuperApp
GET /oauth/authorize?
  response_type=code&
  client_id=CLIENT_ID&
  redirect_uri=REDIRECT_URI&
  code_challenge=CODE_CHALLENGE&
  code_challenge_method=S256&
  state=RANDOM_STATE

POST /oauth/token
  grant_type=authorization_code
  code=AUTH_CODE
  code_verifier=CODE_VERIFIER
```

### JWT (RS256/ES256)

```
# Bearer token en Authorization header
GET /api/v1/trademarks
Authorization: Bearer eyJhbGciOiJSUzI1NiIs...

# Validación
- Verificar firma con clave pública
- Verificar `exp` (expiración)
- Verificar `iss` (emisor)
- Verificar `aud` (audiencia)
```

## Rate Limiting

### Headers

```
HTTP/1.1 200 OK
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1640000000

# Cuando se excede
HTTP/1.1 429 Too Many Requests
Retry-After: 60
```

## Versionado

### URL Path (Recomendado)

```
/api/v1/trademarks
/api/v2/trademarks
```

**Estrategia:**
1. Empezar con `/api/v1/` — no versionar hasta ser necesario
2. Mantener máximo 2 versiones activas (actual + anterior)
3. Cambios no-breaking no necesitan nueva versión:
   - Agregar nuevos campos en respuestas
   - Agregar nuevos query params opcionales
   - Agregar nuevos endpoints
4. Cambios breaking requieren nueva versión:
   - Eliminar o renombrar campos
   - Cambiar tipos de campos
   - Cambiar estructura de URLs

## Especificación OpenAPI (Cuesta-Lawyers M6)

```yaml
openapi: 3.0.3
info:
  title: Cuesta Lawyers Trademark API
  version: 1.0.0
  description: API para integración con Claro SuperApp

paths:
  /api/v1/trademarks:
    post:
      summary: Crear nueva solicitud de marca
      security:
        - BearerAuth: []
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreateTrademarkRequest'
      responses:
        '201':
          description: Solicitud creada exitosamente
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/TrademarkResponse'
        '422':
          description: Error de validación
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
```

## Checklist API Design

Antes de entregar un nuevo endpoint:

- [ ] URL de recurso sigue convenciones (plural, kebab-case, sin verbos)
- [ ] HTTP method correcto usado
- [ ] Status codes apropiados retornados
- [ ] Input validado con schema (Zod para TypeScript, Pydantic para Python)
- [ ] Errores siguen formato estándar con códigos y mensajes
- [ ] Paginación implementada para endpoints de lista
- [ ] Autenticación requerida (o marcada explícitamente como pública)
- [ ] Autorización verificada (usuario solo accede a sus propios recursos)
- [ ] Rate limiting configurado
- [ ] Response no expone detalles internos (stack traces, SQL errors)
- [ ] Naming consistente con endpoints existentes
- [ ] Documentado en OpenAPI/Swagger spec
