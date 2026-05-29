# Smoke Test — n8n PR Documentation Generator

## Test 1: Importación

1. Importar `src/workflow.json` en n8n
2. Verificar que aparecen 9 nodos y las conexiones son correctas
3. Estado esperado: ☐ Pendiente

## Test 2: Webhook manual con fixture

```bash
curl -X POST "https://<tu-n8n>/webhook-test/github-pr-docs" \
  -H "Content-Type: application/json" \
  -d @src/fixtures/pr-diff-dummy.json
```

Verificar en el historial de n8n:
- El nodo "Is PR Open/Updated?" pasa al branch TRUE (action=opened)
- El nodo "Extract PR Metadata" captura número, título, autor
- Estado esperado: ☐ Pendiente

## Test 3: Llamada a GitHub API con PAT dummy

1. Configurar `GITHUB_TOKEN` con un PAT real de prueba
2. Usar un repo de test con un PR abierto
3. Verificar que "Get PR Files" devuelve la lista de archivos
4. Estado esperado: ☐ Pendiente

## Test 4: LLM genera documentación

1. Configurar `LLM_API_KEY` real
2. Ejecutar el workflow completo con el fixture
3. Verificar que el nodo "Generate PR Docs" devuelve texto estructurado con las secciones esperadas
4. Estado esperado: ☐ Pendiente

## Test 5: Comentario publicado en GitHub

1. Ejecutar el flujo completo con un PR real
2. Verificar en GitHub que apareció el comentario del bot
3. El comentario debe tener el header "🤖 Auto-generated PR Documentation"
4. Estado esperado: ☐ Pendiente

| Test | Fecha | Por | Resultado |
|------|-------|-----|-----------|
| T1-T5 | — | — | ☐ |
