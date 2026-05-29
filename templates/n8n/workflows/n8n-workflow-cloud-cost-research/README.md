# n8n Cloud Cost Research Workflow

**Status:** `draft` — workflow importable con modo CSV fixture funcional sin credenciales AWS.

Workflow de n8n que obtiene datos de costos cloud, genera un resumen ejecutivo FinOps usando un LLM y envía alertas a Slack si el gasto supera un threshold configurable.

**Modos de operación:**
- `csv_fixture`: Lee datos de un CSV local/URL (sin credenciales AWS — ideal para pruebas)
- `aws`: Llama a AWS Cost Explorer API con credenciales IAM

## Arquitectura

```
Manual Trigger | Weekly Schedule (lunes 8am)
    → Select Data Source (env: COST_DATA_MODE)
    → AWS Cost Explorer | Load CSV Fixture
    → Parse Cost Data (normalizar formato)
    → Generate LLM Summary (análisis FinOps)
    → Over Budget? (IF threshold)
        → [YES] Send Slack Alert
        → [NO]  Archive Report
    → Archive Report
```

## Variables de entorno

| Variable | Descripción | Default | Requerida |
|---|---|---|---|
| `LLM_API_KEY` | API key del LLM | — | Sí |
| `SLACK_WEBHOOK_URL` | Incoming webhook URL de Slack | — | Sí |
| `COST_DATA_MODE` | `aws` o `csv_fixture` | `csv_fixture` | No |
| `COST_ALERT_THRESHOLD` | Threshold de alerta en USD | `2000` | No |
| `AWS_ACCESS_KEY_ID` | AWS Access Key (solo modo aws) | — | Solo aws |
| `AWS_SECRET_ACCESS_KEY` | AWS Secret Key (solo modo aws) | — | Solo aws |
| `CSV_FIXTURE_URL` | URL del CSV de costos | URL del repo | No |
| `LLM_MODEL` | Modelo LLM | `claude-sonnet-4-6` | No |
| `LLM_API_URL` | URL del LLM | Anthropic API | No |

## Setup rápido (modo CSV fixture)

### 1. Importar workflow
```
n8n → Workflows → + → Import from file → src/workflow.json
```

### 2. Configurar variables mínimas
En n8n Settings → Environment Variables:
```
LLM_API_KEY=sk-ant-...
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/T.../B.../...
COST_DATA_MODE=csv_fixture
COST_ALERT_THRESHOLD=2500
```

### 3. Ejecutar manualmente
Hacer clic en **Execute Workflow** en el nodo "Manual Trigger".

El workflow leerá el CSV de fixtures del repo, generará el análisis y enviará el reporte a Slack.

---

## Setup con AWS Cost Explorer

### IAM Policy mínima (solo lectura)

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ce:GetCostAndUsage",
        "ce:GetCostForecast",
        "ce:GetDimensionValues"
      ],
      "Resource": "*"
    }
  ]
}
```

### Credenciales AWS en n8n

Opción A — Variables de entorno:
```
COST_DATA_MODE=aws
AWS_ACCESS_KEY_ID=AKIA...
AWS_SECRET_ACCESS_KEY=...
```

> El nodo "AWS Cost Explorer" necesita firma SigV4. Para simplificar, considera usar el nodo `n8n-nodes-aws` si está disponible, o configurar credenciales HTTP nativas con SigV4.
> Para una implementación más robusta en producción, usa AWS Lambda + n8n HTTP Request.

## Fixture de prueba incluida

El archivo `src/fixtures/costs-dummy.csv` contiene datos reales de formato (valores ficticios) para abril y marzo 2025. Cubre:
- EC2, RDS, S3, Lambda, CloudFront, EKS, ElastiCache, Secrets Manager, Route53, Data Transfer

Para usar tu propio CSV, establece `CSV_FIXTURE_URL` a la URL de tu archivo.

**Formato esperado del CSV:**
```csv
ServiceName,TimePeriod,Amount,Unit,Currency
Amazon EC2,2025-04-01/2025-04-30,1245.78,USD,ACTUAL
```

## Resumen LLM generado

El LLM produce un análisis con estas secciones:
1. **Resumen ejecutivo** (3 oraciones)
2. **Anomalías detectadas** (comparación vs período anterior)
3. **Hipótesis de causas**
4. **Acciones recomendadas** (por impacto)
5. **Riesgos si no se actúa**

## Limitaciones conocidas

- La integración AWS Cost Explorer usa HTTP Request básico sin SigV4. En producción, usar credenciales configuradas en n8n o AWS Lambda como intermediario.
- El análisis LLM no tiene acceso a etiquetas de recursos (tags) ni breakdown por cuenta.
- Status `draft`: el modo CSV fue probado estructuralmente; el modo AWS requiere validación con credenciales reales.
