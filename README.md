# ClickIT Agentic Low-Code Templates

Biblioteca de templates plug-and-play para agentic apps low-code. Incluye workflows de n8n, flows de Langflow, blueprints de Zapier, prompt packs para Claude y scripts de setup para AI/DevOps.

## Inicio rápido

```bash
# 1. Clonar el repo
git clone https://github.com/ClickITMx/clickit-agentic-low-code-templates.git
cd clickit-agentic-low-code-templates

# 2. Instalar dependencias
pip install -r requirements.txt

# 3. Validar todos los templates
python scripts/validate.py

# 4. Generar el catálogo
python scripts/build_catalog.py

# 5. Ver el catálogo
cat catalog/stats.json
```

## Templates disponibles

| Template | Plataforma | Estado | Descripción |
|---|---|---|---|
| [Slack Engineering Docs Bot](templates/n8n/chatbots/n8n-chatbot-slack-engineering-docs/) | n8n | `draft` | Bot de Slack que responde preguntas sobre docs internos vía LLM |
| [Cloud Cost Research](templates/n8n/workflows/n8n-workflow-cloud-cost-research/) | n8n | `draft` | Obtiene costos AWS, genera análisis FinOps con LLM y alerta a Slack |
| [PR Documentation Generator](templates/n8n/workflows/n8n-workflow-pr-documentation-generator/) | n8n | `draft` | GitHub PR webhook → LLM → publica documentación técnica como comentario |
| [RAG Docs Chatbot](templates/langflow/chatbots/langflow-chatbot-rag-docs/) | Langflow | `draft` | Chatbot RAG sobre documentación técnica con Chroma + Claude |
| [Infra MCP Orchestrator](templates/langflow/infra-agents/langflow-infra-mcp-orchestrator/) | Langflow | `draft` | Blueprint de agente de infraestructura read-only (requiere Custom Components) |
| [FinOps Alerting](templates/zapier/workflows/zapier-workflow-finops-alerting/) | Zapier | `draft` | Blueprint paso a paso para alertas de costos cloud (no importable — limitación de Zapier) |
| [Doc Q&A Prompt Pack](templates/claude/prompt-packs/claude-prompt-pack-doc-qa/) | Claude | `draft` | Prompts para Q&A sobre documentación técnica — usable directamente en Claude.ai |
| [FinOps Summary Prompt Pack](templates/claude/prompt-packs/claude-prompt-pack-finops-summary/) | Claude | `draft` | Prompts para análisis ejecutivo de costos cloud en español |
| [MCP Infra Assistant](templates/claude/mcp/claude-mcp-infra-assistant/) | Claude | `draft` | Config MCP read-only para Claude Code con IAM policy mínima y guardrails |
| [AI DevOps Bootstrap](templates/others/initial-setup/others-initial-setup-ai-devops-bootstrap/) | Others | `draft` | Scripts macOS/Windows para instalar Git, Python, Node, Docker, Claude Code, n8n |

> **Leyenda de estados:** `draft` = importable pero no probado con credenciales reales · `bench-tested` = probado manualmente con datos dummy · `clickit-verified` = listo para reutilización interna seria

## Cómo usar un template

Cada template tiene su propio `README.md` con instrucciones de setup. El flujo general es:

```
1. Ir al directorio del template que te interesa
2. Leer su README.md
3. Copiar .env.example → .env y completar las variables
4. Seguir los pasos de setup del README
5. Ejecutar el smoke test en tests/smoke.md
```

### Ejemplo — Cloud Cost Research (modo fixture, sin credenciales AWS)

```bash
cd templates/n8n/workflows/n8n-workflow-cloud-cost-research

# Ver las variables necesarias
cat .env.example

# El smoke test manual
cat tests/smoke.md

# El workflow importable
ls src/workflow.json      # importar en n8n
ls src/fixtures/costs-dummy.csv  # datos de prueba incluidos
```

### Ejemplo — Claude FinOps Summary (usable inmediatamente)

```bash
cd templates/claude/prompt-packs/claude-prompt-pack-finops-summary

# 1. Leer el system prompt
cat src/system-prompt.md

# 2. Pegar en Claude.ai junto con los datos de ejemplo
cat src/fixtures/costs-sample.csv

# 3. Ver ejemplos de respuesta esperada
cat src/examples.md
```

## Crear un template nuevo

```bash
# Usar el scaffold helper
bash scripts/new_template.sh <platform> <type> <slug>

# Ejemplo
bash scripts/new_template.sh n8n workflow my-new-workflow
# → Crea: templates/n8n/workflows/n8n-workflow-my-new-workflow/
```

Luego seguir la guía en [docs/bench-playbook.md](docs/bench-playbook.md).

## Validación y catálogo

```bash
# Validar todos los templates (schema + archivos requeridos)
python scripts/validate.py

# Regenerar catálogo (JSON, CSV, stats)
python scripts/build_catalog.py

# Ver resumen
python -c "
import json
items = json.load(open('catalog/templates.json'))
for status in ['draft', 'bench-tested', 'clickit-verified', 'deprecated']:
    group = [i['template_id'] for i in items if i['status'] == status]
    if group: print(f'{status} ({len(group)}): {chr(10)}  ' + chr(10).join(f'  {t}' for t in group))
"
```

## Estructura del repo

```
templates/          Biblioteca de templates por plataforma
  n8n/              Workflows importables en JSON
  langflow/         Flows visuales (JSON o blueprint)
  zapier/           Blueprints implementables paso a paso
  claude/           Prompt packs, MCP configs
  others/           Scripts de setup y herramientas generales

schemas/            JSON Schema para template.yaml
scripts/            validate.py, build_catalog.py, new_template.sh
catalog/            Catálogo generado (templates.json, templates.csv, stats.json)
scaffolds/          Skeleton para nuevos templates
docs/               Arquitectura, bench playbook, seguridad, releases
```

### Estructura de cada template

```
<template>/
├── template.yaml          # Metadata (id, plataforma, status, secrets, etc.)
├── README.md              # Setup paso a paso
├── .env.example           # Variables de entorno (sin valores reales)
├── src/                   # Artefacto principal (workflow.json, prompt.md, etc.)
│   └── fixtures/          # Datos dummy para pruebas
├── tests/
│   └── smoke.md           # Instrucciones de smoke test
└── validation/
    ├── checklist.md       # Checklist de validación
    └── evidence.json      # Evidencia de pruebas realizadas
```

## Reglas de estado

- **Nunca** marcar un template como `bench-tested` sin haber ejecutado el smoke test con datos reales y guardado evidencia en `validation/evidence.json`.
- **Nunca** incluir tokens, API keys o contraseñas reales en ningún archivo.
- Los infra agents deben ser **read-only por defecto**. Cualquier acción destructiva requiere aprobación humana explícita.

## Contribuir

Ver [CONTRIBUTING.md](CONTRIBUTING.md) y [docs/bench-playbook.md](docs/bench-playbook.md).

## Plataformas

| Plataforma | Tipo de artefacto | Importable |
|---|---|---|
| n8n | `workflow.json` | ✅ Sí — via UI o CLI |
| Langflow | `flow.json` | ⚠️ Depende de la versión |
| Zapier | `zap.blueprint.md` | ❌ Manual (limitación de Zapier) |
| Claude | `prompt.md`, `mcp-config.json` | ✅ Sí — copiar/pegar o API |
| Others | `.sh`, `.ps1` | ✅ Ejecutar directamente |
