# Checklist — Cloud Cost Research Workflow

## Estructura
- [ ] template.yaml válido
- [ ] README.md completo con IAM policy incluida
- [ ] .env.example con todas las variables
- [ ] src/workflow.json es JSON válido con 11 nodos
- [ ] src/fixtures/costs-dummy.csv existe
- [ ] tests/smoke.md tiene casos ejecutables
- [ ] validation/evidence.json actualizado

## Funcionalidad
- [ ] Importa en n8n sin errores
- [ ] Modo csv_fixture funciona sin credenciales AWS
- [ ] Parse Cost Data produce totales correctos del fixture (aprox $2677)
- [ ] LLM genera análisis con 5 secciones
- [ ] IF node enruta correctamente según threshold
- [ ] Slack alert se envía cuando isOverThreshold=true

## Seguridad
- [ ] No hay credenciales AWS reales en ningún archivo
- [ ] IAM policy de solo lectura documentada en README
- [ ] SLACK_WEBHOOK_URL usa PLACEHOLDER en .env.example
