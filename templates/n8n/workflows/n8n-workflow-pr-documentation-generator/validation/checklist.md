# Checklist de validación — PR Documentation Generator

## Estructura
- [ ] template.yaml válido (pasa validate.py)
- [ ] README.md completo con pasos de setup
- [ ] .env.example con todas las variables
- [ ] src/workflow.json es JSON válido
- [ ] src/fixtures/pr-diff-dummy.json existe
- [ ] tests/smoke.md tiene tests ejecutables
- [ ] validation/evidence.json actualizado

## Funcionalidad
- [ ] Workflow importa en n8n sin errores
- [ ] Filtro de eventos (solo opened/synchronize) funciona
- [ ] GitHub API devuelve archivos del PR correctamente
- [ ] Contexto se construye correctamente en el Code node
- [ ] LLM genera las 5 secciones requeridas
- [ ] Comentario se publica en el PR

## Seguridad
- [ ] No hay tokens reales en archivos
- [ ] GitHub Token tiene mínimos permisos necesarios
- [ ] El workflow no almacena código fuente del PR
