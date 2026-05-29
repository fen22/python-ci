# Claude MCP Infra Assistant

**Status:** `draft` — configuración de ejemplo lista, requiere adaptación a infraestructura real.

Configuración base para usar Claude Code como asistente de infraestructura vía MCP (Model Context Protocol). Permite a Claude inspeccionar recursos cloud, leer repositorios de infra, consultar métricas y responder preguntas sobre el estado de la infraestructura.

**Principio de seguridad:** **Read-only por defecto.** Cualquier acción que modifique recursos requiere aprobación humana explícita fuera de Claude.

## Qué puede hacer este asistente

✅ **Sí hace:**
- Listar y describir instancias EC2, RDS, EKS, S3 buckets
- Leer métricas de CloudWatch y alarmas activas
- Analizar costos de AWS Cost Explorer
- Leer PRs e issues de GitHub
- Leer archivos de configuración de infraestructura (Terraform, Helm, etc.)
- Buscar documentación y CVEs en internet
- Responder preguntas sobre el estado actual de la infra

❌ **No hace (bloqueado):**
- Terminar, detener o modificar instancias
- Eliminar recursos
- Modificar security groups o IAM policies
- Leer secrets de AWS Secrets Manager o SSM
- Hacer push o merge en repositorios
- Ejecutar comandos en servidores remotos

## Archivos incluidos

| Archivo | Descripción |
|---|---|
| `src/mcp-config.example.json` | Configuración MCP completa con anotaciones |
| `src/security-guardrails.md` | IAM policy mínima, scopes de GitHub, checklist |

## Setup en Claude Code

### 1. Instalar MCP servers necesarios

```bash
# Filesystem (read-only)
npm install -g @modelcontextprotocol/server-filesystem

# GitHub
npm install -g @modelcontextprotocol/server-github

# Brave Search (opcional)
npm install -g @modelcontextprotocol/server-brave-search
```

### 2. Configurar credentials

```bash
# Copiar el ejemplo
cp src/mcp-config.example.json ~/.claude/mcp.json

# Editar con tus valores (NUNCA commitear ~/.claude/mcp.json)
nano ~/.claude/mcp.json
```

Reemplazar los PLACEHOLDER con:
- `PLACEHOLDER_GITHUB_TOKEN`: Tu GitHub Fine-grained token (scopes: read-only repo)
- `PLACEHOLDER_AWS_KEY`: AWS Access Key ID con IAM policy de solo lectura (ver security-guardrails.md)
- `PLACEHOLDER_AWS_SECRET`: AWS Secret Key correspondiente
- `PLACEHOLDER_BRAVE_KEY`: Brave Search API key (gratis en brave.com/search/api/)
- `/path/to/infra/repo`: Path local de tu repositorio de infraestructura

### 3. Configurar Claude Code

```bash
# En tu proyecto o globalmente:
claude config set mcpConfigPath ~/.claude/mcp.json
```

### 4. Verificar que funciona

```bash
# En Claude Code, preguntar:
claude "¿Cuántos MCP servers tengo configurados y cuáles son?"
```

### 5. Probar con preguntas seguras

```
¿Qué instancias EC2 hay corriendo en us-east-1?
¿Cuáles son los PRs abiertos en el repo org/infra?
¿Hay alarmas activas en CloudWatch?
```

## Configuración de aprobación humana

Para acciones que podrían modificar infraestructura, usar este flujo:

1. Claude identifica la acción y la propone
2. El ingeniero revisa en la herramienta de change management (Jira, Linear, etc.)
3. La acción se ejecuta manualmente o via pipeline aprobado
4. Claude no ejecuta cambios directamente

## Limitaciones conocidas

- El MCP server de AWS (`@modelcontextprotocol/server-aws-kb-retrieval`) está orientado a Knowledge Bases, no a describe general. Para describe de recursos AWS, puede requerir un MCP server custom o llamadas HTTP directas.
- Claude Code MCP está en evolución. Verificar compatibilidad de versiones antes de instalar.
- Este template no incluye MCP servers para Kubernetes, Terraform state, o Datadog. Agregar según necesidad.
- La IAM policy explícitamente deniega `secretsmanager:GetSecretValue` — el asistente nunca puede leer secrets.
- Status `draft`: no probado con infraestructura real de producción.
