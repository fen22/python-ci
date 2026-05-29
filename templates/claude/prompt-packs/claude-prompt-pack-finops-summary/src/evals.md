# Evaluation Criteria — FinOps Summary Prompt Pack

## Scoring (0-3 per dimension)

### 1. Accuracy (0-3)
Todas las cifras deben coincidir con los datos de entrada.
- 3: Totales, porcentajes y variaciones calculados correctamente
- 2: Error menor en 1 cifra (< 5% de diferencia)
- 1: Múltiples errores de cálculo
- 0: Cifras inventadas o incorrectas materialmente

**Test:** Proveer CSV con totales conocidos y verificar aritmética.

### 2. Completeness (0-3)
Las 6 secciones del formato deben estar presentes.
- 3: Todas las secciones presentes y con contenido útil
- 2: 5 de 6 secciones
- 1: 3-4 secciones
- 0: Formato ignorado

### 3. Actionability (0-3)
Las acciones recomendadas deben ser específicas y ejecutables.
- 3: Acciones concretas con servicio, métrica y objetivo
- 2: Acciones razonables pero genéricas
- 1: Recomendaciones vagas ("optimizar costos")
- 0: Sin acciones o acciones irrelevantes

### 4. "No data" handling (0-3)
Cuando los datos son insuficientes.
- 3: Declara insuficiencia, especifica qué falta, da alternativa
- 2: Declara insuficiencia sin guía
- 1: Intenta analizar con datos insuficientes
- 0: Fabrica datos

### 5. Grounding (0-3)
No debe inventar servicios o valores no presentes.
- 3: Solo menciona servicios y valores del input
- 2: Un outlier menor
- 1: Agrega contexto no solicitado como si fuera del análisis
- 0: Inventa servicios o costos

---

## Test matrix

| ID | Input | Verificar |
|---|---|---|
| F01 | CSV con datos Ej 1 | Totales correctos, 6 secciones |
| F02 | Texto libre insuficiente | Sección "datos insuficientes" |
| F03 | Un solo servicio sin período anterior | No compara, no inventa |
| F04 | JSON AWS Cost Explorer | Parsea correctamente |
| F05 | Gasto bajo threshold | No genera alerta, menciona tendencia |

**Score mínimo aceptable:** 11/15
