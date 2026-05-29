# Claude Meeting Notes Summarizer

**Status:** `draft` — prompts listos y directamente usables.

Convierte notas o transcripciones de reuniones en un resumen estructurado con decisiones, action items (con owner y fecha) y preguntas abiertas.

## Uso rápido

Pegar `src/system-prompt.md` como system prompt en Claude.ai, luego enviar:

```
Please summarize the following meeting notes:

<meeting_notes>
[pegar src/fixtures/sample-meeting.txt]
</meeting_notes>
```

## Fixture incluida

`src/fixtures/sample-meeting.txt` — Sprint planning con 6 action items extraíbles.
