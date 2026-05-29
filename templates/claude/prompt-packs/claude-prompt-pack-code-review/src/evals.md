# Evals — Code Review Prompt Pack

## Dimensions (0-3 each)

1. **Finding accuracy** — Issues found are real, not hallucinated
2. **Severity calibration** — CRITICAL/HIGH/LOW assigned correctly
3. **Actionability** — Suggested fixes are concrete and correct
4. **Coverage** — Covers security, correctness, performance, readability
5. **False positive rate** — Doesn't flag correct code as problematic

**Minimum: 11/15**

## Test cases

| ID | Input | Expected |
|---|---|---|
| CR01 | SQL injection code | CRITICAL finding with parameterized query fix |
| CR02 | Clean, well-written function | APPROVE with brief LGTM |
| CR03 | Missing error handling | HIGH finding with try/catch suggestion |
| CR04 | Hardcoded secret in code | CRITICAL security finding |
| CR05 | N+1 query in loop | HIGH performance finding |
