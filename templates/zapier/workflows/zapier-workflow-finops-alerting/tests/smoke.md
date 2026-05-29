# Smoke Test — Zapier FinOps Alerting Blueprint

> No es posible hacer smoke test automatizado — Zapier requiere configuración manual. Este documento es la checklist de verificación post-implementación.

## Verificación del blueprint (sin Zapier)

**Test 1: Blueprint completo**
- [ ] `src/zap.blueprint.md` tiene los 8 pasos documentados
- [ ] Cada paso tiene configuración exacta (campos a completar)
- [ ] El snippet JavaScript es sintácticamente válido
- [ ] Las limitaciones están documentadas

```bash
# Verificar que el JavaScript del Step 4 es válido:
node -e "
const inputData = { costData: JSON.stringify({ ResultsByTime: [{ TimePeriod: { Start: '2025-04-01', End: '2025-04-30' }, Groups: [{ Keys: ['Amazon EC2'], Metrics: { UnblendedCost: { Amount: '1245.78', Unit: 'USD' } } }] }] }), threshold: 2000 };
const data = JSON.parse(inputData.costData || '{}');
const threshold = parseFloat(inputData.threshold) || 2000;
let totalCurrent = 0;
if (data.ResultsByTime && data.ResultsByTime.length > 0) {
  const latest = data.ResultsByTime[data.ResultsByTime.length - 1];
  const services = (latest.Groups || []).map(g => ({ name: g.Keys[0], amount: parseFloat(g.Metrics.UnblendedCost.Amount) })).sort((a, b) => b.amount - a.amount);
  totalCurrent = services.reduce((sum, s) => sum + s.amount, 0);
}
const isOverThreshold = totalCurrent > threshold;
console.log('Total:', totalCurrent.toFixed(2), '| Over threshold:', isOverThreshold);
"
```
Estado: ☐ Pendiente

## Verificación post-implementación en Zapier

**Test 2: Run manual del Zap**
1. Implementar el Zap en zapier.com siguiendo el blueprint
2. Hacer clic en **Run Zap** (test manual)
3. Verificar en el historial de Zapier que todos los steps pasan verde
4. Verificar que el mensaje llega a Slack

Estado: ☐ Pendiente

**Test 3: Test de alerta con threshold bajo**
1. Cambiar temporalmente el threshold en Step 4 a `0.01`
2. Re-ejecutar manualmente
3. Verificar que el Filter pasa (isOverThreshold=yes)
4. Verificar mensaje de alerta en Slack con emoji 🚨
5. Restaurar el threshold original

Estado: ☐ Pendiente

| Test | Fecha | Por | Resultado |
|------|-------|-----|-----------|
| T1 (JS válido) | — | — | ☐ |
| T2 (run Zapier) | — | — | ☐ |
| T3 (threshold test) | — | — | ☐ |
