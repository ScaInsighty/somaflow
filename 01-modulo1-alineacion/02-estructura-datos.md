# Estructura de Datos — SomaFlow
*Módulo 1 — Alineación Operativa*
*Versión 1.0 — Abril 2026*

---

## Tablas

### usuarios
| Campo | Tipo | Requerido | Descripción |
|---|---|---|---|
| id | UUID | ✅ | Identificador único |
| nombre | TEXT | ✅ | Nombre completo |
| genero | TEXT | ✅ | Género del usuario |
| edad_rango | TEXT | ✅ | 18-25 / 26-35 / 36-45 / 46-55 / 56+ |
| correo | TEXT | ✅ | Email único |
| telefono | TEXT | ✅ | Para WhatsApp (con código de país) |
| pais | TEXT | ❌ | Opcional |
| fecha_registro | TIMESTAMP | ✅ | Fecha de creación del registro |
| fecha_inicio_programa | DATE | ✅ | Día 1 del programa |
| segmento_sistema_nervioso | TEXT | ❌ | Dorsal / Simpático / Ventral |
| estado_cuestionario | TEXT | ❌ | Regulado / Colapsado / Activado |
| whatsapp_opt_in | BOOLEAN | ✅ | Consentimiento para mensajes |
| activo | BOOLEAN | ✅ | Estado del usuario en el programa |

---

### contenidos
| Campo | Tipo | Requerido | Descripción |
|---|---|---|---|
| id | UUID | ✅ | Identificador único |
| tipo | TEXT | ✅ | rutina / regulacion_rapida |
| dia_programa | INTEGER | ❌ | 1-30 (solo para rutinas) |
| titulo | TEXT | ✅ | Nombre del video |
| url_video | TEXT | ✅ | Link Google Drive |
| url_pdf | TEXT | ❌ | Link PDF descargable |
| duracion_min | INTEGER | ❌ | Duración en minutos |
| categoria | TEXT | ❌ | Para regulación rápida (ansiedad, tensión, etc.) |
| activo | BOOLEAN | ✅ | Visible para usuarios |

---

### progreso
| Campo | Tipo | Requerido | Descripción |
|---|---|---|---|
| id | UUID | ✅ | Identificador único |
| usuario_id | UUID | ✅ | FK → usuarios |
| contenido_id | UUID | ✅ | FK → contenidos |
| dia_programa | INTEGER | ✅ | Día del programa (1-30) |
| completado | BOOLEAN | ✅ | Si realizó la rutina |
| fecha_hora | TIMESTAMP | ✅ | Cuándo completó |
| racha_actual | INTEGER | ✅ | Días consecutivos al momento |

---

### respuestas_encuesta
| Campo | Tipo | Requerido | Descripción |
|---|---|---|---|
| id | UUID | ✅ | Identificador único |
| usuario_id | UUID | ✅ | FK → usuarios |
| progreso_id | UUID | ✅ | FK → progreso |
| tipo | TEXT | ✅ | pre / post |
| emocional_score | INTEGER | ❌ | Escala 1-5 |
| corporal_estado | TEXT | ❌ | relajado / neutral / tenso / rígido / cansado / inquieto |
| senales_regulacion | TEXT[] | ❌ | Array de señales detectadas |
| fecha_hora | TIMESTAMP | ✅ | Cuándo respondió |

---

### envios_whatsapp
| Campo | Tipo | Requerido | Descripción |
|---|---|---|---|
| id | UUID | ✅ | Identificador único |
| usuario_id | UUID | ✅ | FK → usuarios |
| tipo_trigger | TEXT | ✅ | bienvenida / progreso / reactivacion / cierre / regulacion |
| mensaje | TEXT | ✅ | Contenido enviado |
| fecha_hora | TIMESTAMP | ✅ | Cuándo se envió |
| estado | TEXT | ✅ | enviado / fallido |

---

## Relaciones

```
usuarios
  ├── progreso (1:N)
  │     └── respuestas_encuesta (1:2 — pre y post)
  ├── envios_whatsapp (1:N)
  └── contenidos (N:M vía progreso)
```

---

## Notas técnicas

- Motor: **PostgreSQL vía Supabase**
- Auth: **Supabase Auth nativo** (email + password)
- Encriptación: en reposo y en tránsito (Supabase por defecto)
- Derecho al olvido: eliminación en cascada por usuario_id
- Row Level Security (RLS): activado — cada usuario solo ve sus propios datos
