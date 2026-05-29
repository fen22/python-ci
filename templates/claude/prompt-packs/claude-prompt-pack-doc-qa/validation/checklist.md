# Checklist — Claude Doc Q&A Prompt Pack

## Estructura
- [ ] template.yaml válido
- [ ] src/system-prompt.md existe y es claro
- [ ] src/prompt.md tiene variables documentadas
- [ ] src/examples.md tiene 3 ejemplos completos
- [ ] src/evals.md tiene criterios cuantificables
- [ ] src/fixtures/sample-doc.md es documentación coherente

## Calidad de prompts
- [ ] System prompt tiene reglas explícitas de grounding
- [ ] System prompt especifica formato de respuesta
- [ ] Manejo de "no en docs" está instruido
- [ ] Citas están instruidas con formato específico

## Ejemplos
- [ ] Ejemplo 1: respuesta exitosa con cita
- [ ] Ejemplo 2: respuesta exitosa con valor de config
- [ ] Ejemplo 3: "no en docs" manejado correctamente

## Evaluación
- [ ] Score mínimo definido (9/15)
- [ ] Test de grounding (info incorrecta en docs) incluido
