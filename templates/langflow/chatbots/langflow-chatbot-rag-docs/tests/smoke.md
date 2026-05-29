# Smoke Test — Langflow RAG Docs Chatbot

## Test 1: JSON válido

```bash
python3 -c "import json; d=json.load(open('src/flow.json')); print('Nodos:', len(d['data']['nodes']), '| Edges:', len(d['data']['edges']))"
```
Resultado esperado: `Nodos: 8 | Edges: 8`
Estado: ☐ Pendiente

---

## Test 2: Importación en Langflow

1. Instalar Langflow: `pip install langflow && langflow run`
2. UI en `http://localhost:7860`
3. Load Flow → `src/flow.json`
4. Verificar que los 8 nodos aparecen conectados correctamente

Estado: ☐ Pendiente

---

## Test 3: Carga de fixture y pregunta de prueba

1. En el nodo File Loader → subir `src/fixtures/dummy-docs.txt`
2. Configurar API keys (OpenAI para embeddings, Anthropic para LLM)
3. Abrir Playground
4. Preguntar: `¿Cómo hago rollback de un deployment?`

**Resultado esperado:**
- Responde mencionando ArgoCD y el comando `argocd app rollback`
- Cita que viene del contexto de documentación (no inventa)

Estado: ☐ Pendiente

---

## Test 4: Pregunta fuera del documento

Preguntar: `¿Cuánto cuesta el servicio?`

**Resultado esperado:**
- Responde "I couldn't find this information in the documentation" (o similar)
- No inventa un precio

Estado: ☐ Pendiente

| Test | Fecha | Por | Resultado |
|------|-------|-----|-----------|
| T1-T4 | — | — | ☐ |
