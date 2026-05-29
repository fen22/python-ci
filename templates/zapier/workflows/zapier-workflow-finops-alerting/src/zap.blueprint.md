# Zapier FinOps Alerting — Blueprint de implementación

> **Importante:** Zapier no permite exportar/importar Zaps desde archivos. Este documento es un blueprint paso a paso para construir el Zap manualmente en zapier.com. Sigue cada paso en orden.

---

## Resumen del Zap

**Propósito:** Enviar alertas a Slack (y email opcional) cuando el gasto en AWS supera un threshold o se detecta un incremento anormal respecto al período anterior.

**Trigger:** Schedule (diario o semanal)
**Acciones:**
1. Fetch costos de AWS Cost Explorer (via Webhooks by Zapier)
2. Formatear/filtrar datos (Code by Zapier)
3. Condición: ¿supera el threshold?
4. Enviar alerta a Slack
5. (Opcional) Enviar email de resumen

---

## Paso 1: Crear el Zap

1. Ir a [zapier.com](https://zapier.com) → **+ Create Zap**
2. Nombre: `FinOps Cost Alerting — [Tu empresa]`
3. Descripción: `Alerta cuando el gasto cloud supera el threshold configurado`

---

## Paso 2: Trigger — Schedule by Zapier

1. Buscar **Schedule by Zapier**
2. Seleccionar: **Every Week** (o **Every Day** para alertas diarias)
3. Configurar:
   - **Day of the week**: Monday
   - **Time of day**: 08:00 AM
   - **Timezone**: America/Mexico_City (o tu timezone)
4. Continuar → **Test trigger**

---

## Paso 3: Action — Webhooks by Zapier (GET → AWS Cost Explorer)

> Nota: AWS Cost Explorer requiere autenticación SigV4. La opción más simple es usar una Lambda Function como intermediario o una API Gateway que envuelva la llamada a AWS CE.

**Opción A (con Lambda intermediario — recomendada):**

1. Buscar **Webhooks by Zapier**
2. Seleccionar: **GET**
3. URL: `https://tu-api-gateway.amazonaws.com/prod/costs?period=monthly`
   - Esta URL debe ser tu Lambda/API Gateway que llama a `ce:GetCostAndUsage`
4. Headers:
   - `x-api-key`: (tu API key de API Gateway si aplica)
5. **Test action** → verificar que devuelve JSON con costos

**Opción B (sin AWS, usando CSV manual):**

1. Usar **Google Sheets** como trigger en lugar de Webhooks
2. Mantener un Google Sheet con costos actualizados manualmente
3. Trigger: **New or Updated Row in Google Sheets**

---

## Paso 4: Action — Code by Zapier (JavaScript)

1. Buscar **Code by Zapier**
2. Seleccionar: **Run JavaScript**
3. **Input data:**
   ```
   costData: {{3. Body}}
   threshold: 2000
   previousTotal: 0
   ```
4. **Code:**
   ```javascript
   const data = JSON.parse(inputData.costData || '{}');
   const threshold = parseFloat(inputData.threshold) || 2000;
   
   // Parsear respuesta de AWS Cost Explorer o API custom
   let totalCurrent = 0;
   let serviceBreakdown = '';
   
   if (data.ResultsByTime && data.ResultsByTime.length > 0) {
     const latest = data.ResultsByTime[data.ResultsByTime.length - 1];
     const groups = latest.Groups || [];
     
     const services = groups
       .map(g => ({ name: g.Keys[0], amount: parseFloat(g.Metrics.UnblendedCost.Amount) }))
       .sort((a, b) => b.amount - a.amount);
     
     totalCurrent = services.reduce((sum, s) => sum + s.amount, 0);
     serviceBreakdown = services.slice(0, 5)
       .map(s => `• ${s.name}: $${s.amount.toFixed(2)}`)
       .join('\n');
   } else if (data.total) {
     // Custom API format
     totalCurrent = parseFloat(data.total);
     serviceBreakdown = data.breakdown || 'No breakdown available';
   }
   
   const isOverThreshold = totalCurrent > threshold;
   const period = new Date().toLocaleDateString('es-MX', { month: 'long', year: 'numeric' });
   
   return {
     totalCurrent: totalCurrent.toFixed(2),
     threshold: threshold.toFixed(2),
     isOverThreshold: isOverThreshold ? 'yes' : 'no',
     serviceBreakdown: serviceBreakdown || 'No data',
     period: period,
     alertEmoji: isOverThreshold ? '🚨' : '✅',
     alertStatus: isOverThreshold ? 'SOBRE THRESHOLD' : 'Dentro del budget'
   };
   ```
5. **Test action** → verificar output

---

## Paso 5: Filter by Zapier (solo enviar si hay alerta)

1. Buscar **Filter by Zapier**
2. Condición: `isOverThreshold` **[Text] Exactly matches** `yes`
3. Esto asegura que Slack solo recibe alerta cuando hay problema

> Alternativa: Quitar este paso si quieres reporte semanal siempre, con o sin alerta.

---

## Paso 6: Action — Slack

1. Buscar **Slack**
2. Seleccionar: **Send Channel Message**
3. Conectar tu cuenta de Slack (OAuth)
4. Configurar:
   - **Channel**: `#finops-alerts` (o el canal que uses)
   - **Message text**:
     ```
     {{alertEmoji}} *FinOps Alert — {{period}}*
     
     Status: *{{alertStatus}}*
     Costo total: *${{totalCurrent}} USD* (threshold: ${{threshold}} USD)
     
     Top servicios:
     {{serviceBreakdown}}
     
     _Generado automáticamente por el Zap de FinOps Alerting_
     ```
   - **Bot name**: FinOps Bot
   - **Bot icon**: :money_with_wings:
5. **Test action** → verificar mensaje en Slack

---

## Paso 7 (Opcional): Action — Email by Zapier

1. Buscar **Email by Zapier** (o Gmail/Outlook si tienes la integración)
2. Seleccionar: **Send Email**
3. Configurar:
   - **To**: finops@tuempresa.com
   - **Subject**: `[FinOps Alert] Costo cloud {{period}} — {{alertStatus}}`
   - **Body**:
     ```
     Hola equipo,

     Resumen de costos cloud para {{period}}:

     Estado: {{alertStatus}}
     Total: ${{totalCurrent}} USD
     Threshold configurado: ${{threshold}} USD

     Top 5 servicios por costo:
     {{serviceBreakdown}}

     ---
     Este email fue generado automáticamente por el Zap de FinOps Alerting.
     ```

---

## Paso 8: Activar el Zap

1. Revisar todos los pasos → **Publish**
2. Toggle el Zap a **ON**
3. El primer trigger se ejecutará el próximo lunes a las 8am (si usaste esa configuración)

---

## Variables configurables

| Variable | Dónde configurar | Valor ejemplo |
|---|---|---|
| Frecuencia | Step 2 (Schedule) | Every Week, Monday 8am |
| AWS API URL | Step 3 (Webhooks) | URL de tu Lambda |
| Threshold USD | Step 4 (Code) → inputData | 2000 |
| Canal Slack | Step 6 | #finops-alerts |
| Email destino | Step 7 | finops@empresa.com |

---

## Manual Build Checklist

- [ ] Paso 1: Zap creado con nombre descriptivo
- [ ] Paso 2: Schedule configurado (día y hora)
- [ ] Paso 3: URL de costos funciona y devuelve JSON
- [ ] Paso 4: Code procesa el JSON correctamente (testear con output real)
- [ ] Paso 5: Filter solo deja pasar alertas reales
- [ ] Paso 6: Mensaje de Slack formateado correctamente
- [ ] Paso 7: Email opcional configurado (si aplica)
- [ ] Paso 8: Zap activo y primer test ejecutado

---

## Limitaciones de Zapier

- Zapier no tiene integración nativa con AWS Cost Explorer — requiere Lambda o API Gateway como intermediario.
- El plan gratuito de Zapier solo permite Zaps de 2 pasos. Este Zap de 6-7 pasos requiere plan **Starter** o superior.
- Los Zaps no son exportables como código — este blueprint es la única forma de documentar la implementación.
- Si el JSON de AWS CE cambia de formato, el Step 4 necesita actualización manual.

---

## Smoke test manual

Después de publicar el Zap:
1. En Zapier → **Run Zap** (botón de test manual)
2. Verificar en el historial que todos los pasos pasan
3. Verificar que el mensaje llegó a Slack
4. Para test de alerta: ajustar temporalmente el threshold a $0.01 y re-ejecutar
