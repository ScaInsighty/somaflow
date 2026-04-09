# Briefing — Próxima Sesión: Módulo 3 WhatsApp

*Somaflow — Insighty AI*
*Preparado: 8 abril 2026*

---

## Qué se completó en la sesión anterior

- M1 cerrado: checklist de Silvia procesado, 6 nuevas decisiones registradas (DEC-014 a DEC-019)
- M2 completado: schema de Supabase diseñado, migración SQL aplicada exitosamente
- Stack actualizado: Twilio → Meta WhatsApp Cloud API directo
- 7 tablas activas en Supabase (ref: `ejrcgwzmrtzufwgiogfl`):
  `usuarios`, `contenidos`, `secuencias`, `progreso`, `respuestas_encuesta`, `envios_whatsapp`, `alertas_silvia`

---

## Lo primero que hay que hacer al arrancar

### 1. Completar credenciales de Meta en `.env.local`

Archivo: `somaflow-app/.env.local`

```
META_WHATSAPP_TOKEN=           ← token permanente (System User Token)
META_WHATSAPP_PHONE_NUMBER_ID= ← ID del número en Meta Business
META_WHATSAPP_WEBHOOK_VERIFY_TOKEN= ← token custom para verificar webhooks
META_WHATSAPP_BUSINESS_ACCOUNT_ID=  ← ID de la cuenta WABA
```

Dónde encontrarlos: Meta for Developers → panel de la app de WhatsApp Business.

---

## Objetivo de M3

Implementar los 10 flujos de WhatsApp en n8n conectado a Meta Cloud API.

| # | Trigger | Tipo |
|---|---|---|
| 1 | Registro completado | Bienvenida |
| 2-6 | Días 3, 7, 14, 21, 30 completados | Progreso |
| 7-9 | 3, 5, 7 días sin actividad | Reactivación |
| 10 | Palabras clave del usuario | Regulación Rápida (6 categorías) |
| 11 | Palabras clave nivel 1 ambiguo | Protocolo crisis N1 |
| 12 | Palabras clave nivel 2 alerta | Protocolo crisis N2 |
| 13 | Palabras clave nivel 3 riesgo alto | Protocolo crisis N3 |
| 14 | Sin keyword detectada | Alerta email a Silvia |

Reglas clave:
- Horario: 8:00am – 8:00pm Colombia
- Máximo 1 mensaje por usuario por día
- Después de 7 días de inactividad → no más mensajes automáticos
- Videos NO van por WhatsApp — solo links al micrositio

---

## Palabras clave por categoría (DEC-015)

| Categoría | Ejemplo de palabras |
|---|---|
| ANSIEDAD-ACTIVACIÓN | ansiedad, nervioso, pánico, estrés, rabia |
| DESBORDADO | abrumado, saturado, quiero llorar, me rindo |
| MENTE ACELERADA | no paro de pensar, rumiando, bloqueado |
| TENSIÓN CORPORAL | tensión, rígido, dolor, presión |
| CANSADO-SIN ENERGÍA | cansado, agotado, tristeza, vacío |
| SUEÑO | insomnio, no puedo dormir, desvelo |

**Protocolo crisis N3 (palabras de riesgo alto):** me quiero matar, quiero morir, no quiero vivir, quisiera desaparecer, voy a hacerme daño — mensaje estándar con líneas Colombia (106, 123, SalvaVías).

Lista completa en `PRD.md` → Módulo 3.

---

## Archivos relevantes para M3

| Archivo | Uso |
|---|---|
| `somaflow-app/.env.local` | Credenciales Meta, Supabase, Stripe, OpenAI |
| `somaflow-app/supabase/migrations/20260407000001_initial_schema.sql` | Schema de referencia (tablas `envios_whatsapp`, `alertas_silvia`) |
| `PRD.md` → Módulo 3 | Spec completa de flujos y palabras clave |
| `Decisiones.md` → DEC-015 a DEC-019 | Decisiones de alcance y reglas de negocio |

---

## Pendientes de Silvia (no bloqueantes para M3)

- Dominio del micrositio
- Data de prueba (pacientes no activos + compradores del libro) — para M2 testing
