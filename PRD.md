# PRD — SomaFlow
*Product Requirements Document — Insighty AI*
*Versión 1.1 — Abril 2026*

---

## 1. Resumen Ejecutivo

SomaFlow es un sistema de automatización de rutinas somáticas y encuestas de bienestar para el programa de 30 días de Silvia Diazgranados. El sistema debe permitir que los usuarios accedan a sus rutinas diarias de video, completen encuestas opcionales pre y post práctica, reciban mensajes de acompañamiento por WhatsApp, y que Silvia pueda administrar todo desde un micrositio y obtener análisis descriptivos de adherencia y progreso.

**Naturaleza del producto:** Plataforma de bienestar — NO sistema clínico.

---

## 2. Objetivos del Producto

1. Eliminar el envío manual de videos por WhatsApp personal
2. Dar trazabilidad completa de quién hace qué rutina y cuándo
3. Recolectar datos de estado emocional y corporal pre y post práctica (opcional)
4. Automatizar mensajes de motivación, refuerzo y acompañamiento por WhatsApp
5. Permitir a Silvia administrar usuarios, contenidos y encuestas de forma autónoma
6. Generar insights descriptivos sobre adherencia y patrones de bienestar
7. Escalar a 200-500 usuarios sin incrementar carga operativa

---

## 3. Usuarios

### 3.1 Administradora (Silvia)
- Gestiona usuarios, contenidos, encuestas y envíos desde el micrositio
- Ve métricas y exporta reportes
- Usuario único inicial; en el futuro colaboradores con rol admin

### 3.2 Usuario Final
- Compra el programa de 30 días vía Stripe
- Accede al micrositio desde su celular (mobile-first)
- Realiza la rutina del día en video
- Responde encuestas opcionales pre y post práctica
- Recibe mensajes de WhatsApp de acompañamiento
- Puede acceder a "Regulación Rápida" en cualquier momento

**Datos requeridos:** nombre, edad (rango: 18-25, 26-35, 36-45, 46-55, 56+), correo, teléfono, país (opcional)
**Segmentación:** Sistema Nervioso (Dorsal / Simpático / Ventral) + estado cuestionario (Regulado / Colapsado / Activado)

---

## 4. Flujo Principal del Sistema

### 4.1 Flujo de Adquisición (Pre-compra)

```
[LANDING] Usuario hace Test del Sistema Nervioso (público)
    ↓
[CAPTURA] Pantalla de correo: "Tu sistema nervioso ya tiene un resultado."
    Campos: Nombre + Correo → Botón "Ver mi resultado"
    ↓
[CORREO] Usuario recibe su estado del sistema nervioso + video según resultado
    ↓
[OFERTA] Se recomienda el programa Somaflow 30 días
```

### 4.2 Flujo Post-Compra

```
[COMPRA] Usuario adquiere programa Somaflow 30 días vía Stripe
    ↓
[CORREO AUTOMÁTICO] Confirmación enviada por Stripe:
    - Bienvenida a Somaflow
    - Link de acceso al micrositio
    - Instrucciones básicas + duración (30 días)
    ↓
[REGISTRO EN MICROSITIO]
    - Nombre, edad (rango), teléfono, país (opcional), correo
    - Fecha inicio programa
    - Acepta recibir mensajes por WhatsApp
    ↓
[INICIO] Sistema registra fecha de inicio → Día 1 habilitado
```

### 4.3 Estructura de Cada Día (igual para los 30 días)

```
[PASO 1 — ENCUESTA PRE — opcional]
    P1: ¿Cómo está tu estado emocional ahora? (Escala 1-5)
    P2: ¿Cómo se siente tu cuerpo ahora? (opción múltiple)
    ↓
[PASO 2 — RUTINA DEL DÍA]
    Video somático (10-20 minutos)
    ↓
[PASO 3 — ENCUESTA POST — opcional]
    P1: ¿Cómo está tu estado emocional ahora? (Escala 1-5)
    P2: ¿Cómo se siente tu cuerpo ahora? (opción múltiple)
    P3: ¿Notaste algún cambio en tu cuerpo? (selección múltiple)
    ↓
[REGISTRO] Sistema registra: rutina completada + tiempo + cambios emocional/corporal
    ↓
[AVANCE] Día completado → Día siguiente habilitado
```

### 4.4 Finalización y Continuidad

```
[DÍA 30 COMPLETADO]
    ↓
[PANTALLA DE CIERRE]
    - Reconocimiento del proceso
    - Reflexión sobre cambios
    - Invitación a continuar
    ↓
[OFERTA] Somaflow Continuo (suscripción mensual):
    - Biblioteca de rutinas
    - Rutinas según estado emocional
    - Nuevas prácticas periódicas
```

---

## 5. Requerimientos Funcionales por Módulo

### Módulo 1 — Alineación Operativa y Reglas

