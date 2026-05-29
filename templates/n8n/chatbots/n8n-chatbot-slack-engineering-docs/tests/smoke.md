# Smoke Test — n8n Slack Engineering Docs Bot

## Objetivo
Verificar que el workflow importa correctamente y que los nodos responden como se espera con datos dummy.

## Pre-requisitos
- n8n instalado y corriendo
- Workflow importado desde `src/workflow.json`
- Variables de entorno configuradas (al menos con valores dummy para test)

---

## Test 1: Importación del workflow

**Pasos:**
1. Abrir n8n → Workflows → Import from file
2. Seleccionar `src/workflow.json`

**Resultado esperado:**
- El workflow se carga sin errores
- Se ven 9 nodos en el canvas: Slack Slash Command, Acknowledge Request, Extract Query, Fetch Documentation, Build Prompt, Call LLM API, Format Slack Response, Send Answer to Slack, Send Error to Slack
- Las conexiones entre nodos son correctas (verificar visualmente)

**Estado:** ☐ Pendiente

---

## Test 2: Webhook manual con payload Slack dummy

**Pasos:**
1. Activar el workflow (toggle ON)
2. Copiar la Test URL del nodo "Slack Slash Command"
3. Ejecutar desde terminal:

```bash
curl -X POST "https://<tu-n8n>/webhook-test/slack-docs" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "text=Como+hacemos+deploy+a+produccion&response_url=https://httpbin.org/post&user_name=test_user&channel_name=general"
```

**Resultado esperado:**
- HTTP 200 con body: `{"response_type":"ephemeral","text":":hourglass: Buscando en la documentación, espera un momento..."}`
- En el historial de n8n, el workflow se ejecuta y llega al nodo "Extract Query" con los datos correctos

**Estado:** ☐ Pendiente

---

## Test 3: Nodo "Fetch Documentation" con URL de prueba

**Pasos:**
1. Configurar `DOCS_SOURCE_URL=https://raw.githubusercontent.com/ClickITMx/clickit-agentic-low-code-templates/main/README.md`
2. Repetir el curl del Test 2
3. Verificar en n8n que el nodo "Fetch Documentation" recibió el contenido del README

**Resultado esperado:**
- El nodo "Fetch Documentation" devuelve el texto del README (contenido de markdown)
- El nodo "Build Prompt" construye un mensaje con ese contenido

**Estado:** ☐ Pendiente

---

## Test 4: Respuesta al response_url (con httpbin)

**Pasos:**
1. Usar `response_url=https://httpbin.org/post` en el payload
2. Verificar en n8n que el nodo "Send Answer to Slack" hace POST a httpbin.org

**Resultado esperado:**
- En el historial del nodo "Send Answer to Slack": status HTTP 200
- El body enviado contiene `response_type: "in_channel"` y el texto de respuesta del LLM

**Estado:** ☐ Pendiente

---

## Test 5: Manejo de errores (URL de docs no válida)

**Pasos:**
1. Configurar `DOCS_SOURCE_URL=https://url-que-no-existe.invalid`
2. Ejecutar el curl del Test 2
3. Verificar en n8n

**Resultado esperado:**
- El nodo "Fetch Documentation" falla con error HTTP
- El workflow enruta al nodo "Send Error to Slack" (rama de error)
- El nodo "Send Error to Slack" hace POST al response_url con el mensaje de error

**Estado:** ☐ Pendiente

---

## Registro de ejecución

| Test | Fecha | Ejecutado por | Resultado | Notas |
|------|-------|---------------|-----------|-------|
| T1 | — | — | ☐ | — |
| T2 | — | — | ☐ | — |
| T3 | — | — | ☐ | — |
| T4 | — | — | ☐ | — |
| T5 | — | — | ☐ | — |
