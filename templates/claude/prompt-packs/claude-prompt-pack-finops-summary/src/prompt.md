# Prompt Template — FinOps Summary

Reemplaza `{{COST_DATA}}`, `{{PERIOD_CURRENT}}`, `{{PERIOD_PREVIOUS}}` y `{{THRESHOLD_USD}}` con datos reales.

---

## Template A: CSV de costos

```
Analiza los siguientes datos de costos cloud y genera un resumen ejecutivo FinOps.

Período actual: {{PERIOD_CURRENT}}
Período anterior: {{PERIOD_PREVIOUS}}
Threshold de alerta: ${{THRESHOLD_USD}} USD

Datos de costos (formato CSV):
{{COST_DATA}}

Genera el análisis completo en el formato establecido.
```

---

## Template B: JSON de AWS Cost Explorer

```
Analiza los siguientes datos de AWS Cost Explorer y genera un resumen ejecutivo FinOps.

Período: {{PERIOD_CURRENT}}
Threshold: ${{THRESHOLD_USD}} USD

Datos:
{{COST_DATA}}

Incluye en tu análisis:
1. Top 5 servicios por costo
2. Servicios con mayor incremento porcentual
3. Servicios que podrían optimizarse (Reserved Instances, Savings Plans, rightsizing)
```

---

## Template C: Texto libre / reporte manual

```
El equipo de infraestructura reporta los siguientes costos cloud para {{PERIOD_CURRENT}}:

{{COST_DATA}}

Genera un resumen ejecutivo FinOps conciso para el management. Considera que el período anterior fue {{PERIOD_PREVIOUS}}.
```

---

## Variables

| Variable | Descripción | Ejemplo |
|---|---|---|
| `{{COST_DATA}}` | Datos de costos en CSV, JSON o texto libre | Ver fixtures/ |
| `{{PERIOD_CURRENT}}` | Período del análisis actual | `Abril 2025` |
| `{{PERIOD_PREVIOUS}}` | Período de comparación | `Marzo 2025` |
| `{{THRESHOLD_USD}}` | Threshold de alerta en USD | `2500` |

## Formato de entrada soportado

El modelo puede interpretar:
- CSV con columnas: ServiceName, TimePeriod, Amount, Unit
- JSON de AWS Cost Explorer (ResultsByTime)
- Texto libre con costos mencionados
- Tablas Markdown con breakdowns