**Entregable:** Documento de especificación funcional aprobado

Reglas a definir:
- Estructura de los 30 días del programa (una rutina por día)
- Lógica de encuestas pre y post (opcionales, sin condicionar acceso al video)
- Estructura mínima de base de datos
- Lógica de triggers de WhatsApp (progreso e inactividad)
- Definición de métricas del dashboard
- Criterios de "Regulación Rápida" (palabras clave que activan mensaje por WhatsApp)

**Criterio de aceptación:** Documento aprobado por Silvia con reglas claras y sin campos pendientes.

---

### Módulo 2 — Diseño de Arquitectura y Estructura de Datos

**Entregable:** Modelo de datos documentado + migraciones SQL listas en `somaflow-app/supabase/migrations/`

Stack confirmado: **Supabase + PostgreSQL**

#### Modelo de datos

##### `usuarios`
| Campo | Tipo | Notas |
|---|---|---|
| id | uuid PK | generado por Supabase Auth |
| nombre | text | |
| correo | text UNIQUE | |
| telefono | text | para WhatsApp |
| edad_rango | enum | 18-25, 26-35, 36-45, 46-55, 56+ |
| pais | text nullable | opcional |
| fecha_registro | timestamptz | |
| fecha_inicio_programa | date nullable | se setea al completar onboarding |
| segmento_sn | enum | dorsal, simpatico, ventral — resultado del test |
| estado_cuestionario | enum | regulado, colapsado, activado |
| opt_in_whatsapp | boolean | default false |
| activo | boolean | default true — soft delete |

##### `contenidos`
| Campo | Tipo | Notas |
|---|---|---|
| id | uuid PK | |
| titulo | text | |
| url_video_drive | text | link Google Drive |
| url_pdf | text nullable | |
| duracion_minutos | int | |
| tipo | enum | rutina_30dias, regulacion_rapida |
| categoria_rr | enum nullable | ansiedad_activacion, desbordado, mente_acelerada, tension_corporal, cansado_sin_energia, sueno, volver_al_presente — solo cuando tipo = regulacion_rapida |
| activo | boolean | default true |
| created_at | timestamptz | |

##### `secuencias` (tabla clave para personalización por SN)
| Campo | Tipo | Notas |
|---|---|---|
| id | uuid PK | |
| segmento_sn | enum | dorsal, simpatico, ventral |
| posicion | int | 1-30 — posición en el programa para este segmento |
| contenido_id | uuid FK → contenidos | |
| UNIQUE | (segmento_sn, posicion) | un video por posición por segmento |
| UNIQUE | (segmento_sn, contenido_id) | un video aparece una sola vez por segmento |

Silvia define las 3 secuencias desde el panel de administración. El video que un usuario ve en "Día N" es `secuencias(segmento_sn=usuario.segmento_sn, posicion=N).contenido_id`.

##### `progreso`
| Campo | Tipo | Notas |
|---|---|---|
| id | uuid PK | |
| usuario_id | uuid FK → usuarios | |
| posicion_programa | int | 1-30 — posición en la secuencia del usuario |
| contenido_id | uuid FK → contenidos | qué video vio |
| fecha_practica | date | |
| completado | boolean | default false |
| created_at | timestamptz | |
| UNIQUE | (usuario_id, posicion_programa) | |

##### `respuestas_encuesta`
| Campo | Tipo | Notas |
|---|---|---|
| id | uuid PK | |
| usuario_id | uuid FK → usuarios | |
| progreso_id | uuid FK → progreso nullable | null si es encuesta pre-compra (test SN) |
| tipo | enum | pre, post, pre_compra |
| respuestas_json | jsonb | estructura flexible por tipo de encuesta |
| fecha | timestamptz | |

##### `envios_whatsapp`
| Campo | Tipo | Notas |
|---|---|---|
| id | uuid PK | |
| usuario_id | uuid FK → usuarios | |
| tipo_mensaje | enum | bienvenida, progreso, reactivacion, regulacion_rapida, protocolo_crisis_n1, protocolo_crisis_n2, protocolo_crisis_n3, alerta_interna |
| estado | enum | pendiente, enviado, fallido |
| fecha_envio | timestamptz nullable | |
| metadata_json | jsonb nullable | keyword detectada, nivel de crisis, etc. |
| created_at | timestamptz | |

##### `alertas_silvia`
| Campo | Tipo | Notas |
|---|---|---|
| id | uuid PK | |
| usuario_id | uuid FK → usuarios | |
| mensaje_usuario | text | texto exacto que escribió el usuario |
| fecha | timestamptz | |
| revisado | boolean | default false |
| created_at | timestamptz | |

Cuando no se detecta keyword, n8n inserta aquí y dispara email a Silvia.

