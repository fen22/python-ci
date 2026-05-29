# n8n PDF Q&A with Citations

**Status:** `draft` — workflow importable, requiere Pinecone y Google Drive configurados.
**Fuente:** [enescingoz/awesome-n8n-templates](https://github.com/enescingoz/awesome-n8n-templates) — CC BY 4.0 — Enes Cingoz

Chatbot n8n que carga un PDF desde Google Drive, lo procesa en chunks, crea embeddings con OpenAI y los indexa en Pinecone. Al recibir una pregunta, recupera los chunks más relevantes y genera una respuesta que cita las fuentes exactas del documento.

## Flujo

```
Ejecución manual (indexar)          Chat Trigger (preguntar)
    → Descargar PDF de Drive             → Buscar chunks en Pinecone
    → Chunking + Embeddings (OpenAI)     → Construir contexto
    → Guardar en Pinecone                → Generar respuesta con citas (OpenAI)
```

## Dependencias

- **Pinecone**: cuenta en pinecone.io (hay tier gratuito)
- **OpenAI API**: para embeddings (`text-embedding-3-small`) y chat (`gpt-4o`)
- **Google Drive**: con API habilitada en Google Cloud Console

## Variables

| Variable | Descripción |
|---|---|
| `OPENAI_API_KEY` | API key de OpenAI |
| `PINECONE_API_KEY` | API key de Pinecone |
| `PINECONE_INDEX` | Nombre del índice en Pinecone |
| `GOOGLE_DRIVE_FILE_ID` | ID del archivo PDF en Drive |

## Setup

1. Importar `src/workflow.json` en n8n
2. Configurar credenciales de Google Drive y OpenAI en n8n
3. Crear un índice en Pinecone (dimensión 1536 para `text-embedding-3-small` (también compatible con modelos anteriores))
4. Ejecutar el sub-workflow de indexación con tu PDF
5. Usar el Chat Trigger para hacer preguntas

## Alternativa sin Pinecone

Para una versión completamente local, reemplazar el nodo "Add to Pinecone vector store" con "In-Memory Vector Store" de n8n (disponible en n8n >= 1.20).
