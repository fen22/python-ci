# n8n Meeting Action Items Extractor

**Status:** `draft` — workflow importable, requiere Google Workspace y OpenAI.
**Fuente:** [enescingoz/awesome-n8n-templates](https://github.com/enescingoz/awesome-n8n-templates) — CC BY 4.0 — Enes Cingoz

Workflow que recupera la transcripción de una reunión de Google Meet, usa un AI Agent para extraer action items estructurados, y crea automáticamente eventos de seguimiento en Google Calendar para cada acción pendiente.

## Flujo

```
Trigger manual / evento de calendario
    → Obtener ConferenceRecord de Google Meet
    → Descargar transcripción
    → AI Agent (OpenAI) extrae action items estructurados
    → Crear eventos en Google Calendar por cada acción
    → Notificar a asistentes
```

## Dependencias

- **Google Workspace**: acceso a Google Meet API y Google Calendar API
- **OpenAI API**: para el AI Agent de extracción

## Setup

1. Importar `src/workflow.json`
2. En Google Cloud Console: habilitar Meet API y Calendar API
3. Configurar credenciales OAuth2 de Google en n8n
4. Configurar `OPENAI_API_KEY` en n8n
5. Ejecutar con el ID de una reunión reciente

## Nota

Este workflow usa `Google Meet Conference Records API` que requiere Google Workspace Business o Enterprise. No funciona con cuentas Gmail personales básicas.
