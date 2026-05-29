# n8n Email AI Auto-Responder with RAG

**Status:** `draft` — workflow importable con dependencias externas (Qdrant, OpenAI).
**Fuente:** [enescingoz/awesome-n8n-templates](https://github.com/enescingoz/awesome-n8n-templates) — CC BY 4.0 — Enes Cingoz

Workflow que monitorea un inbox IMAP, clasifica emails entrantes con IA, busca contexto relevante en una base de conocimiento (Qdrant), redacta una respuesta automática y la envía.

## Flujo

```
IMAP Trigger (nuevo email)
    → Clasificar email (OpenAI)
    → Resumir email (Chain LLM)
    → Buscar contexto en Qdrant (RAG)
    → Redactar respuesta (OpenAI/DeepSeek)
    → Revisar borrador
    → Enviar email (SMTP)
```

## Dependencias

- **Qdrant** (vector store): instancia local `docker run -p 6333:6333 qdrant/qdrant` o cuenta cloud en qdrant.tech
- **OpenAI API**: para clasificación, embeddings y redacción
- **DeepSeek** (opcional): alternativa al modelo de redacción
- **Cuenta IMAP/SMTP**: cualquier proveedor (Gmail, Outlook, etc.)

## Variables

| Variable | Descripción |
|---|---|
| `IMAP_HOST` | Servidor IMAP (ej: `imap.gmail.com`) |
| `IMAP_USER` | Email del inbox a monitorear |
| `IMAP_PASSWORD` | Contraseña o App Password |
| `OPENAI_API_KEY` | API key de OpenAI |
| `QDRANT_URL` | URL de tu instancia Qdrant |
| `QDRANT_API_KEY` | API key de Qdrant (si es cloud) |
| `SMTP_HOST` | Servidor SMTP para enviar respuestas |
| `SMTP_USER` | Usuario SMTP |
| `SMTP_PASSWORD` | Contraseña SMTP |

## Setup

1. n8n → **Import from file** → `src/workflow.json`
2. Configurar credenciales IMAP, SMTP y OpenAI en n8n Credentials
3. Iniciar Qdrant y crear la colección de conocimiento (ver nodo "Create collection")
4. Activar el workflow

## Nota de seguridad

Este workflow procesa emails que pueden contener PII. Revisar:
- `data_classification: confidential` en template.yaml
- No logear contenido de emails en producción
- Usar App Passwords en lugar de contraseñas reales para Gmail/Outlook
