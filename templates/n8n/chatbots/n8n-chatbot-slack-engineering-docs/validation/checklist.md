# Checklist de validación — n8n Slack Engineering Docs Bot

## Estructura del template
- [ ] `template.yaml` existe y pasa `python scripts/validate.py`
- [ ] `README.md` tiene pasos claros de setup
- [ ] `.env.example` tiene todas las variables documentadas
- [ ] `src/workflow.json` es JSON válido
- [ ] `tests/smoke.md` tiene tests ejecutables
- [ ] `validation/evidence.json` tiene evidencia de ejecución

## Funcionalidad
- [ ] El workflow importa en n8n sin errores
- [ ] El nodo Webhook tiene URL de producción configurada
- [ ] El nodo Acknowledge responde en < 3 segundos
- [ ] El nodo Fetch Documentation obtiene contenido correctamente
- [ ] El nodo Build Prompt genera un prompt coherente
- [ ] El nodo Call LLM API obtiene respuesta válida del LLM
- [ ] El nodo Send Answer to Slack publica el mensaje correctamente
- [ ] El manejo de errores (rama error) funciona

## Seguridad
- [ ] No hay tokens reales en ningún archivo
- [ ] `.env.example` usa valores PLACEHOLDER
- [ ] `credentials_embedded: false` en template.yaml
- [ ] Las variables de entorno se leen vía `$env.` en n8n
- [ ] El workflow no almacena datos de usuarios en disco

## Documentación
- [ ] README explica cada nodo y para qué sirve
- [ ] README tiene sección de limitaciones conocidas
- [ ] README menciona cómo adaptar para OpenAI vs Anthropic
- [ ] Smoke tests están documentados con resultados esperados
