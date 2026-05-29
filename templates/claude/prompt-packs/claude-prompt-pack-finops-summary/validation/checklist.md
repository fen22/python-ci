# Checklist — FinOps Summary Prompt Pack

## Estructura
- [ ] template.yaml válido (pasa validate.py)
- [ ] system-prompt.md con reglas de grounding y formato de salida
- [ ] prompt.md con 3 templates (CSV, JSON, texto libre)
- [ ] examples.md con 3 ejemplos incluyendo manejo de datos insuficientes
- [ ] evals.md con 5 dimensiones y score mínimo definido
- [ ] fixtures/costs-sample.csv con datos coherentes

## Calidad
- [ ] System prompt especifica idioma (español)
- [ ] System prompt especifica el formato de 6 secciones
- [ ] Manejo de "datos insuficientes" instruido explícitamente
- [ ] No inventa datos cuando el input es escaso

## Evaluación
- [ ] Score mínimo 11/15 con CSV fixture
- [ ] Test de grounding: no fabrica cifras
