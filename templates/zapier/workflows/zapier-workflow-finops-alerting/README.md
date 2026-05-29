# Zapier FinOps Alerting Blueprint

**Status:** `draft` — blueprint documentado paso a paso, no un archivo importable.

> **Nota importante:** Zapier no permite exportar/importar Zaps desde archivos de configuración. Este template es un **blueprint implementable** — sigue los pasos en `src/zap.blueprint.md` para construirlo manualmente en zapier.com.

Blueprint para construir un Zap que monitorea costos cloud, detecta cuando el gasto supera un threshold y envía alertas a Slack (y email opcional) con resumen de los servicios más costosos.

## Qué hace este Zap

```
Schedule (cada lunes 8am)
    → Fetch costos via API/Webhook (AWS Cost Explorer o custom)
    → Code (JavaScript): parsea JSON, calcula total, compara threshold
    → Filter: ¿supera threshold?
    → Slack: envía alerta con breakdown de servicios
    → Email (opcional): resumen ejecutivo
```

## Para implementarlo

1. Leer `src/zap.blueprint.md` — tiene cada paso con configuración exacta
2. Seguir los 8 pasos en zapier.com
3. Para la integración con AWS Cost Explorer: requiere una Lambda Function como intermediario (ver Step 3 del blueprint)
4. Tiempo estimado de implementación: **45-90 minutos**

## Plan de Zapier requerido

Este Zap tiene 6-7 pasos → requiere **plan Starter** o superior. El plan gratuito permite máximo 2 pasos.

## Limitaciones

- No es un archivo importable (limitación de la plataforma Zapier)
- AWS Cost Explorer no tiene integración nativa en Zapier — requiere Lambda o API custom
- El snippet de JavaScript (Step 4) debe ajustarse si el formato de tu API de costos es diferente al de AWS Cost Explorer
