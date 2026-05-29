# Contribuir

## Flujo

1. Abre o toma un issue.
2. Crea una rama `feat/<platform>/<slug>` o `bench/<handle>/<platform>-<slug>`.
3. Copia `scaffolds/template-skeleton` al folder correcto en `templates/`.
4. Completa metadata, documentación, variables, tests y evidencia.
5. Abre PR y espera validación automática + review.

## Requisitos por template

Cada template debe incluir:

- `template.yaml`
- `README.md`
- `.env.example` cuando use variables
- `src/` con el artefacto principal
- `tests/smoke.md`
- `validation/checklist.md`
- `validation/evidence.json`

## Reglas

- No subir secretos, tokens, llaves privadas ni credenciales reales.
- Usar variables de entorno y `.env.example`.
- Documentar limitaciones y riesgos.
- Mantener cambios pequeños y revisables.
- Seguir Conventional Commits.
