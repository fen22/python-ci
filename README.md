# ClickIT Agentic Low-Code Templates

Repositorio comunitario para templates de agentic apps low-code enfocados en automatización de ingeniería, soporte interno y aceleradores comerciales para clientes.

## Objetivos

- Crear templates reutilizables, documentados y probados por la comunidad de ClickIT.
- Integrar colaboradores en bench para practicar n8n, Langflow, Zapier, Claude Code, MCP y automatización AI/DevOps.
- Mantener una biblioteca versionada con buenas prácticas, validación y evidencia reproducible.

## Plataformas iniciales

- **n8n**: workflows exportables en JSON, ideal para automatización técnica y AI workflows.
- **Zapier**: blueprints comerciales para integraciones SaaS y agentes de negocio.
- **Langflow**: flows visuales para RAG, chatbots y agentes.
- **Claude**: prompt packs, skills, configuración de Claude Code y MCP.
- **MCP / shared**: servidores, configs y guardrails reutilizables.

## Estructura

```text
.github/                 Issue forms, PR templates, CODEOWNERS y CI
docs/                    Guías de arquitectura, seguridad, bench y releases
schemas/                 JSON Schemas para metadata y catálogo
catalog/                 Catálogo generado de templates
scripts/                 Validación, scaffolding y generación de catálogo
scaffolds/               Skeletons para nuevos templates
tools/                   Configuración de linters y pre-commit
templates/               Biblioteca de templates por plataforma
```

## Flujo recomendado

1. Crear issue con el caso de uso.
2. Generar template desde `scaffolds/template-skeleton`.
3. Completar `template.yaml`, `README.md`, `.env.example`, tests y evidencia.
4. Abrir PR usando la plantilla correspondiente.
5. Pasar CI y revisión de owners.
6. Marcar estado como `bench-tested` o `clickit-verified`.

## Estados de madurez

- `draft`: idea o template inicial sin validación completa.
- `bench-tested`: probado por un colaborador bench con evidencia.
- `clickit-verified`: revisado por owner y listo para reutilización.
- `deprecated`: ya no recomendado.

## Casos de uso prioritarios

- Chatbot Slack para documentación y soporte de ingeniería.
- Agente de investigación de costos cloud / FinOps.
- Agente de infraestructura vía MCP con permisos de solo lectura y guardrails.
- Setup inicial de herramientas AI/DevOps para macOS y Windows.
