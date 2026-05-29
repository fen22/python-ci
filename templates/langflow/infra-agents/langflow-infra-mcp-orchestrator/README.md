# Langflow Infra MCP Orchestrator

**Status:** `draft` — blueprint arquitectural. NO es plug-and-play. Las herramientas personalizadas (Custom Components) requieren implementación adicional.

Blueprint de un agente de infraestructura en Langflow que puede inspeccionar recursos cloud (AWS EC2, CloudWatch, Cost Explorer) y GitHub usando herramientas HTTP configurables. Incluye guardrails de solo lectura en el system prompt.

## Qué hace y qué NO hace

✅ **Qué documenta este template:**
- Arquitectura de un agente Langflow con múltiples herramientas de infra
- Guardrails de seguridad (read-only) en el system prompt
- Herramientas para EC2, CloudWatch, Cost Explorer, GitHub
- Integración con Claude como LLM

❌ **Qué NO hace (importante):**
- NO es importable y funcionable inmediatamente
- Los Custom Component nodes (EC2Tool, GitHubTool, etc.) son placeholders que requieren implementar la lógica HTTP real
- El soporte nativo de MCP en Langflow es experimental — este flow usa HTTP genérico como proxy
- NO ejecuta acciones destructivas (la guardrail en el system prompt lo previene)

## Arquitectura

```
[Safety System Prompt]
         ↓
[Chat Input] ──────────────────────► [Infra Agent (ReAct)]
                                      ↑        ↑
[EC2 Inspector Tool] ─────────────────┤        │
[GitHub PR Reader] ────────────────────┤       │
[CloudWatch Reader] ───────────────────┤       │
[Cost Explorer Reader] ─────────────────┘       │
[Claude LLM] ────────────────────────────────────┘
                                      ↓
                               [Chat Output]
```

## Requisitos para hacerlo funcional

### 1. Instalar Langflow
```bash
pip install langflow && langflow run
```

### 2. Importar el flow
UI → Load Flow → `src/flow.json`

### 3. Implementar Custom Components

Los nodos `EC2Tool`, `GitHubTool`, `CloudWatchTool` y `CostTool` son Custom Components que necesitan implementación. En Langflow, un Custom Component es una clase Python.

**Ejemplo de implementación del GitHub Tool:**

```python
from langflow.custom import CustomComponent
from langchain.tools import Tool
import requests

class GitHubPRReaderTool(CustomComponent):
    display_name = "GitHub PR Reader"
    description = "Read-only GitHub PR inspector"
    
    def build_config(self):
        return {
            "github_token": {"password": True},
            "repo_owner": {"display_name": "Repository Owner"},
            "repo_name": {"display_name": "Repository Name"}
        }
    
    def build(self, github_token: str, repo_owner: str, repo_name: str) -> Tool:
        def list_open_prs(query: str = "") -> str:
            headers = {
                "Authorization": f"Bearer {github_token}",
                "Accept": "application/vnd.github.v3+json"
            }
            resp = requests.get(
                f"https://api.github.com/repos/{repo_owner}/{repo_name}/pulls",
                headers=headers,
                params={"state": "open", "per_page": 10}
            )
            if resp.status_code != 200:
                return f"Error: {resp.status_code}"
            prs = resp.json()
            return "\n".join([f"PR #{p['number']}: {p['title']} by @{p['user']['login']}" for p in prs])
        
        return Tool(
            name="github_list_open_prs",
            func=list_open_prs,
            description="List open pull requests in the configured repository"
        )
```

### 4. Alternativa: Usar n8n como proxy

En lugar de implementar Custom Components complejos en Langflow:
1. Usar el template `n8n-chatbot-slack-engineering-docs` como referencia
2. Exponer los tools como webhooks de n8n
3. En Langflow, usar el componente `HTTPAPITool` apuntando a los webhooks de n8n

### 5. Configurar API keys

En el nodo `Claude LLM`:
- `anthropic_api_key`: tu API key de Anthropic

En cada tool (cuando los implementes):
- `github_token`: GitHub Fine-grained token (read-only)
- `infra_api_key`: API key para tu Lambda proxy de AWS

## Limitaciones de MCP en Langflow

Langflow 1.x tiene soporte experimental para MCP servers via el componente `MCPStdio`. Si tu versión lo soporta:

1. Usar `MCPStdio` en lugar de `CustomComponent`
2. Configurar el comando del MCP server (ej: `npx @modelcontextprotocol/server-github`)
3. Conectar al `AgentComponent`

Verificar disponibilidad: en el UI de Langflow, buscar "MCP" en la barra de componentes.

## Seguridad

El system prompt del agente incluye guardrails explícitos:
- Lista de acciones permitidas (solo lectura)
- Lista de acciones prohibidas (destructivas)
- Respuesta estandarizada cuando se pide una acción prohibida

Esto es una primera línea de defensa. Para producción, implementar también:
- IAM policies de solo lectura (ver `claude-mcp-infra-assistant/src/security-guardrails.md`)
- Validación en el Lambda proxy para rechazar llamadas destructivas
- Logging de todas las llamadas al agente
