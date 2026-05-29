# Checklist — Claude MCP Infra Assistant

## Estructura
- [ ] template.yaml válido
- [ ] mcp-config.example.json es JSON válido
- [ ] security-guardrails.md incluye IAM policy mínima
- [ ] security-guardrails.md lista acciones prohibidas
- [ ] README explica qué hace y qué NO hace

## Seguridad
- [ ] No hay credenciales reales en ningún archivo
- [ ] IAM policy tiene Deny explícito en acciones destructivas
- [ ] Filesystem MCP usa --readonly
- [ ] `secretsmanager:GetSecretValue` explícitamente denegado
- [ ] GitHub token tiene scopes mínimos documentados
- [ ] `credentials_embedded: false` en template.yaml

## Documentación
- [ ] README lista acciones permitidas y prohibidas claramente
- [ ] Setup en Claude Code documentado paso a paso
- [ ] Política de aprobación humana explicada
