# Checklist — Langflow Infra MCP Orchestrator

## Estructura
- [ ] template.yaml válido, status draft
- [ ] flow.json es JSON válido con 9 nodos y 8 edges
- [ ] README documenta qué hace y qué NO hace claramente
- [ ] Limitaciones de MCP en Langflow documentadas

## Seguridad
- [ ] System prompt incluye guardrails read-only
- [ ] System prompt lista acciones permitidas y prohibidas
- [ ] No hay credenciales en flow.json
- [ ] `least_privilege_reviewed: true` en template.yaml
- [ ] README referencia security-guardrails.md del MCP template

## Documentación técnica
- [ ] Ejemplo de implementación de Custom Component incluido
- [ ] Alternativa (n8n como proxy) documentada
- [ ] Nota sobre soporte experimental de MCP en Langflow
