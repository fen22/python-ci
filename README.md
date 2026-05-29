# ClickIT Agentic Low-Code Templates

Repositorio comunitario para templates de agentic apps low-code enfocados en automatización de ingeniería, soporte interno y aceleradores comerciales para clientes.

## Objetivos

- Crear templates reutilizables, documentados y probados por la comunidad de ClickIT.
- Integrar colaboradores en bench para practicar n8n, Langflow, Zapier, Claude Code, MCP y automatización AI/DevOps.
- Mantener una biblioteca versionada con buenas prácticas, validación y evidencia reproducible.

## Plataformas iniciales

- **n8n**: workflows exportables en JSON.
- **Zapier**: blueprints comerciales para integraciones SaaS.
- **Langflow**: flows visuales para RAG, chatbots y agentes.
- **Claude**: prompt packs, skills, Claude Code y MCP.
- **MCP / shared**: servidores, configs y guardrails reutilizables.

## Estructura

```text
.github/       Issue forms, PR template, CODEOWNERS y CI
docs/          Guías de arquitectura, seguridad, bench y releases
schemas/       JSON Schemas para metadata y catálogo
catalog/       Catálogo generado de templates
scripts/       Validación y generación de catálogo
scaffolds/     Skeletons para nuevos templates
tools/         Configuración de linters y pre-commit
templates/     Biblioteca de templates por plataforma
```

## Casos de uso prioritarios

- Chatbot Slack para documentación y soporte de ingeniería.
- Agente de investigación de costos cloud / FinOps.
- Agente de infraestructura vía MCP con permisos de solo lectura y guardrails.
- Setup inicial de herramientas AI/DevOps para macOS y Windows.
