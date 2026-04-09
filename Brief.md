# Brief — Somaflow
*Cliente de Insighty AI*

---

## Información General

| Campo | Detalle |
|---|---|
| **Cliente** | Silvia María Diazgranados Puente |
| **Proyecto** | SomaFlow — Sistema de Rutinas Terapéuticas vía WhatsApp |
| **Tipo de cliente** | Psicóloga / emprendedora individual |
| **Fecha de contrato** | 20 de febrero de 2026 |
| **Valor total** | USD 1.500 |
| **Plazo de ejecución** | 5 semanas desde firma + anticipo |
| **Fecha objetivo go-live** | Mediados de mayo de 2026 |
| **Contacto principal** | Silvia Diazgranados |
| **Contraparte Insighty** | Natalia García (Representante Legal) |

---

## Contexto del Negocio

Silvia es psicóloga y ha desarrollado un programa de bienestar y regulación emocional llamado **Somaflow**, un programa de 30 días estructurado en rutinas somáticas en video. Actualmente envía los videos manualmente por WhatsApp a sus pacientes, sin trazabilidad, sin automatización y sin forma de medir adherencia o progreso.

**Somaflow no es un programa clínico.** La información recolectada corresponde a autoevaluaciones de estado emocional y corporal dentro del contexto de prácticas de bienestar, no a diagnósticos clínicos ni historia médica.

---

## El Problema

- Envío manual de videos uno a uno por WhatsApp personal
- Sin visibilidad sobre quién hace las rutinas y quién no
- Sin trazabilidad de adherencia ni progreso de usuarios
- Sin automatización para acompañar a los usuarios en su práctica diaria
- Actualmente solo tiene 4 videos en YouTube; el proceso no está estructurado

---

## La Solución

Sistema integrado de 5 módulos que permite:

1. **Automatizar** el envío de rutinas y encuestas vía WhatsApp (número de negocio dedicado, no personal)
2. **Consolidar** la información en una base de datos estructurada
3. **Gestionar** contenidos y usuarios desde un micrositio administrativo
4. **Generar** análisis descriptivos con IA a partir de los resultados
5. **Escalar** el programa sin incrementar la carga operativa de Silvia

---

## Usuarios del Sistema

### Administradora
- **Silvia** (única usuaria inicial del micrositio admin)
- A futuro: posibles asistentes o colaboradores con rol de administrador

### Usuarios Finales
- **Volumen actual:** 40 pacientes activos
- **Proyección:** 200 usuarios nuevos (ver base de datos de recompra)
- **Escala futura:** entre 200 y 500 en v1; miles a futuro
- **Datos requeridos:** nombre, género, edad, correo y teléfono
- **Segmentación:** por Sistema Nervioso (Dorsal, Simpático, Ventral) y por estado en cuestionario (Regulado, Colapsado, Activado)
- **Registro:** manual por Silvia en historia clínica (app.digitalipsy.com/login)
- **Multi-programa:** sí, algunos pacientes son remitidos de psiquiatría

---

## El Producto: Programa Somaflow 30 días

- **30 rutinas/videos** para los 30 días del programa
- Videos en **formato vertical 4:3, resolución 4K, duración media 15 minutos**
- Actualmente alojados en **Google Drive** (30) y algunos en **YouTube**
- En 6 meses: se complementará con 15-30 videos nuevos
- Las rutinas son las mismas para todos, pero se busca que el usuario las perciba como personalizadas
- **Sin reglas de secuenciación** — no hay prerequisitos entre rutinas
- Cada video incluye solo el video + un PDF descargable
- **Confirmación de rutina:** como logro motivacional, no limita el acceso al contenido siguiente

---

## Flujo Operativo Deseado

### Pre-compra
```
Usuario hace Test del Sistema Nervioso (público en landing)
        ↓
Pantalla de captura de correo → "Ver mi resultado"
        ↓
Correo con estado del sistema nervioso + video recomendado
        ↓
Recomendación del programa Somaflow 30 días
```

### Post-compra
```
Compra del programa
        ↓
Correo automático de bienvenida + link al micrositio
        ↓
Registro en micrositio (nombre, edad, teléfono, correo + opt-in WhatsApp)
        ↓
Día 1 habilitado
```

### Estructura de cada día
```
[ENCUESTA PRE — opcional] 2 preguntas
        ↓
[VIDEO] Rutina somática del día (10-20 min)
        ↓
[ENCUESTA POST — opcional] 3 preguntas
        ↓
[REGISTRO] Sistema registra práctica + respuestas
        ↓
[AVANCE] Día siguiente habilitado
```

