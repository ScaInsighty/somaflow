# CLAUDE.md — Somaflow
*Contexto para el agente de Insighty AI*

---

## Quién eres en este proyecto

Eres el agente de desarrollo de Insighty AI trabajando en el proyecto **SomaFlow** para la cliente **Silvia Diazgranados**, psicóloga y creadora del programa de bienestar somático Somaflow.

Tu rol es apoyar al equipo técnico de Insighty en el desarrollo, documentación y toma de decisiones del proyecto. Tienes acceso a todos los documentos del cliente y debes mantener coherencia con las decisiones ya tomadas.

---

## El proyecto en una línea

Sistema web + automatización WhatsApp que permite a usuarios de un programa de bienestar de 30 días acceder a rutinas somáticas en video, completar encuestas opcionales pre/post práctica, y recibir acompañamiento automatizado — todo administrado por Silvia desde un micrositio.

---

## Documentos clave del proyecto

| Documento | Contenido |
|---|---|
| `Brief.md` | Contexto del negocio, flujos, encuestas, stack, visión a futuro |
| `Contrato.md` | Partes, pagos, módulos, plazos, exclusiones |
| `PRD.md` | Requerimientos funcionales por módulo, flujos detallados, pendientes |
| `Decisiones.md` | Registro de decisiones técnicas y de negocio (DEC-001 a DEC-019) |
| `Reuniones.md` | Actas de reuniones y acuerdos |

---

## Decisiones ya tomadas — NO reabrir sin justificación

| # | Decisión | Estado |
|---|---|---|
| DEC-001 | Encuestas opcionales — no condicionan acceso al video | ✅ |
| DEC-002 | Videos en micrositio, NO por WhatsApp | ✅ |
| DEC-003 | Número de negocio dedicado a Somaflow | ✅ |
| DEC-004 | Mobile-first | ✅ |
| DEC-005 | Somaflow es programa de bienestar, NO clínico | ✅ |
| DEC-006 | Respuestas de encuestas dentro del micrositio | ✅ |
| DEC-007 | Hosting en Google Cloud | ✅ |
| DEC-008 | Supabase + PostgreSQL como base de datos | ✅ |
| DEC-009 | Micrositio a medida, NO Mighty Networks | ✅ |
| DEC-010 | Plataforma de pagos: Stripe | ✅ |
| DEC-011 | Landing + Test del Sistema Nervioso dentro del alcance | ✅ |
| DEC-012 | Regulación Rápida: videos cortos independientes, acceso libre en micrositio | ✅ |
| DEC-013 | Correo de confirmación de compra lo envía Stripe | ✅ |
| DEC-014 | Categorías Regulación Rápida: ANSIEDAD-ACTIVACIÓN / DESBORDADO / MENTE ACELERADA / TENSIÓN CORPORAL / CANSADO-SIN ENERGÍA / SUEÑO / VOLVER AL PRESENTE | ✅ |
| DEC-015 | Lista de palabras clave por categoría definida (ver PRD.md — Módulo 3) | ✅ |
| DEC-016 | Twilio reemplazado por Meta WhatsApp Cloud API directo — menor costo operativo | ✅ |
| DEC-017 | Protocolo de crisis WhatsApp incluido en M3; recursos solo Colombia en v1 | ✅ |
| DEC-018 | Alerta a Silvia para mensajes sin keyword → canal email | ✅ |
| DEC-019 | Test SN → 30 videos mismos, 3 órdenes distintos por resultado (Dorsal/Simpático/Ventral) | ✅ |

---

## Stack técnico confirmado

- **Automatización:** n8n (configurar desde cero)
- **WhatsApp:** Meta WhatsApp Cloud API directo (sin intermediario)
- **Hosting:** Google Cloud
- **Base de datos:** Supabase + PostgreSQL
- **Pagos:** Stripe
- **Frontend:** Aplicación web a medida — mobile-first

---

## Estructura del programa

- 30 días consecutivos, una rutina por día
- Videos: formato vertical 4:3, 4K, duración media 15 minutos
- Alojados en Google Drive (Silvia los está cargando)
- Sin reglas de secuenciación entre rutinas
- Cada día: encuesta pre (2 preguntas) → video → encuesta post (3 preguntas)

---

## Encuestas — preguntas exactas

### Pre-rutina (2 preguntas — opcionales)
1. ¿Cómo está tu estado emocional ahora? — Escala 1-5 (Muy mal / Mal / Neutro / Bien / Muy bien)
2. ¿Cómo se siente tu cuerpo ahora? — Opción múltiple (relajado / neutral / tenso / rígido / cansado / inquieto)

### Post-rutina (3 preguntas — opcionales)
1. ¿Cómo está tu estado emocional ahora? — Escala 1-5 (mismas opciones)
2. ¿Cómo se siente tu cuerpo ahora? — Opción múltiple (mismas opciones)
3. ¿Notaste algún cambio en tu cuerpo? — Selección múltiple (bostezos / suspiros / respiración más profunda / temblores suaves / sensación de frío o calor / lágrimas sin carga emocional / ninguno)

---

## Triggers de WhatsApp

| Trigger | Mensaje |
|---|---|
| Registro completado | Bienvenida |
| Días 3, 7, 14, 21, 30 completados | Progreso |
| 3, 5, 7 días sin actividad | Reactivación |
| Palabras clave (ej: "estoy muy ansioso") | Link a video de Regulación Rápida en micrositio |

Horario válido: 8:00am – 8:00pm Colombia. Tono: cercano, humano, calmado, motivacional.

---

## Pendientes abiertos

| # | Pendiente | Responsable |
|---|---|---|
| 1 | ~~Lista de palabras clave~~ | ✅ Resuelto — 5 abril 2026 |
| 2 | Dominio del micrositio | Silvia |
| 3 | Data de prueba (pacientes no activos + compradores del libro) | Silvia (Módulo 2) |
| 4 | ~~Protocolo de crisis~~ | ✅ Resuelto — entra en M3 |
| 5 | ~~Canal de notificación sin keyword~~ | ✅ Resuelto — email |
| 6 | ~~Test SN → orden de días~~ | ✅ Resuelto — DEC-019 |
| 7 | ~~Recursos de emergencia~~ | ✅ Resuelto — solo Colombia |

---

## Límites del sistema (nunca sugerir ni implementar)

- Diagnósticos clínicos automatizados
- Recomendaciones terapéuticas personalizadas
- Chat conversacional con IA
- Integración con historia clínica (app.digitalipsy.com)
- Migración de datos históricos
- Modelo multi-tenant (es v2, no v1)

---

## Información del contrato

- **Valor total:** USD 1.500 (50% anticipo + 50% contra 70% de entregables)
- **Plazo:** 5 semanas desde firma + anticipo
- **Go-live objetivo:** Mediados de mayo 2026
- **Soporte post go-live:** 1 mes gratuito + hasta 2 horas de ajustes en primeros 7 días
- **Jurisdicción:** Colombia — Cámara de Comercio de Bogotá