#### Índices
- `progreso(usuario_id, posicion_programa)` — consulta frecuente "¿en qué día va el usuario?"
- `envios_whatsapp(usuario_id, tipo_mensaje, fecha_envio)` — evita duplicar mensajes
- `alertas_silvia(revisado, created_at)` — para que Silvia filtre pendientes

#### Seguridad y compliance
- RLS en Supabase: usuarios solo acceden a sus propios datos
- Soft delete en `usuarios.activo` — no borrado físico (Ley 1581 Colombia)
- Encriptación en reposo: Supabase default

Consideraciones:
- Capacidad inicial: 200-500 usuarios; diseño escalable
- Data de prueba: Silvia proveerá pacientes no activos + compradores del libro (Módulo 2)

---

### Módulo 3 — Implementación de Automatización WhatsApp

**Entregable:** Flujos n8n activos en prueba y producción + registro de envíos

| # | Trigger | Tipo de mensaje |
|---|---|---|
| 1 | Registro completado | Bienvenida al programa |
| 2 | Día 3 completado | Progreso |
| 3 | Día 7 completado | Progreso |
| 4 | Día 14 completado | Progreso |
| 5 | Día 21 completado | Progreso |
| 6 | Día 30 completado | Cierre de ciclo |
| 7 | 3 días sin actividad | Reactivación |
| 8 | 5 días sin actividad | Reactivación |
| 9 | 7 días sin actividad | Reactivación |
| 10 | Palabras clave del usuario | Link a video de Regulación Rápida en micrositio |

Configuración:
- Número de negocio dedicado a Somaflow vía Meta WhatsApp Cloud API
- Opt-in obligatorio al registrarse
- Horario: 8:00am – 8:00pm (Colombia)
- Tono: cercano, humano, calmado, motivacional
- Videos NO se envían por WhatsApp — se envía link al micrositio

#### Palabras clave por categoría (definidas por Silvia, 5 abril 2026)

| Categoría | Palabras clave |
|---|---|
| 🔴 ANSIEDAD-ACTIVACIÓN | ansiedad, ansioso, nervioso, acelerado, inquieto, no puedo parar, taquicardia, ataque de ansiedad, pánico, angustia, nervios, preocupado, preocupación, inquietud, rabia, enojo, ira, furia, frustración, irritabilidad, agresividad, inseguro, estresado, estrés |
| 🟠 DESBORDADO | abrumado, sobrepasado, saturado, colapsado, no doy más, todo es mucho, quiero llorar, me rindo, pierdo el control |
| 🔵 MENTE ACELERADA | no paro de pensar, mi mente no para, rumiando, sobrepensando, pensamientos, no puedo apagar la mente, confundido, perdido, bloqueado, saturado, no me puedo concentrar, me voy por las ramas, no puedo enfocarme, tengo mil cosas en la cabeza, no sé por donde empezar |
| 🟡 TENSIÓN CORPORAL | tensión, rígido, dolor, presión |
| ⚫ CANSADO-SIN ENERGÍA | cansado, agotado, drenado, sin energía, apagado, pesado, no tengo ganas, tristeza, desánimo, vacío, soledad, melancolía, no quiero hacer nada, adormecido, entumecido, plana, sin motivación |
| 🌙 SUEÑO | no puedo dormir, insomnio, dormir, no descanso, quiero dormir, desvelo, duermo mal |

#### Protocolo de seguridad — detección de riesgo emocional grave (⬜ pendiente de aprobación de scope)

Silvia solicitó que el bot detecte situaciones de riesgo emocional con 3 niveles:

| Nivel | Descripción | Respuesta del bot |
|---|---|---|
| 🟡 Nivel 1 — Malestar ambiguo | "no puedo más", "estoy muy mal", "todo es demasiado" | Pregunta cómo se siente el cuerpo → redirige a categoría de Regulación Rápida |
| 🟠 Nivel 2 — Alerta implícita | "no quiero seguir", "quisiera desaparecer", "ojalá no despertarme" | Mensaje de contención + recursos de apoyo + link rutina Volver al Presente |
| 🔴 Nivel 3 — Riesgo alto explícito | "me quiero matar", "quiero morir", "no quiero vivir" | Mensaje estándar con líneas de emergencia Colombia (106, 123, SalvaVías) |

Notas:
- Las palabras clave de Nivel 2 y 3 tienen prioridad sobre las categorías normales
- Líneas de emergencia contempladas: Colombia (Línea 106, WhatsApp 300 754 8933; Línea 123; SalvaVías, WhatsApp 311 270 8186)
- **Pendiente de decisión:** ¿se incluyen recursos por país o solo Colombia en v1?
- **Pendiente de scope:** este protocolo es requerimiento nuevo — definir si entra en M3 o se cotiza aparte

#### Alerta a Silvia para mensajes sin keyword (⬜ pendiente de decisión de canal)

