# Langflow RAG Docs Chatbot

**Status:** `draft` — flow estructuralmente válido, requiere Langflow 1.x instalado y verificar compatibilidad de nodos.

Chatbot con RAG (Retrieval-Augmented Generation) construido en Langflow. Permite hacer preguntas sobre documentación técnica interna. Los documentos se dividen en chunks, se convierten en embeddings y se almacenan en Chroma (vector store). Las preguntas del usuario se buscan en el vector store y el contexto relevante se pasa a Claude para generar la respuesta.

## Arquitectura del flow

```
[File Loader] ─────────────────────────────────────────────────────┐
                                                                    ↓
[Chat Input] ──────────────────────────────────────► [RAG Chain (RetrievalQA)]
                                                      ↑            ↓
[Embeddings] ──► [Vector Store (Chroma)] ──► [Retriever]  [Chat Output]
                                                      ↑
[Claude LLM] ─────────────────────────────────────────┘
[RAG Prompt] ─────────────────────────────────────────┘
```

## Requisitos previos

- Langflow 1.x instalado (`pip install langflow`)
- Python 3.10+
- API key de OpenAI (para embeddings) y/o Anthropic (para LLM)

### Instalación rápida de Langflow

```bash
# Opción 1: pip
pip install langflow

# Opción 2: Docker
docker run -p 7860:7860 langflowai/langflow:latest

# Opción 3: uv (recomendado)
uv pip install langflow
```

Acceder en: `http://localhost:7860`

## Importar el flow

1. Iniciar Langflow: `langflow run`
2. En el UI → ícono de carpeta → **Load Flow**
3. Seleccionar `src/flow.json`
4. El flow aparece con 8 nodos conectados

> **Importante:** Langflow actualiza su API frecuentemente. Si algunos nodos no importan correctamente, verificar los nombres de componentes en tu versión: `langflow components` o revisar la documentación de la versión instalada.

## Configurar API keys

En el UI de Langflow, hacer clic en cada nodo y completar:

1. **Embeddings (OpenAI):**
   - `openai_api_key`: tu OpenAI API key
   - Alternativa: reemplazar con `AnthropicEmbeddings` si tienes API key de Anthropic

2. **Claude LLM:**
   - `anthropic_api_key`: tu Anthropic API key

3. **File Loader:**
   - Subir el archivo de documentación o reemplazar con `URLLoader`/`NotionLoader`

## Cargar documentación

### Opción A: Archivo local (más simple)
1. En el nodo **Document Loader** → subir un archivo `.txt`, `.md` o `.pdf`
2. Para pruebas: usar `src/fixtures/dummy-docs.txt`

### Opción B: URL (GitHub, Notion, Confluence)
1. Reemplazar el nodo `File` con `URLLoader` o `WebBaseLoader`
2. En el nodo: configurar la URL de tu documentación

### Opción C: Múltiples archivos
1. Agregar múltiples nodos `File` o usar `DirectoryLoader`
2. Conectar todos al nodo `SplitText`

## Probar el chatbot

1. Después de importar el flow y configurar las API keys
2. Hacer clic en **Playground** (icono de chat)
3. Preguntar: `¿Cómo hago rollback de un deployment?`
4. El chatbot debe responder usando el contenido del documento cargado

## Alternativas de componentes

| Componente | Default | Alternativas |
|---|---|---|
| Embeddings | OpenAI text-embedding-3-small | AnthropicEmbeddings, OllamaEmbeddings, HuggingFaceEmbeddings |
| Vector Store | Chroma (local) | FAISS, Pinecone, Weaviate, AstraDB |
| LLM | Claude claude-sonnet-4-6 | ChatOpenAI, ChatOllama, ChatGroq |
| Document Loader | File | URLLoader, NotionLoader, GitLoader |

## Limitaciones conocidas

- Langflow cambia su API entre versiones minor (1.0, 1.1, 1.2). Los handle names en el JSON pueden requerir ajuste.
- El vector store Chroma es in-memory por defecto — los documentos se pierden al reiniciar. Para persistencia, configurar `persist_directory`.
- El flow no tiene memoria de conversación entre sesiones de chat.
- Status `draft`: estructura revisada pero no probada con instalación real de Langflow 1.x por incompatibilidad de entorno de prueba.
