# Claude FinOps Summary Prompt Pack

**Status:** `draft` — prompts revisados y con ejemplos probados manualmente. Directamente usables.

Pack de prompts para analizar costos cloud y generar resúmenes ejecutivos FinOps con Claude. El asistente produce análisis estructurado con anomalías detectadas, hipótesis de causas, acciones recomendadas priorizadas y riesgos.

## Archivos

| Archivo | Descripción |
|---|---|
| `src/system-prompt.md` | System prompt del analista FinOps |
| `src/prompt.md` | 3 templates de prompt (CSV, JSON, texto libre) |
| `src/examples.md` | 3 ejemplos completos con respuestas esperadas |
| `src/evals.md` | Criterios de evaluación (5 dimensiones) |
| `src/fixtures/costs-sample.csv` | CSV de costos dummy para pruebas |

## Uso rápido

### En Claude.ai (más simple)

1. Abrir Claude.ai → nueva conversación
2. En Projects, configurar el system prompt con el contenido de `src/system-prompt.md`
3. Enviar el siguiente mensaje:

```
Analiza los siguientes costos cloud y genera un resumen ejecutivo FinOps.

Período actual: Abril 2025
Período anterior: Marzo 2025
Threshold de alerta: $2000 USD

Datos CSV:
ServiceName,TimePeriod,Amount,Unit,Currency
Amazon EC2,2025-04-01/2025-04-30,1245.78,USD,ACTUAL
Amazon RDS,2025-04-01/2025-04-30,432.10,USD,ACTUAL
Amazon EKS,2025-04-01/2025-04-30,567.90,USD,ACTUAL
Amazon S3,2025-04-01/2025-04-30,87.34,USD,ACTUAL
AWS Lambda,2025-04-01/2025-04-30,12.45,USD,ACTUAL
```

### Via Anthropic API (Python)

```python
import anthropic
from pathlib import Path

client = anthropic.Anthropic(api_key="sk-ant-...")
system_prompt = Path("src/system-prompt.md").read_text()
cost_data = Path("src/fixtures/costs-sample.csv").read_text()

response = client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=2000,
    system=system_prompt,
    messages=[{
        "role": "user",
        "content": f"""Analiza los siguientes datos de costos cloud.

Período actual: Abril 2025
Período anterior: Marzo 2025
Threshold de alerta: $2000 USD

Datos CSV:
{cost_data}
"""
    }]
)

print(response.content[0].text)
```

## Formatos de entrada soportados

### CSV (recomendado)
Exportar directamente desde AWS Cost Explorer → Cost & Usage → Download CSV.
```csv
ServiceName,TimePeriod,Amount,Unit,Currency
Amazon EC2,2025-04-01/2025-04-30,1245.78,USD,ACTUAL
```

### Texto libre
Para análisis rápidos sin datos estructurados:
```
EC2: $1,200, RDS: $400, S3: $90
Total: $1,690 USD. Mes anterior: $1,450 USD.
```

### JSON (AWS Cost Explorer API)
El modelo puede interpretar la respuesta directa de `ce:GetCostAndUsage`.

## Output esperado

El análisis incluye 6 secciones fijas:
1. **📊 Resumen Ejecutivo** — 2-3 oraciones con total y variación
2. **⚠️ Anomalías Detectadas** — tabla de variaciones por servicio
3. **🔍 Hipótesis de Causas** — análisis causal basado en datos
4. **🎯 Acciones Recomendadas** — priorizadas por impacto (ALTA/MEDIA/BAJA)
5. **🚨 Riesgos si no se actúa** — proyección de consecuencias
6. **📋 Datos de entrada utilizados** — confirma qué datos se analizaron

## Combinación con n8n

Este prompt pack se complementa con `n8n-workflow-cloud-cost-research`:
- El workflow n8n obtiene los datos de AWS Cost Explorer o CSV
- Llama a la API de Claude con este system prompt y los datos
- Envía el resultado a Slack

## Limitaciones

- El modelo no tiene acceso a datos en tiempo real de AWS.
- Para análisis muy granulares (por account, por tag, por AZ), el CSV de entrada debe incluir esas dimensiones.
- La aritmética del LLM puede tener errores en tablas muy grandes — verifica los totales automáticamente en producción.
