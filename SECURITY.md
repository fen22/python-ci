# Seguridad

Este repositorio no debe contener secretos reales.

Usa `.env.example` para documentar variables requeridas y almacena secretos en el proveedor adecuado: GitHub Secrets, vault corporativo, n8n credentials, Zapier connections o variables seguras del runtime.

Todo template que toque infraestructura, datos internos, PII, costos cloud o sistemas de clientes debe incluir clasificación de datos, permisos mínimos, evidencia de prueba, riesgos conocidos y mecanismo de rollback o desactivación.