---

## Encuestas

### Pre-Rutina (2 preguntas)
**P1 — Estado emocional** (escala 1-5): Muy mal / Mal / Neutro / Bien / Muy bien
**P2 — Estado corporal** (opción múltiple): relajado / neutral / tenso / rígido / cansado / inquieto

### Post-Rutina (3 preguntas)
**P1 — Estado emocional** (escala 1-5): mismas opciones
**P2 — Estado corporal** (opción múltiple): mismas opciones
**P3 — Cambios percibidos** (selección múltiple): bostezos / suspiros / respiración más profunda / temblores suaves / sensación de frío o calor / lágrimas sin carga emocional / ninguno

> Ambas encuestas son **opcionales** — no condicionan el acceso al video.

---

## WhatsApp y Comunicación

| Elemento | Detalle |
|---|---|
| **Número** | Número de negocio dedicado a Somaflow (no personal) |
| **Opt-in** | Sí — consentimiento al registrarse al programa |
| **Envío de videos** | NO por WhatsApp — usuario accede al micrositio |
| **Triggers de progreso** | Días 3, 7, 14, 21, 30 completados |
| **Triggers de reactivación** | 3, 5 y 7 días sin actividad |
| **Trigger regulación rápida** | Palabras clave del usuario (ej: "estoy muy ansioso") |
| **Horario de envíos** | De 8am a 8pm (Colombia) |
| **Tono** | Cercano, humano, calmado, motivacional — sin lenguaje clínico |

---

## Micrositio Administrativo

| Elemento | Detalle |
|---|---|
| **Acceso inicial** | Solo Silvia como administradora |
| **Acceso futuro** | Colaboradores con rol admin |
| **Identidad visual** | Calmada, minimalista, alineada con bienestar y regulación |
| **Dispositivos** | Mobile-first; también desktop |
| **Exportación CSV** | Bajo demanda |

### Top 5 Métricas del Dashboard
1. Número de usuarios activos en el programa
2. Porcentaje de rutinas completadas por los usuarios
3. Adherencia al programa por semana
4. Cambios promedio en estado emocional antes y después de las prácticas
5. Cambios promedio en estado corporal reportado por los usuarios

---

## Análisis con IA

| Elemento | Detalle |
|---|---|
| **Insights prioritarios** | Adherencia, cambios emocional/corporal pre-post, señales de regulación somática, rutinas con mayor percepción de regulación, días con mayor abandono |
| **Nivel** | Individual y agregado por grupo |
| **Frecuencia** | Semanal o bajo demanda |
| **Formato** | Datos y gráficos + resúmenes simples en texto |

---

## Infraestructura y Tecnología

| Elemento | Detalle |
|---|---|
| **Twilio** | Crear desde cero |
| **Hosting/Cloud** | Google Cloud |
| **Dominio** | Por definir |
| **n8n** | Configurar desde cero |
| **Base de datos** | Supabase + PostgreSQL (recomendación Insighty — pendiente aprobación) |

---

## Datos, Seguridad y Regulación

| Elemento | Detalle |
|---|---|
| **Jurisdicción** | Colombia (Ley 1581 de 2012) |
| **Naturaleza de los datos** | Autoevaluaciones de bienestar — NO historia clínica |
| **Consentimiento digital** | Sí — al inicio del programa |
| **Encriptación** | Sí — en reposo y en tránsito |
| **Derecho al olvido** | Sí — eliminación de datos por usuario a solicitud |

---

## Visión a Futuro

- Escalar a empresas como beneficio de bienestar corporativo
- Modelo multi-tenant: cuentas por empresa, grupos, métricas corporativas
- Somaflow Continuo: suscripción mensual post día 30 con biblioteca de rutinas
- Capacidad v1: 200-500 usuarios; futuro: miles

---

## Estado del Proyecto

| Hito | Estado |
|---|---|
| Contrato firmado | ✅ 20 Feb 2026 |
| Anticipo recibido (50% — USD 750) | ⬜ Por confirmar |
| Inicio de Módulo 1 | ⬜ Pendiente |
| Go-live objetivo | Mediados de mayo 2026 |

---

## Ver también

[[CLAUDE|CLAUDE]] · [[PRD|PRD]] · [[Decisiones|Decisiones]] · [[Contrato|Contrato]] · [[../../Knowledge/Lecciones/silvia-somaflow|Lecciones aprendidas]] · [[../../Operaciones/clientes-index|Índice de clientes]]
