# AI DevOps Bootstrap — macOS + Windows

**Status:** `draft` — scripts probados estructuralmente, requieren validación en máquina real.

Scripts de bootstrap para configurar un entorno de desarrollo AI/DevOps desde cero. Compatibles con macOS (via Homebrew) y Windows (via winget). Piden confirmación antes de instalar cada herramienta.

## Herramientas que instala

| Herramienta | macOS | Windows | Notas |
|---|---|---|---|
| Homebrew / winget | ✓ (gestor) | ✓ (gestor) | Gestor de paquetes del sistema |
| Git | ✓ | ✓ | Control de versiones |
| Python 3.11+ | ✓ | ✓ | Para scripts y LLM apps |
| Node.js LTS | ✓ | ✓ | Para n8n, Claude Code, MCP servers |
| Docker Desktop | ✓ | ✓ | Para correr servicios localmente |
| AWS CLI v2 | ✓ | ✓ | Opcional — para interactuar con AWS |
| Claude Code CLI | ✓ | ✓ | Opcional — asistente AI de desarrollo |
| n8n (Docker) | ✓ | ✓ | Opcional — plataforma de automatización |
| VS Code | ✓ | ✓ | Opcional — editor de código |

## Uso

### macOS

```bash
# 1. Dar permisos de ejecución
chmod +x src/bootstrap-macos.sh

# 2. Ejecutar
./src/bootstrap-macos.sh
```

El script pedirá confirmación para cada herramienta. Puedes instalar solo las que necesitas.

### Windows (PowerShell)

```powershell
# 1. Habilitar scripts (si no está habilitado)
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned

# 2. Ejecutar
.\src\bootstrap-windows.ps1
```

> Ejecutar PowerShell como Administrador si winget requiere permisos elevados.

## Notas por herramienta

### Docker Desktop
- macOS: requiere abrir Docker Desktop manualmente tras la instalación
- Windows: requiere reiniciar el equipo

### Claude Code
- Requiere Node.js instalado previamente
- Requiere una API key de Anthropic (console.anthropic.com)
- Después de instalar: `claude auth login`

### n8n local (Docker)
```bash
# macOS/Linux
docker run -it --rm --name n8n -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  n8nio/n8n

# Windows (PowerShell)
docker run -it --rm --name n8n -p 5678:5678 `
  -v $HOME\.n8n:/home/node/.n8n `
  n8nio/n8n
```
Acceder en: http://localhost:5678

## Verificación post-instalación (smoke test)

```bash
# Ejecutar este comando para ver las versiones instaladas:
git --version && python3 --version && node --version && npm --version && docker --version
```

El script de bootstrap ya incluye este smoke test al final de la ejecución.

## Limitaciones

- Los scripts instalan versiones estables/LTS — no las últimas versiones de desarrollo.
- Windows: `winget` debe estar disponible (incluido en Windows 10/11 recientes). Si no está, los pasos de descarga manual están documentados en el script.
- macOS: Apple Silicon (M1/M2/M3) y Intel son compatibles vía Homebrew.
- Los scripts NO configuran credenciales de AWS, GitHub ni Anthropic — solo instalan las herramientas.
- Status `draft`: probados estructuralmente pero no ejecutados en una máquina limpia de producción.
