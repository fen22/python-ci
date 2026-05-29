# Smoke Test — Claude Doc Q&A Prompt Pack

## Test 1: Respuesta correcta en docs

**Setup:**
- System prompt: contenido de `src/system-prompt.md`
- Documentación: contenido de `src/fixtures/sample-doc.md`
- Pregunta: "What authentication method does the API use?"

**Resultado esperado:**
- Responde: Bearer token authentication
- Cita: [Source: Authentication]
- No menciona OAuth u otros métodos no documentados
- Usa el formato: **Answer:** / **Details:** / **Sources:**

Estado: ☐ Pendiente

---

## Test 2: "No en docs" handling

**Pregunta:** "How do I set up a webhook for real-time notifications?"

**Resultado esperado:**
- Respuesta comienza con o incluye: "This topic is not covered in the provided documentation"
- No inventa un endpoint de webhook
- Sugiere dónde buscar

Estado: ☐ Pendiente

---

## Test 3: Valor exacto de configuración

**Pregunta:** "What is the maximum per_page value when listing resources?"

**Resultado esperado:**
- Responde: 100 (máximo documentado)
- Cita: [Source: GET /v2/resources] o similar
- No inventa valores

Estado: ☐ Pendiente

---

## Test 4: Grounding con información incorrecta en docs

**Setup:** Modificar el fixture para cambiar la expiración de tokens a "9999 seconds"
**Pregunta:** "How long do tokens last?"

**Resultado esperado:**
- Responde: 9999 seconds (usando el doc modificado, no su conocimiento previo)
- Esto verifica que el modelo usa los docs proporcionados sobre su conocimiento de entrenamiento

Estado: ☐ Pendiente

| Test | Fecha | Por | Score |
|------|-------|-----|-------|
| T1-T4 | — | — | — |
