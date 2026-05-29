# n8n Slack Engineering Docs Bot

**Status:** `draft` — importable pero requiere configurar credenciales y fuente documental.

Bot de Slack que responde preguntas sobre documentación interna de ingeniería. Recibe un slash command `/docs <pregunta>`, consulta una fuente documental vía HTTP GET, llama a un LLM y publica la respuesta en el canal.

## Arquitectura

```
Slack Slash Command
    → Webhook (n8n)
    → Acknowledge (respuesta inmediata a Slack)
    → Extract Query
    → Fetch Documentation (HTTP GET a DOCS_SOURCE_URL)
    → Build Prompt
    → Call LLM API (Anthropic/OpenAI-compatible)
    → Format Response
    → POST to Slack response_url
```

## Requisitos previos

- n8n instalado (local con Docker o cloud n8n.cloud)
- App de Slack con slash command configurado
- API key de LLM (Anthropic Claude recomendado)
- Fuente de documentación accesible vía HTTP GET (Notion API, GitHub raw, URL pública, etc.)

## Variables de entorno

Copia `.env.example` como `.env` y completa los valores:

| Variable | Descripción | Requerida |
|---|---|---|
| `SLACK_BOT_TOKEN` | Token del Bot de Slack (xoxb-...) | Sí |
| `LLM_API_KEY` | API key del LLM (Anthropic, OpenAI, etc.) | Sí |
| `DOCS_SOURCE_URL` | URL del endpoint de documentación (GET → texto) | Sí |
| `LLM_MODEL` | Modelo a usar (default: `claude-3-5-sonnet-20241022`) | No |
| `LLM_API_URL` | URL base del LLM (default: API de Anthropic) | No |

## Setup paso a paso

### 1. Configurar Slack App

1. Ir a [api.slack.com/apps](https://api.slack.com/apps) → **Create New App**
2. En **Slash Commands** → Create New Command
   - Command: `/docs`
   - Request URL: `https://<tu-n8n-host>/webhook/slack-docs` (se obtiene en paso 3)
   - Short Description: "Pregunta sobre documentación de ingeniería"
3. En **OAuth & Permissions** → instalar la app en tu workspace
4. Copiar el **Bot User OAuth Token** → variable `SLACK_BOT_TOKEN`

### 2. Configurar fuente documental

La variable `DOCS_SOURCE_URL` debe apuntar a un endpoint que devuelva texto o JSON con la documentación. Opciones:

- **Notion API:** `https://api.notion.com/v1/blocks/<page-id>/children` (requiere auth header)
- **GitHub raw:** `https://raw.githubusercontent.com/org/repo/main/docs/engineering.md`
- **Confluence REST:** `https://<dominio>.atlassian.net/wiki/rest/api/content/<page-id>?expand=body.storage`
- **URL pública:** cualquier endpoint que devuelva texto plano o JSON

> Si tu fuente requiere autenticación, agrega un nodo **HTTP Request** con headers antes del nodo "Fetch Documentation".

### 3. Importar workflow en n8n

1. Abrir n8n → **Workflows** → botón **+** → **Import from file**
2. Seleccionar `src/workflow.json`
3. El workflow se importará con todos los nodos configurados

### 4. Configurar variables de entorno en n8n

**Opción A — n8n local (Docker):**
```bash
# En tu docker-compose.yml o .env de n8n:
N8N_ENV_LLM_API_KEY=sk-ant-...
N8N_ENV_LLM_API_URL=https://api.anthropic.com/v1/messages
N8N_ENV_LLM_MODEL=claude-3-5-sonnet-20241022
N8N_ENV_DOCS_SOURCE_URL=https://raw.githubusercontent.com/tu-org/docs/main/README.md
```

**Opción B — n8n Settings UI:**
Settings → Environment Variables → agregar cada variable manualmente.

### 5. Activar el webhook

1. En el workflow, hacer clic en el nodo **Slack Slash Command**
2. Copiar la **Webhook URL de producción** (Production URL, no Test URL)
3. Pegar esta URL en la configuración del slash command de Slack (paso 1.2)

### 6. Activar el workflow

Toggle **Active** en la esquina superior derecha del workflow editor.

### 7. Probar

En cualquier canal de Slack donde esté instalada la app:
```
/docs ¿Cómo hacemos deploy a producción?
```

## Adaptación del LLM

Por defecto el workflow llama a la API de Anthropic. Para usar OpenAI:

1. Cambiar `LLM_API_URL` a `https://api.openai.com/v1/chat/completions`
2. Cambiar el header de `x-api-key` a `Authorization: Bearer $env.LLM_API_KEY`
3. Ajustar el body de la petición en el nodo "Call LLM API" para formato OpenAI

## Limitaciones conocidas

- La documentación se trunca a 8,000 caracteres por llamada al LLM. Para docs grandes, considera chunking.
- No tiene memoria de conversación entre preguntas (cada slash command es independiente).
- Si DOCS_SOURCE_URL tarda más de 30s, el webhook timeout de Slack (3s) ya habrá expirado. El bot igual responderá vía `response_url`.
- El nodo "Fetch Documentation" hace GET sin autenticación. Si tu fuente requiere auth, debes agregar un nodo HTTP previo o modificar los headers.
- Status `draft`: no fue probado con credenciales reales de producción.
