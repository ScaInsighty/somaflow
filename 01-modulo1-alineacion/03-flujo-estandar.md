# Flujo Estándar — SomaFlow
*Módulo 1 — Alineación Operativa*
*Versión 1.0 — Abril 2026*

---

## Flujo 1 — Adquisición y Onboarding

```
[LANDING] Test del Sistema Nervioso (público)
    ↓
[CAPTURA] Nombre + Correo → "Ver mi resultado"
    ↓
[CORREO] Estado del sistema nervioso + video recomendado según resultado
    ↓
[OFERTA] Recomendación programa Somaflow 30 días
    ↓
[COMPRA] Stripe procesa el pago
    ↓
[CORREO] Stripe envía confirmación + link al micrositio
    ↓
[REGISTRO] Usuario completa perfil en micrositio:
    nombre / género / edad (rango) / teléfono / país (opcional)
    ☑ Acepta recibir mensajes por WhatsApp
    ↓
[CUESTIONARIO] Escala 1-5 para segmentación:
    → Resultado: Regulado / Colapsado / Activado
    → Segmento: Dorsal / Simpático / Ventral
    ↓
[BD] Supabase registra usuario con todos los campos
    ↓
[WHATSAPP] n8n dispara mensaje de bienvenida (si opt-in = true)
    ↓
[ACCESO] Día 1 desbloqueado → usuario entra al programa
```

---

## Flujo 2 — Rutina Diaria (Core Loop — se repite 30 días)

```
[ACCESO] Usuario entra al micrositio → ve rutina del día X
    ↓
[DECISIÓN] ¿Responde encuesta pre?
    ├── SÍ → Registra emocional (1-5) + corporal (opción múltiple)
    └── NO → Continúa directo al video
    ↓
[VIDEO] Reproduce rutina somática del día (10-20 min, Google Drive)
    ↓
[DECISIÓN] ¿Responde encuesta post?
    ├── SÍ → Registra emocional (1-5) + corporal + señales de regulación
    └── NO → Continúa
    ↓
[LOGRO] Pantalla "¡Lo lograste!" — confirmación motivacional
    ↓
[BD] Supabase registra:
    - rutina completada = true
    - fecha_hora
    - respuestas de encuesta (si existen)
    - racha_actual + 1
    ↓
[n8n] Evalúa triggers:
    ├── ¿Es día 3, 7, 14, 21 o 30? → Mensaje de progreso
    ├── ¿Es día 30? → Mensaje de cierre + pantalla especial
    └── Reset contador de inactividad
    ↓
[AVANCE] Día siguiente desbloqueado
```

---

## Flujo 3 — Inactividad

```
[n8n] Cron job diario evalúa actividad de cada usuario
    ↓
[DECISIÓN] ¿Días sin actividad?
    ├── 3 días → Mensaje de reactivación #1
    ├── 5 días → Mensaje de reactivación #2
    ├── 7 días → Mensaje de reactivación #3
    └── +7 días → Sin más mensajes automáticos
```

---

## Flujo 4 — Regulación Rápida

```
[OPCIÓN A — Acceso directo]
Usuario entra al micrositio → sección "Regulación Rápida"
    ↓
Catálogo de videos cortos ordenados por categoría
    ↓
Selecciona y reproduce → sin encuestas

[OPCIÓN B — Vía WhatsApp]
Usuario escribe mensaje con palabra clave (ej: "estoy muy ansioso")
    ↓
n8n detecta keyword vía webhook Twilio
    ↓
Sistema responde con link al catálogo de Regulación Rápida
```

---

## Flujo 5 — Finalización del Programa

```
[DÍA 30 COMPLETADO]
    ↓
[PANTALLA DE CIERRE]
    - Reconocimiento del proceso
    - Resumen de logros (días completados, cambios emocionales)
    - Invitación a continuar
    ↓
[WHATSAPP] Mensaje de cierre de ciclo
    ↓
[OFERTA] Somaflow Continuo — suscripción mensual
    - Biblioteca de rutinas
    - Rutinas según estado emocional
    - Nuevas prácticas periódicas
```

---

## Flujo 6 — Panel de Administración (Silvia)

```
[LOGIN] Silvia accede al micrositio con rol admin
    ↓
[DASHBOARD] Ve métricas en tiempo real:
    usuarios activos / % rutinas completadas /
    adherencia semanal / cambio emocional promedio /
    cambio corporal promedio
    ↓
[ACCIONES DISPONIBLES]
    ├── Gestión de usuarios: crear / editar / ver historial / eliminar
    ├── Gestión de contenidos: subir videos y PDFs por día
    ├── Gestión de videos Regulación Rápida
    └── Exportar CSV bajo demanda
```
