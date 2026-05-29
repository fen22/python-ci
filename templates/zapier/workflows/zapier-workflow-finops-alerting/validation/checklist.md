# Checklist — Zapier FinOps Alerting Blueprint

## Documentación
- [ ] blueprint.md tiene 8 pasos implementables
- [ ] Cada paso tiene campos exactos a completar
- [ ] JavaScript del Step 4 es válido
- [ ] Limitaciones de Zapier documentadas (no importable, plan requerido)
- [ ] Tiempo estimado de implementación indicado

## Seguridad
- [ ] No hay URLs de API reales en el blueprint
- [ ] No hay tokens ni webhooks de Slack reales
- [ ] .env.example claramente marcado como "solo referencia"

## Funcionalidad
- [ ] Flujo lógico: Schedule → Fetch → Parse → Filter → Alert es correcto
- [ ] JavaScript parsea tanto formato AWS CE como custom
- [ ] Filter evita alertas falsas
- [ ] Mensaje de Slack tiene formato Markdown correcto
