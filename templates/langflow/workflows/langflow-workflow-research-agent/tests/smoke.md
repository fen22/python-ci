# Smoke Test — Langflow Research Agent

## Test 1: JSON/YAML válido
```bash
python3 -c "import json; json.load(open('src/workflow.json' if 'n8n' in 'langflow/workflows/langflow-workflow-research-agent' else 'src/flow.json')); print('JSON OK')"
python scripts/validate.py
```
Estado: ☐ Pendiente

## Test 2: Importar en la plataforma
- n8n: Workflows → Import from file → src/workflow.json
- Langflow: Load Flow → src/flow.json
Estado: ☐ Pendiente

## Test 3: Ejecutar con datos dummy
Ver README.md para pasos específicos.
Estado: ☐ Pendiente

| Test | Fecha | Por | Resultado |
|------|-------|-----|-----------|
| T1-T3 | — | — | ☐ |
