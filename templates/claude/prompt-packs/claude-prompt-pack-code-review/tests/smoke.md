# Smoke Test — Code Review Prompt Pack

## Test 1: Fixture con 5 issues conocidos

Usar `src/fixtures/sample-code.py` y verificar que Claude detecta:
- [ ] SQL Injection (CRITICAL)
- [ ] Hardcoded secret (CRITICAL)
- [ ] N+1 query (HIGH)
- [ ] Path traversal (HIGH)
- [ ] Division by zero (MEDIUM)

Estado: ☐ Pendiente

## Test 2: Código limpio → APPROVE

Pegar una función bien escrita y verificar que responde APPROVE sin falsos positivos.
Estado: ☐ Pendiente

| Test | Fecha | Por | Score |
|------|-------|-----|-------|
| T1-T2 | — | — | — |
