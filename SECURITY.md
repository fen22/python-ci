# Seguridad

## Reporte de vulnerabilidades

Reporta problemas de seguridad a los maintainers del repositorio o al canal interno definido por ClickIT.

## Política de secretos

Este repositorio no debe contener secretos reales. Usa `.env.example` para documentar variables requeridas y almacena secretos en el proveedor adecuado: GitHub Secrets, vault corporativo, n8n credentials, Zapier connections o variables seguras del runtime.

## Revisión obligatoria

Todo template que toque infraestructura, datos internos, PII, costos cloud o sistemas de clientes debe incluir:

- clasificación de datos;
- permisos mínimos requeridos;
- evidencia de prueba;
- riesgos conocidos;
- mecanismo de rollback o desactivación.