Cuando un usuario escribe libremente y el bot no detecta ninguna palabra clave → enviar notificación a Silvia para que revise el mensaje directamente.

**Pendiente de decisión:** canal de notificación (email o WhatsApp personal de Silvia).

**Criterio de aceptación:** Pruebas exitosas de envíos programados con registro correcto.

---

### Módulo 4 — Desarrollo del Micrositio de Administración

**Entregable:** Aplicación web operativa + manual de usuario

#### Vista Usuario Final (mobile-first)
- Landing page con Test del Sistema Nervioso (público)
- Captura de correo + envío de resultado por email
- Pantalla principal: rutina del día con acceso directo al video
- Encuesta pre-rutina (opcional, saltable)
- Reproductor / link al video de práctica
- Encuesta post-rutina (opcional, saltable)
- Confirmación de práctica completada (logro motivacional)
- Sección "Regulación Rápida": videos cortos independientes (tipo shorts), acceso libre
- Historial de progreso personal

#### Categorías de Regulación Rápida
- ANSIEDAD-ACTIVACIÓN
- DESBORDADO
- MENTE ACELERADA
- TENSIÓN CORPORAL
- CANSADO-SIN ENERGÍA
- SUEÑO
- VOLVER AL PRESENTE

#### Vista Administración (Silvia)
- **Dashboard** con top 5 métricas
- **Gestión de usuarios:** crear, editar, ver historial, eliminar
- **Gestión de contenidos:** subir/editar videos y PDFs por día + videos de Regulación Rápida
- **Gestión de encuestas:** ver y editar encuestas pre y post
- **Exportación CSV:** bajo demanda

**Identidad visual:** calmada, minimalista, alineada con bienestar y regulación
**Criterio de aceptación:** Operación autónoma sin soporte técnico.

---

### Módulo 5 — Análisis con IA, QA y Salida a Producción

**Entregable:** Reportes descriptivos automáticos + evidencia de pruebas + acta de go-live

Insights a generar:
1. Adherencia al programa (individual y grupal)
2. Cambios promedio en estado emocional pre vs. post rutina
3. Cambios promedio en estado corporal pre vs. post rutina
4. Frecuencia de señales de regulación somática reportadas
5. Rutinas que generan mayor percepción de regulación
6. Días del programa con mayor abandono

Formato: datos y gráficos + resúmenes simples en texto — semanal o bajo demanda

Limitaciones:
- NO diagnósticos clínicos automatizados
- NO recomendaciones terapéuticas personalizadas

**Criterio de aceptación:** Generación automática de reportes descriptivos con datos reales.

---

## 6. Requerimientos No Funcionales

| Requerimiento | Especificación |
|---|---|
| **Seguridad** | Encriptación en reposo y en tránsito |
| **Privacidad** | Cumplimiento Ley 1581 de 2012 (Colombia) |
| **Derecho al olvido** | Eliminación de datos por usuario a solicitud |
| **Capacidad v1** | 200-500 usuarios |
| **Escalabilidad** | Arquitectura preparada para miles + multi-tenant futuro |
| **Mobile-first** | Interfaz optimizada para celular |
| **Desktop** | También funcional |
| **Consentimiento** | Opt-in WhatsApp obligatorio al registrarse |

---

## 7. Fuera de Alcance (v1)

- Chat conversacional con IA
- Diagnósticos clínicos automatizados
- Integración con historia clínica (app.digitalipsy.com)
- Integración con Google Calendar u otros sistemas externos
- Dashboard de visualización avanzada
- Migración de datos históricos
- Modelo multi-tenant (planeado para v2)
- Soporte mensual continuo (se cotiza aparte)

---

## 8. Preguntas Abiertas / Pendientes

| # | Pregunta | Responsable | Estado |
|---|---|---|---|
| 1 | ¿Cuál es la lista de palabras clave que disparan Regulación Rápida por WhatsApp? | Silvia | ✅ Resuelto — 5 abril 2026 |
| 2 | ¿Cuál será el dominio del micrositio? | Silvia | ⬜ Pendiente |
| 3 | Data de prueba (pacientes no activos + compradores del libro) | Silvia | ⬜ Pendiente para Módulo 2 |
| 4 | Protocolo de crisis WhatsApp: ¿entra en M3 o se cotiza aparte? | Insighty + Silvia | ✅ Resuelto — entra en M3 |
| 5 | Canal de notificación a Silvia para mensajes sin keyword: ¿email o WhatsApp? | Silvia | ✅ Resuelto — email |
| 6 | Test del Sistema Nervioso → mismos 30 videos, 3 órdenes distintos (Dorsal / Simpático / Ventral), Silvia define manualmente | Silvia | ✅ Resuelto — ver DEC-019 |
| 7 | Recursos de emergencia en protocolo de crisis: ¿solo Colombia o multipaís en v1? | Silvia | ✅ Resuelto — solo Colombia |
