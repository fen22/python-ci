# Smoke Test — Claude FinOps Summary Prompt Pack

## Test 1: Análisis con fixture CSV

**Input:** Usar `src/fixtures/costs-sample.csv` con Template A del prompt.

**Verificar:**
- [ ] Total Abril ≈ $2,578.44 USD (suma del fixture)
- [ ] Total Marzo ≈ $2,303.15 USD
- [ ] Variación calculada correctamente (~12%)
- [ ] Las 6 secciones presentes
- [ ] EC2 aparece como servicio principal

Estado: ☐ Pendiente

---

## Test 2: Datos insuficientes

**Input:** `Analiza nuestros costos. El mes pasado fue caro.`

**Verificar:**
- [ ] Respuesta indica "datos insuficientes"
- [ ] Especifica qué datos se necesitan
- [ ] No inventa cifras

Estado: ☐ Pendiente

---

## Test 3: Gasto bajo threshold

**Input:** Datos del fixture con `threshold=$5000`

**Verificar:**
- [ ] No genera alerta urgente
- [ ] Menciona que está dentro del threshold
- [ ] Igual genera acciones de optimización

Estado: ☐ Pendiente

| Test | Fecha | Por | Score /15 |
|------|-------|-----|-----------|
| T1-T3 | — | — | — |
