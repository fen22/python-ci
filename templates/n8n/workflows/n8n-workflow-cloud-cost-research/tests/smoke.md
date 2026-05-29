# Smoke Test — Cloud Cost Research Workflow

## Test 1: Importación

1. n8n → Workflows → Import from file → `src/workflow.json`
2. Verificar 11 nodos presentes
3. Estado: ☐ Pendiente

## Test 2: Ejecución con CSV fixture (sin credenciales AWS)

**Configuración mínima:**
```
COST_DATA_MODE=csv_fixture
LLM_API_KEY=sk-ant-...
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/...
COST_ALERT_THRESHOLD=2000
```

**Pasos:**
1. Activar workflow
2. Ejecutar nodo "Manual Trigger"
3. Verificar que "Load CSV Fixture" devuelve datos de costs-dummy.csv
4. Verificar que "Parse Cost Data" produce `totalCurrent: "2677.16"` (suma del fixture)
5. Verificar que "Over Budget?" enruta a TRUE (2677 > 2000)
6. Verificar que "Send Slack Alert" hace POST al webhook de Slack

**Resultado esperado:**
- Mensaje en Slack con alerta de presupuesto
- Resumen LLM con las 5 secciones estructuradas

Estado: ☐ Pendiente

## Test 3: Verificar salida del LLM

Después de ejecutar el Test 2, en el historial del nodo "Generate LLM Summary":
- [ ] El texto contiene "RESUMEN EJECUTIVO"
- [ ] El texto contiene "ANOMALÍAS"
- [ ] El texto contiene "ACCIONES RECOMENDADAS"

Estado: ☐ Pendiente

## Test 4: Sin alerta (bajo threshold)

1. Configurar `COST_ALERT_THRESHOLD=99999`
2. Ejecutar workflow
3. Verificar que "Over Budget?" va al branch FALSE (no alerta)
4. Verificar que "Archive Report" registra el resultado

Estado: ☐ Pendiente

| Test | Fecha | Por | Resultado |
|------|-------|-----|-----------|
| T1-T4 | — | — | ☐ |
