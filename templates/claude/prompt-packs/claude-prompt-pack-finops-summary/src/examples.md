# Examples — FinOps Summary Prompt Pack

## Ejemplo 1: Análisis con CSV dummy (incremento detectado)

**Input:**
```
Período actual: Abril 2025
Período anterior: Marzo 2025
Threshold: $2000 USD

Datos CSV:
ServiceName,TimePeriod,Amount,Unit
Amazon EC2,2025-04-01/2025-04-30,1245.78,USD
Amazon RDS,2025-04-01/2025-04-30,432.10,USD
Amazon EKS,2025-04-01/2025-04-30,567.90,USD
Amazon S3,2025-04-01/2025-04-30,87.34,USD
AWS Lambda,2025-04-01/2025-04-30,12.45,USD
Amazon CloudFront,2025-04-01/2025-04-30,34.22,USD
ServiceName,TimePeriod,Amount,Unit
Amazon EC2,2025-03-01/2025-03-31,1100.20,USD
Amazon RDS,2025-03-01/2025-03-31,398.50,USD
Amazon EKS,2025-03-01/2025-03-31,512.40,USD
Amazon S3,2025-03-01/2025-03-31,72.15,USD
AWS Lambda,2025-03-01/2025-03-31,10.80,USD
Amazon CloudFront,2025-03-01/2025-03-31,29.10,USD
```

**Respuesta esperada de Claude:**

```markdown
## 📊 Resumen Ejecutivo

El gasto cloud de Abril 2025 ascendió a **$2,379.79 USD**, representando un incremento del **11.1%** respecto a Marzo 2025 ($2,123.15 USD) y superando el threshold de alerta de $2,000 USD. Los servicios EC2, EKS y RDS concentran el 94% del gasto total.

## ⚠️ Anomalías Detectadas

| Servicio | Marzo | Abril | Variación | % |
|---|---|---|---|---|
| Amazon EC2 | $1,100.20 | $1,245.78 | +$145.58 | **+13.2%** |
| Amazon EKS | $512.40 | $567.90 | +$55.50 | **+10.8%** |
| Amazon RDS | $398.50 | $432.10 | +$33.60 | **+8.4%** |
| Amazon S3 | $72.15 | $87.34 | +$15.19 | **+21.0%** |

- S3 muestra el mayor incremento porcentual (+21%) aunque en valor absoluto es menor.
- Todos los servicios aumentaron — sugiere un crecimiento de carga general, no un outlier puntual.

## 🔍 Hipótesis de Causas

1. **Crecimiento de workload:** El incremento uniforme en EC2 + EKS (+12%) sugiere mayor tráfico o nuevos despliegues.
2. **Almacenamiento S3:** +21% puede indicar logs acumulados, backups sin lifecycle policy, o nuevos buckets sin configurar.
3. **RDS +8.4%:** Posible aumento de storage por crecimiento de base de datos o backup retention extendido.

## 🎯 Acciones Recomendadas

1. **[ALTA]** Revisar instancias EC2/EKS sin Reserved Instances o Savings Plans — potencial ahorro del 30-40%.
2. **[ALTA]** Implementar S3 Lifecycle Policies para logs y backups — objetivo reducir S3 a < $60/mes.
3. **[MEDIA]** Auditar RDS: verificar si el storage creció necesariamente o hay snapshots acumulados sin cleanup.
4. **[MEDIA]** Activar AWS Cost Anomaly Detection para alertas automáticas en tiempo real.

## 🚨 Riesgos si no se actúa

- La tendencia actual proyecta **~$2,600 USD en Mayo** si el crecimiento se mantiene al 11% mensual.
- Sin Savings Plans en EC2/EKS, se paga tarifa on-demand completa en el servicio de mayor costo.
- S3 sin lifecycle policy puede escalar descontroladamente con logs históricos.

## 📋 Datos de entrada utilizados

CSV con 6 servicios para Abril 2025 y 6 servicios para Marzo 2025. Total actual: $2,379.79 USD. Total anterior: $2,123.15 USD.
```

---

## Ejemplo 2: Datos insuficientes

**Input:**
```
Analiza nuestros costos de cloud. El mes pasado gastamos más.
```

**Respuesta esperada:**
```markdown
## 📊 Resumen Ejecutivo

Los datos proporcionados son insuficientes para generar un análisis FinOps confiable.

## 📋 Datos de entrada utilizados

Solo se recibió la información: "El mes pasado gastamos más." Sin cifras, servicios ni períodos definidos.

**Para generar un análisis útil, necesito:**
- Datos de costos desglosados por servicio (CSV, JSON o tabla)
- Período actual y período anterior para comparación
- Moneda y unidades (USD, EUR, etc.)

**Opción rápida:** Exporta el reporte de AWS Cost Explorer → Cost & Usage Reports → CSV y pégalo en el siguiente mensaje.
```

---

## Ejemplo 3: Costo bajo threshold (sin alerta)

**Input:**
```
Período: Marzo 2025 | Threshold: $5000

EC2: $980, RDS: $320, S3: $45, Lambda: $8
Total: $1,353 USD
Febrero: $1,280 USD
```

**Respuesta esperada:**
```markdown
## 📊 Resumen Ejecutivo

El gasto de Marzo 2025 fue de **$1,353 USD**, un incremento del **5.7%** respecto a Febrero ($1,280 USD), dentro del threshold de $5,000 USD. El gasto es saludable y EC2 concentra el 72% del total.

## ⚠️ Anomalías Detectadas

No se detectan anomalías significativas. El incremento de $73 USD (+5.7%) es consistente con crecimiento orgánico normal.

## 🔍 Hipótesis de Causas

Crecimiento orgánico estable. Sin datos adicionales de tags o proyectos, no es posible atribuir el incremento a una causa específica.

## 🎯 Acciones Recomendadas

1. **[BAJA]** Verificar si EC2 tiene cobertura de Reserved Instances para optimizar el costo base ($980/mes).
2. **[INFORMATIVA]** Activar tags de costo por proyecto/equipo para análisis más granular en próximos períodos.

## 🚨 Riesgos si no se actúa

No hay riesgo inmediato. Mantener monitoreo mensual.

## 📋 Datos de entrada utilizados

Texto libre con 4 servicios para Marzo y total de Febrero. Análisis aproximado.
```
