# Evaluation Criteria — Doc Q&A Prompt Pack

## How to evaluate responses

Run each test case and score 0-3 per criterion.

**Score scale:**
- 0: Fails criterion completely
- 1: Partially meets criterion
- 2: Meets criterion
- 3: Exceeds criterion (provides more than expected)

---

## Evaluation dimensions

### 1. Groundedness (0-3)
The answer must be based ONLY on the provided documentation.

- 3: Every claim traceable to the documentation
- 2: Minor extrapolation, clearly flagged
- 1: Some external knowledge used without flagging
- 0: Answer based on external knowledge, ignoring docs

**Test:** Replace all doc content with deliberately incorrect values. The model should answer incorrectly (using the doc) rather than using its own knowledge.

---

### 2. Citation accuracy (0-3)
Sources cited must be real and relevant.

- 3: All citations are accurate and point to specific sections
- 2: Citations exist but imprecise
- 1: Citations present but some incorrect
- 0: No citations or fabricated citations

---

### 3. "Not in docs" handling (0-3)
When the answer is absent from documentation.

- 3: Clearly states not in docs AND suggests where to look
- 2: States not in docs but no guidance
- 1: Partially answers using external knowledge (bad)
- 0: Invents an answer

**Test case:** Ask about a feature not present in the provided documentation.

---

### 4. Conciseness (0-3)
Answers should be direct and not padded.

- 3: Leads with answer, no fluff
- 2: Correct but slightly verbose
- 1: Answer buried in unnecessary context
- 0: Extremely verbose or circular

---

### 5. Code accuracy (0-3)
When documentation includes code examples.

- 3: Code reproduced verbatim from docs
- 2: Minor formatting differences, same semantics
- 1: Modified code that still works
- 0: Invented code not in documentation

---

## Minimum passing scores

| Dimension | Minimum |
|---|---|
| Groundedness | 2 |
| Citation accuracy | 2 |
| "Not in docs" handling | 2 |
| Conciseness | 1 |
| Code accuracy (when applicable) | 2 |

**Total minimum: 9/15**

---

## Test matrix

| Test ID | Question type | Documentation type | Expected outcome |
|---|---|---|---|
| E01 | Factual lookup | API reference | Direct answer with citation |
| E02 | Configuration value | YAML config docs | Exact value with field name |
| E03 | Not in docs | Any | "Not covered" + redirect |
| E04 | Code example | Code-heavy docs | Verbatim code snippet |
| E05 | Ambiguous question | Any | States interpretation first |
| E06 | Multi-section answer | Complex docs | Multiple citations |
