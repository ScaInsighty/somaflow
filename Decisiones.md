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

---

### DEC-014 — Categorías de Regulación Rápida renombradas
- **Fecha:** 5 abril 2026
- **Contexto:** El PRD original usaba nombres descriptivos genéricos para las 7 categorías. Silvia revisó el checklist de M1 y los renombró con nombres más alineados a la experiencia del usuario.
- **Decisión:** Las categorías son: ANSIEDAD-ACTIVACIÓN / DESBORDADO / MENTE ACELERADA / TENSIÓN CORPORAL / CANSADO-SIN ENERGÍA / SUEÑO / VOLVER AL PRESENTE.
- **Estado:** ✅ Confirmado
- **Quién:** Silvia Diazgranados

---

### DEC-019 — Test del Sistema Nervioso determina el orden de presentación de los 30 videos
- **Fecha:** Abril 2026
- **Contexto:** Silvia mencionó en el checklist de M1 que la presentación de los días debía ser personalizada según el resultado del test.
- **Decisión:** Los 30 videos de rutina son los mismos para todos los usuarios. El resultado del test (Dorsal / Simpático / Ventral) determina el orden en que se presentan. Silvia define manualmente las 3 secuencias (una por tipo de SN). Se implementa mediante una tabla `secuencias` en la base de datos.
- **Estado:** ✅ Confirmado
- **Quién:** Silvia Diazgranados + Insighty AI
- **Impacto:** Requiere tabla adicional `secuencias` en el modelo de datos. La tabla `contenidos` no tiene campo `día_programa` fijo.

---

### DEC-018 — Alerta a Silvia para mensajes sin keyword: canal email
- **Fecha:** Abril 2026
- **Contexto:** Silvia solicitó ser notificada cuando un usuario escriba al bot y no se detecte ninguna palabra clave, para no dejar el mensaje ignorado.
- **Decisión:** Se registra el mensaje en tabla `alertas_silvia` y se envía notificación por email a Silvia.
- **Estado:** ✅ Confirmado
- **Quién:** Santiago Ciurlo (confirma canal)

---

### DEC-017 — Protocolo de crisis WhatsApp incluido en M3; recursos solo Colombia
- **Fecha:** Abril 2026
- **Contexto:** Silvia solicitó detección de riesgo emocional grave en el bot de WhatsApp con 3 niveles de respuesta.
- **Decisión:** El protocolo entra dentro del alcance de M3 sin costo adicional. Los recursos de emergencia son solo para Colombia en v1 (Línea 106, 123, SalvaVías). No se pregunta por país al usuario.
- **Estado:** ✅ Confirmado
- **Quién:** Santiago Ciurlo (confirma scope y alcance geográfico)

---

### DEC-016 — Twilio reemplazado por Meta WhatsApp Cloud API
- **Fecha:** Abril 2026
- **Contexto:** El stack original contemplaba Twilio como intermediario para WhatsApp. Se evaluó el costo operativo.
- **Decisión:** Se descarta Twilio. Se usa Meta WhatsApp Cloud API directo, integrado con n8n.
- **Razón:** Costo — Twilio cobra por mensaje enviado sobre el costo de Meta. Usar Meta directo elimina el intermediario y reduce costos operativos a escala.
- **Estado:** ✅ Confirmado
- **Quién:** Insighty AI (recomienda) / Santiago Ciurlo (confirma)
- **Impacto:** `.env.local` actualizado con variables META_WHATSAPP_*. DEC-003 (número de negocio dedicado) no cambia — solo cambia el proveedor técnico.

---

### DEC-015 — Lista de palabras clave por categoría definida
- **Fecha:** 5 abril 2026
- **Contexto:** Las palabras clave que disparan mensajes de Regulación Rápida por WhatsApp estaban pendientes desde el inicio del proyecto.
- **Decisión:** Silvia entregó la lista completa con +60 palabras/frases distribuidas en 6 categorías activas (ANSIEDAD-ACTIVACIÓN, DESBORDADO, MENTE ACELERADA, TENSIÓN CORPORAL, CANSADO-SIN ENERGÍA, SUEÑO). La categoría VOLVER AL PRESENTE se reserva para el protocolo de seguridad. Lista completa documentada en PRD.md, sección Módulo 3.
- **Estado:** ✅ Confirmado
- **Quién:** Silvia Diazgranados
