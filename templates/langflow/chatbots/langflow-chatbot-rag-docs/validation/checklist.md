# Checklist — Langflow RAG Docs Chatbot

## Estructura
- [ ] template.yaml válido
- [ ] flow.json es JSON válido con 8 nodos y 8 edges
- [ ] fixtures/dummy-docs.txt existe con contenido coherente
- [ ] README explica instalación de Langflow y pasos de importación
- [ ] Limitaciones de versión documentadas

## Funcionalidad (requiere Langflow instalado)
- [ ] Flow importa sin errores en Langflow 1.x
- [ ] 8 nodos visibles y conectados
- [ ] Fixture carga correctamente
- [ ] Pregunta del fixture retorna respuesta basada en docs
- [ ] Pregunta fuera de docs retorna "not found"

## Seguridad
- [ ] No hay API keys reales en flow.json
- [ ] .env.example usa PLACEHOLDER
