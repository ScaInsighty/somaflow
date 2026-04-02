# Decisiones — Somaflow
*Registro de decisiones técnicas y de negocio tomadas durante el proyecto*

---

## Formato

Cada decisión incluye: fecha, contexto, decisión tomada, razón y quién la tomó.

---

## Decisiones Registradas

### DEC-001 — Las encuestas son opcionales y no condicionan el acceso al video
- **Fecha:** Marzo 2026
- **Contexto:** Se evaluó si las encuestas pre y post rutina debían ser obligatorias para acceder al video siguiente.
- **Decisión:** Las encuestas son completamente opcionales. El usuario puede saltarlas y acceder directamente a la práctica.
- **Razón:** Silvia no quiere que el sistema sea condicionante ni que canse al usuario.
- **Estado:** ✅ Confirmado
- **Quién:** Silvia Diazgranados

---

### DEC-002 — Los videos NO se envían por WhatsApp
- **Fecha:** Marzo 2026
- **Contexto:** Se evaluó si los videos debían adjuntarse o enviarse por WhatsApp directamente.
- **Decisión:** Los videos se alojan en el micrositio. WhatsApp se usa exclusivamente para mensajes de texto y links.
- **Razón:** Enviar videos por WhatsApp aumentaría el costo de Twilio y la experiencia es mejor en el micrositio.
- **Estado:** ✅ Confirmado
- **Quién:** Silvia Diazgranados

---

### DEC-003 — Número de negocio dedicado (no el personal de Silvia)
- **Fecha:** Marzo 2026
- **Decisión:** Número de negocio dedicado exclusivamente al programa Somaflow.
- **Razón:** Escalabilidad, profesionalismo y separación del uso personal.
- **Estado:** ✅ Confirmado
- **Quién:** Silvia Diazgranados

---

### DEC-004 — Mobile-first como prioridad de diseño
- **Fecha:** Marzo 2026
- **Decisión:** Mobile-first. La mayoría de usuarios accederán desde su celular.
- **Estado:** ✅ Confirmado
- **Quién:** Silvia Diazgranados

---

### DEC-005 — Somaflow es un programa de bienestar, NO clínico
- **Fecha:** Marzo 2026
- **Decisión:** SomaFlow se clasifica como plataforma de bienestar. Los datos recolectados son autoevaluaciones, no historia clínica.
- **Razón:** Reduce exigencias regulatorias bajo Ley 1581.
- **Estado:** ✅ Confirmado
- **Quién:** Silvia Diazgranados + Insighty AI

---

### DEC-006 — Respuestas de encuestas dentro del micrositio (no por WhatsApp)
- **Fecha:** Marzo 2026
- **Decisión:** Las respuestas se recopilan dentro del micrositio.
- **Razón:** WhatsApp como canal de encuesta aumentaría el volumen de mensajes y la complejidad.
- **Estado:** ✅ Confirmado
- **Quién:** Silvia Diazgranados

---

### DEC-007 — Hosting en Google Cloud
- **Fecha:** Marzo 2026
- **Decisión:** Google Cloud como proveedor de hosting.
- **Estado:** ✅ Confirmado
- **Quién:** Silvia Diazgranados

---

### DEC-008 — Base de datos: Supabase + PostgreSQL
- **Fecha:** Abril 2026
- **Contexto:** Silvia no tenía preferencia y solicitó recomendación. Viene de gestionar datos en Excel/Google Sheets.
- **Decisión:** Supabase + PostgreSQL.
- **Razón:** Interfaz visual tipo tabla familiar para Silvia, API integrada, compatible con Google Cloud, eficiente en costos para v1.
- **Estado:** ✅ Confirmado
- **Quién:** Insighty AI (recomienda) / Equipo (confirma)

---

### DEC-009 — Micrositio desarrollado a medida (no Mighty Networks)
- **Fecha:** Abril 2026
- **Contexto:** Silvia mencionó Mighty Networks como referencia. Se evaluó si usar esa plataforma o desarrollar a medida.
- **Decisión:** Micrositio a medida por el equipo Insighty.
- **Razón:** El contrato describe desarrollo propio. Mighty Networks limitaría la integración con n8n, encuestas y WhatsApp.
- **Estado:** ✅ Confirmado
- **Quién:** Insighty AI

---

### DEC-010 — Plataforma de pagos: Stripe
- **Fecha:** Abril 2026
- **Decisión:** Stripe como plataforma de pagos para la compra del programa.
- **Razón:** Definición del equipo Insighty.
- **Estado:** ✅ Confirmado
- **Quién:** Insighty AI

---

### DEC-011 — Landing + Test del Sistema Nervioso dentro del alcance
- **Fecha:** Abril 2026
- **Decisión:** El landing page con el test público del sistema nervioso está dentro del alcance del contrato — Insighty lo desarrolla.
- **Estado:** ✅ Confirmado
- **Quién:** Insighty AI

---

### DEC-012 — Regulación Rápida: videos cortos independientes, acceso libre en micrositio
- **Fecha:** Abril 2026
- **Decisión:** Videos cortos propios (tipo shorts), distintos a las 30 rutinas. Disponibles en el micrositio con acceso libre. No se disparan automáticamente por WhatsApp — WhatsApp solo envía el link cuando el usuario escribe palabras clave.
- **Estado:** ✅ Confirmado
- **Quién:** Insighty AI

---

### DEC-013 — Correo de confirmación de compra lo envía Stripe
- **Fecha:** Abril 2026
- **Decisión:** El correo de confirmación de compra y bienvenida lo gestiona Stripe nativamente. Insighty no construye este componente.
- **Razón:** Stripe maneja esto de forma nativa, evita duplicar esfuerzo de desarrollo.
- **Estado:** ✅ Confirmado
- **Quién:** Insighty AI
