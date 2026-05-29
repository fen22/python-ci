# Claude Doc Q&A Prompt Pack

**Status:** `draft` — prompts revisados y probados manualmente con Claude. Directamente usables.

Pack de prompts para hacer Q&A sobre documentación técnica usando Claude. El asistente responde **únicamente** basándose en la documentación proporcionada, cita fuentes y declara explícitamente cuando algo no está en los docs.

## Archivos

| Archivo | Descripción |
|---|---|
| `src/system-prompt.md` | System prompt con reglas de comportamiento |
| `src/prompt.md` | Template del user prompt con variables |
| `src/examples.md` | 3 ejemplos completos con respuestas esperadas |
| `src/evals.md` | Criterios de evaluación (5 dimensiones, scoring 0-3) |
| `src/fixtures/sample-doc.md` | Documentación dummy para pruebas |

## Uso rápido

### En Claude.ai

1. Abrir nueva conversación
2. Pegar el contenido de `src/system-prompt.md` en el campo de system prompt (Projects)
3. Enviar el mensaje:
```
Here is the documentation:

<documentation>
[Pegar aquí el contenido de src/fixtures/sample-doc.md]
</documentation>

Question: What authentication method does the API use and how long do tokens last?
```
4. Claude responderá basándose solo en el sample-doc fixture.

### En Claude Code (CLI)

```bash
# Crear un archivo de contexto
cat src/fixtures/sample-doc.md | claude --system "$(cat src/system-prompt.md)" \
  "Answer this question based on the documentation I'll provide: How does rate limiting work?"
```

### Via Anthropic API (Python)

```python
import anthropic
from pathlib import Path

client = anthropic.Anthropic(api_key="sk-ant-...")

system_prompt = Path("src/system-prompt.md").read_text()
documentation = Path("src/fixtures/sample-doc.md").read_text()
question = "What is the maximum per_page value for listing resources?"

response = client.messages.create(
    model="claude-3-5-sonnet-20241022",
    max_tokens=1024,
    system=system_prompt,
    messages=[
        {
            "role": "user",
            "content": f"<documentation>\n{documentation}\n</documentation>\n\nQuestion: {question}"
        }
    ]
)

print(response.content[0].text)
```

### Via Anthropic API (Node.js)

```javascript
import Anthropic from "@anthropic-ai/sdk";
import { readFileSync } from "fs";

const client = new Anthropic({ apiKey: process.env.ANTHROPIC_API_KEY });
const systemPrompt = readFileSync("src/system-prompt.md", "utf-8");
const documentation = readFileSync("src/fixtures/sample-doc.md", "utf-8");

const response = await client.messages.create({
  model: "claude-3-5-sonnet-20241022",
  max_tokens: 1024,
  system: systemPrompt,
  messages: [
    {
      role: "user",
      content: `<documentation>\n${documentation}\n</documentation>\n\nQuestion: How does token refresh work?`,
    },
  ],
});

console.log(response.content[0].text);
```

## Adaptar para tu documentación

1. Reemplaza `src/fixtures/sample-doc.md` con tu documentación real
2. Si tienes documentación muy larga, divide en secciones y pásalas en múltiples tags `<documentation source="api-ref">...</documentation>`
3. El system prompt puede ser modificado para cambiar el idioma de respuesta (actualmente: inglés con instrucciones en español)

## Casos de uso típicos

- Bot de soporte técnico interno
- Q&A sobre API reference de clientes
- Asistente de onboarding para nuevos ingenieros
- Búsqueda en runbooks de operaciones

## Evaluación

Ver `src/evals.md` para criterios de evaluación. Score mínimo recomendado: 9/15.

Prueba rápida de calidad:
1. Pregunta algo que **sí está** en los docs → debe responder con cita
2. Pregunta algo que **no está** en los docs → debe decir "no está en la documentación"
3. Verifica que no inventa información

## Limitaciones

- El contexto máximo es el de la ventana del modelo. Para docs > 100,000 tokens, usar RAG en lugar de este approach directo.
- El sistema prompt está en inglés; si tu equipo necesita respuestas en español, agregar "Respond in Spanish" al system prompt.
- No tiene memoria de conversación entre sesiones.
