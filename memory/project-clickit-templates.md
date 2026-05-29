---
name: project-clickit-templates
description: Contexto completo del repo ClickIT Agentic Low-Code Templates — qué hay, qué se construyó y qué falta
metadata:
  type: project
---

Repositorio de templates plug-and-play para agentic apps low-code enfocado en ClickIT. En `/home/fer/python-ci`.

**Why:** Biblioteca de templates documentados, probados y reutilizables para n8n, Langflow, Zapier, Claude Code/MCP y automatizaciones AI/DevOps. También sirve para que colaboradores en bench aprendan construyendo templates útiles.

**How to apply:** Cuando el usuario pida agregar templates, los convenciones son: kebab-case, SemVer, template.yaml con schema_version 1.0.0, status draft/bench-tested/clickit-verified/deprecated.

## Estado al 2026-05-29 (después de sesión inicial)

13 templates en catálogo:

### 10 templates activos (draft):
1. `tpl.n8n.chatbot.slack-engineering-docs` — Slack bot que consulta docs via LLM. Workflow JSON importable (9 nodos). Ruta: templates/n8n/chatbots/n8n-chatbot-slack-engineering-docs/
2. `tpl.n8n.workflow.cloud-cost-research` — FinOps workflow con CSV fixture y AWS Cost Explorer. 11 nodos. Ruta: templates/n8n/workflows/n8n-workflow-cloud-cost-research/
3. `tpl.n8n.workflow.pr-documentation-generator` — GitHub PR webhook → LLM → comentario automático. 9 nodos. Ruta: templates/n8n/workflows/n8n-workflow-pr-documentation-generator/
4. `tpl.langflow.chatbot.rag-docs` — RAG chatbot en Langflow con Chroma + Claude. 8 nodos, draft por limitación de versión. Ruta: templates/langflow/chatbots/langflow-chatbot-rag-docs/
5. `tpl.langflow.infra-agent.infra-mcp-orchestrator` — Blueprint de agente infra read-only en Langflow. No plug-and-play, Custom Components requieren implementación. Ruta: templates/langflow/infra-agents/langflow-infra-mcp-orchestrator/
6. `tpl.zapier.workflow.finops-alerting` — Blueprint implementable paso a paso (no importable — limitación de Zapier). Ruta: templates/zapier/workflows/zapier-workflow-finops-alerting/
7. `tpl.claude.prompt-pack.doc-qa` — Pack de prompts para Q&A sobre docs. Directamente usable en Claude.ai o API. Ruta: templates/claude/prompt-packs/claude-prompt-pack-doc-qa/
8. `tpl.claude.prompt-pack.finops-summary` — Pack de prompts FinOps en español. Acepta CSV/JSON/texto. Directamente usable. Ruta: templates/claude/prompt-packs/claude-prompt-pack-finops-summary/
9. `tpl.claude.mcp.infra-assistant` — Configuración MCP para Claude Code como asistente infra read-only. IAM policy mínima documentada. Ruta: templates/claude/mcp/claude-mcp-infra-assistant/
10. `tpl.others.initial-setup.ai-devops-bootstrap` — Scripts bash/PowerShell para setup macOS+Windows. Pide confirmación. Ruta: templates/others/initial-setup/others-initial-setup-ai-devops-bootstrap/

### 3 deprecated:
- tpl.n8n.chatbot.slack-docs (reemplazado por #1)
- tpl.claude.prompt-pack.finops-summary-v0 (reemplazado por #8)
- tpl.others.initial-setup.mac-windows-ai-devops-bootstrap (reemplazado por #10)

## Scripts del repo

- `python scripts/validate.py` — valida todos los template.yaml + archivos requeridos
- `python scripts/build_catalog.py` — genera catalog/templates.json, templates.csv, stats.json
- `scripts/new_template.sh <platform> <type> <slug>` — crea nuevo template desde scaffold

## Bugs corregidos en esta sesión

- validate.py línea 18: literal newline en string `'\n'.join(errors)` → corregido
- build_catalog.py líneas 12, 20: mismo bug → corregido
