# Evals — Meeting Notes Summarizer

## Dimensions (0-3)
1. **Action item extraction** — All action items found, none invented
2. **Owner attribution** — Correct owner per action
3. **Format compliance** — All 6 sections present
4. **Date extraction** — Dates inferred correctly
5. **Conciseness** — Summary ≤ 3 sentences

**Minimum: 11/15**

## Test cases
| ID | Input | Verify |
|---|---|---|
| MN01 | sample-meeting.txt | 6 action items, correct owners, June 5 deadline |
| MN02 | No action items meeting | "No action items" — doesn't invent |
| MN03 | Spanish notes | Responds in Spanish |
