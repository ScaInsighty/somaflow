# Reglas Operativas — SomaFlow
*Módulo 1 — Alineación Operativa*
*Versión 1.0 — Abril 2026*

---

## 1. Programa

| Regla | Definición |
|---|---|
| Duración | 30 días consecutivos |
| Contenido por día | 1 video de rutina somática (10-20 min, formato vertical 4:3, 4K) + 1 PDF descargable |
| Secuenciación | Sin prerequisitos — el usuario puede acceder al día siguiente independientemente de si completó el anterior |
| Avance | El sistema habilita el día siguiente automáticamente al completar la rutina del día |
| Confirmación de rutina | Logro motivacional — no bloquea el acceso al contenido siguiente |
| Almacenamiento de videos | Google Drive (links embebidos en el micrositio) |

---

## 2. Usuarios

| Regla | Definición |
|---|---|
| Registro | Manual por Silvia inicialmente; a futuro auto-registro vía micrositio post-compra |
| Datos obligatorios | Nombre, género, edad (rango), correo, teléfono |
| Datos opcionales | País |
| Segmentación inicial | Sistema Nervioso: Dorsal / Simpático / Ventral |
| Estado en cuestionario | Regulado / Colapsado / Activado |
| Capacidad v1 | 200-500 usuarios |
| Multi-programa | Permitido — un usuario puede tener más de un programa activo |

---

## 3. Encuestas

| Regla | Definición |
|---|---|
| Carácter | Completamente opcionales — nunca condicionan el acceso al video |
| Uniformidad | Las mismas preguntas para todos los usuarios |
| Canal de respuesta | Dentro del micrositio únicamente (no por WhatsApp) |
| Tiempo límite | Sin límite de tiempo para responder |
| Recordatorios | No se envían recordatorios de encuesta |

### Encuesta Pre-Rutina (2 preguntas)
| # | Pregunta | Tipo | Opciones |
|---|---|---|---|
| P1 | ¿Cómo está tu estado emocional ahora? | Escala 1-5 | Muy mal / Mal / Neutro / Bien / Muy bien |
| P2 | ¿Cómo se siente tu cuerpo ahora? | Opción múltiple (1 respuesta) | relajado / neutral / tenso / rígido / cansado / inquieto |

### Encuesta Post-Rutina (3 preguntas)
| # | Pregunta | Tipo | Opciones |
|---|---|---|---|
| P1 | ¿Cómo está tu estado emocional ahora? | Escala 1-5 | Muy mal / Mal / Neutro / Bien / Muy bien |
| P2 | ¿Cómo se siente tu cuerpo ahora? | Opción múltiple (1 respuesta) | relajado / neutral / tenso / rígido / cansado / inquieto |
| P3 | ¿Notaste algún cambio en tu cuerpo? | Selección múltiple | bostezos / suspiros / respiración más profunda / temblores suaves / sensación de frío o calor / lágrimas sin carga emocional / ninguno |

---

## 4. WhatsApp — Reglas de Envío

| Regla | Definición |
|---|---|
| Número | Número de negocio dedicado a Somaflow (no personal de Silvia) |
| Opt-in | Obligatorio al registrarse — sin opt-in no se envía ningún mensaje |
| Horario válido | 8:00am – 8:00pm (hora Colombia, UTC-5) |
| Frecuencia máxima | 1 mensaje por usuario por día |
| Tono | Cercano, humano, calmado, motivacional — sin lenguaje clínico, sin emojis excesivos |
| Videos por WhatsApp | Prohibido — solo se envían links al micrositio |
| Idioma | Español colombiano |

### Triggers y Mensajes

