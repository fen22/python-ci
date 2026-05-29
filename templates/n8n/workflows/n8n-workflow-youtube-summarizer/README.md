# n8n YouTube Video Summarizer

**Status:** `draft` — workflow importable, requiere solo OpenAI API key.
**Fuente:** [enescingoz/awesome-n8n-templates](https://github.com/enescingoz/awesome-n8n-templates) — CC BY 4.0 — Enes Cingoz

Workflow simple que toma una URL de YouTube, extrae la transcripción del video y genera un resumen con puntos clave usando un LLM. Ideal para mantenerse al día con contenido técnico o de producto sin ver el video completo.

## Flujo

```
Input: URL de YouTube
    → Solicitar transcripción (YouTube Transcript API)
    → Resumir con LLM (OpenAI)
    → Output: resumen + puntos clave
```

## Setup

1. Importar `src/workflow.json`
2. Configurar `OPENAI_API_KEY` en n8n
3. Ejecutar con cualquier URL de YouTube que tenga subtítulos/transcripción disponibles

## Nota

Solo funciona con videos que tienen transcripción habilitada (la mayoría de los videos en inglés y muchos en español). Videos sin transcripción devuelven error.
