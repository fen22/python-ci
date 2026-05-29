# Claude Code Review Prompt Pack

**Status:** `draft` — prompts listos y directamente usables en Claude.ai o API.
**Inspirado en:** [Anthropic Prompt Library](https://docs.anthropic.com/en/prompt-library/library)

Pack de prompts para code review técnico con Claude. Cubre bugs, seguridad (OWASP), performance, legibilidad y mejores prácticas. Produce un informe estructurado con severidades y sugerencias concretas.

## Uso rápido

### En Claude.ai

1. Pegar el contenido de `src/system-prompt.md` como system prompt (Projects)
2. Enviar:
```
Review this Python code:

Context: API endpoint for user lookup

```python
[pegar src/fixtures/sample-code.py]
```
```

### En Claude Code

```bash
cat src/fixtures/sample-code.py | claude --system "$(cat src/system-prompt.md)" \
  "Review this Python code for bugs, security issues, and best practices"
```

### Via API

```python
import anthropic
from pathlib import Path

client = anthropic.Anthropic()
code = Path("src/fixtures/sample-code.py").read_text()
system = Path("src/system-prompt.md").read_text()

response = client.messages.create(
    model="claude-3-5-sonnet-20241022",
    max_tokens=2048,
    system=system,
    messages=[{
        "role": "user",
        "content": f"Review this Python code:\n\n```python\n{code}\n```"
    }]
)
print(response.content[0].text)
```

## Fixture de prueba incluida

`src/fixtures/sample-code.py` contiene código Python con 5 problemas intencionales:
- SQL Injection (CRITICAL)
- Hardcoded secret (CRITICAL)
- N+1 query pattern (HIGH)
- Division by zero (MEDIUM)
- Path traversal (HIGH)

Úsalo para verificar que el modelo detecta todos antes de usarlo en código real.