| # | Trigger | Tipo | Ejemplo de mensaje |
|---|---|---|---|
| 1 | Registro completado | Bienvenida | "Bienvenido a Somaflow. Durante los próximos 30 días vas a entrenar tu sistema nervioso..." |
| 2 | Día 3 completado | Progreso | "¡Qué alegría verte avanzar! Has completado 3 días habitando tu calma..." |
| 3 | Día 7 completado | Progreso | "¡Una semana completa! Eso es un regalo inmenso que te estás dando..." |
| 4 | Día 14 completado | Progreso | "14 días. La mitad del camino. Confía en tu proceso..." |
| 5 | Día 21 completado | Progreso | "21 días. Vas a tu propio ritmo y eso es lo más valioso..." |
| 6 | Día 30 completado | Cierre | "Hoy cerramos este ciclo de 30 días. Gracias por tu valentía..." |
| 7 | 3 días sin actividad | Reactivación | "Hola, paso por aquí para recordarte que este espacio es tuyo..." |
| 8 | 5 días sin actividad | Reactivación | "No hay prisa, solo el deseo de estar presente contigo hoy..." |
| 9 | 7 días sin actividad | Reactivación | "A veces el día va muy rápido, pero aquí tienes un refugio..." |
| 10 | Palabras clave detectadas | Regulación rápida | "Te dejo una práctica corta para ayudarte a regular tu sistema ahora." + link |

### Palabras Clave para Regulación Rápida
*Pendiente definición con Silvia* — ejemplos base:
- ansioso / ansiosa / ansiedad
- estrés / estresado / estresada
- crisis / ayuda / no puedo
- activado / activada / desbordado

---

## 5. Regulación Rápida

| Regla | Definición |
|---|---|
| Tipo de contenido | Videos cortos independientes (tipo shorts, 3-5 min) — distintos a las 30 rutinas |
| Acceso | Libre desde el micrositio en cualquier momento — sin encuestas |
| Acceso vía WhatsApp | Solo cuando se detectan palabras clave — se envía link al catálogo |
| Almacenamiento | Google Drive (mismo que rutinas) |

### Categorías
1. Bajar ansiedad rápido
2. Liberar tensión del cuerpo
3. Regular respiración
4. Descargar activación
5. Volver al cuerpo
6. Calmar antes de dormir
7. Liberar el estrés acumulado

---

## 6. Registro de Actividad

Cada vez que un usuario interactúa con el sistema, se registra:

| Campo | Descripción |
|---|---|
| usuario_id | Identificador único del usuario |
| día_programa | Número de día (1-30) |
| fecha_hora | Timestamp de la acción |
| rutina_completada | Boolean |
| respuestas_pre | JSON con respuestas de encuesta pre (si existen) |
| respuestas_post | JSON con respuestas de encuesta post (si existen) |
| racha_actual | Días consecutivos de práctica |
| trigger_whatsapp | Qué trigger se evaluó y si se disparó |

---

## 7. Métricas del Dashboard

| # | Métrica | Descripción |
|---|---|---|
| 1 | Usuarios activos | Usuarios con al menos 1 rutina en los últimos 7 días |
| 2 | % rutinas completadas | Rutinas completadas / rutinas esperadas (días transcurridos × usuarios activos) |
| 3 | Adherencia semanal | % de usuarios que practicaron al menos 3 veces en la semana |
| 4 | Cambio emocional promedio | Promedio de (post_emocional - pre_emocional) de todos los usuarios |
| 5 | Cambio corporal promedio | Frecuencia de cambio positivo en estado corporal pre vs. post |

---

## 8. Reglas de Negocio — Casos Especiales

| Caso | Regla |
|---|---|
| Usuario no responde encuesta | El sistema registra la rutina como completada sin datos de encuesta |
| Usuario salta directamente al video | Permitido — el sistema no fuerza la encuesta pre |
| Usuario completa encuesta post sin haber respondido la pre | Permitido — se registra solo la post |
| Usuario inactivo más de 7 días | Se envía el último mensaje de reactivación — no se envían más después |
| Usuario completa el día 30 | Se desbloquea pantalla de cierre + oferta Somaflow Continuo |
| Usuario escribe al bot fuera de palabras clave | Sin respuesta automática — no es un chatbot conversacional |
