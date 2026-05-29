# ============================================================
# AI DevOps Bootstrap — Windows (PowerShell)
# ClickIT Agentic Low-Code Templates
# ============================================================
# Instala herramientas de AI/DevOps en Windows.
# PIDE CONFIRMACIÓN antes de instalar cada herramienta.
# NO instala nada sin aprobación explícita.
# NUNCA contiene secretos ni tokens.
#
# Requisito: PowerShell 5.1+ o PowerShell 7+
# Ejecutar con: Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
# ============================================================

#Requires -Version 5.1

$ErrorActionPreference = "Stop"

# ---------- Colors & Helpers ----------
function Write-Info    { param($msg) Write-Host "[INFO]  $msg" -ForegroundColor Cyan }
function Write-Success { param($msg) Write-Host "[OK]    $msg" -ForegroundColor Green }
function Write-Warn    { param($msg) Write-Host "[WARN]  $msg" -ForegroundColor Yellow }
function Write-Err     { param($msg) Write-Host "[ERROR] $msg" -ForegroundColor Red }

function Confirm-Install {
    param([string]$ToolName)
    Write-Host ""
    Write-Host "→ $ToolName" -ForegroundColor Yellow
    $response = Read-Host "  ¿Instalar? [y/N]"
    return ($response -match '^[yY]$')
}

function Test-Command {
    param([string]$Name)
    return [bool](Get-Command $Name -ErrorAction SilentlyContinue)
}

# ---------- Header ----------
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  AI DevOps Bootstrap — Windows                            " -ForegroundColor Cyan
Write-Host "  ClickIT Agentic Low-Code Templates                       " -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Este script instalará herramientas de AI/DevOps en Windows."
Write-Host "Se pedirá confirmación antes de cada instalación."
Write-Host ""
Write-Host "IMPORTANTE: Algunas herramientas requieren reiniciar la terminal" -ForegroundColor Yellow
Write-Host "           o el equipo después de instalar." -ForegroundColor Yellow
Write-Host ""
$start = Read-Host "¿Continuar? [y/N]"
if ($start -notmatch '^[yY]$') { Write-Host "Abortado."; exit 0 }

# ---------- Winget check ----------
if (-not (Test-Command "winget")) {
    Write-Warn "winget no encontrado. Instala 'App Installer' desde Microsoft Store."
    Write-Warn "URL: https://aka.ms/getwinget"
    Write-Warn "Continuando con las herramientas disponibles..."
}

# ---------- Git ----------
if (-not (Test-Command "git")) {
    if (Confirm-Install "Git for Windows") {
        Write-Info "Instalando Git..."
        if (Test-Command "winget") {
            winget install --id Git.Git -e --source winget --silent --accept-package-agreements --accept-source-agreements
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        } else {
            Write-Warn "winget no disponible. Descarga Git desde: https://git-scm.com/download/win"
        }
        Write-Success "Git instalado."
    }
} else {
    $gitVer = git --version
    Write-Success "Git ya instalado: $gitVer"
}

# ---------- Python ----------
if (-not (Test-Command "python")) {
    if (Confirm-Install "Python 3.12+") {
        Write-Info "Instalando Python 3.12..."
        if (Test-Command "winget") {
            winget install --id Python.Python.3.12 -e --source winget --silent --accept-package-agreements --accept-source-agreements
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        } else {
            Write-Warn "winget no disponible. Descarga Python desde: https://www.python.org/downloads/"
        }
        Write-Success "Python instalado."
    }
} else {
    $pyVer = python --version
    Write-Success "Python ya instalado: $pyVer"
}

# ---------- Node.js ----------
if (-not (Test-Command "node")) {
    if (Confirm-Install "Node.js LTS (requerido para n8n, Claude Code y MCP servers)") {
        Write-Info "Instalando Node.js LTS..."
        if (Test-Command "winget") {
            winget install --id OpenJS.NodeJS.LTS -e --source winget --silent --accept-package-agreements --accept-source-agreements
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        } else {
            Write-Warn "winget no disponible. Descarga Node.js desde: https://nodejs.org/en/download/"
        }
        Write-Success "Node.js instalado."
    }
} else {
    $nodeVer = node --version
    Write-Success "Node.js ya instalado: $nodeVer"
}

# ---------- Docker Desktop ----------
if (-not (Test-Command "docker")) {
    if (Confirm-Install "Docker Desktop (para correr n8n, Langflow localmente)") {
        Write-Info "Instalando Docker Desktop..."
        Write-Warn "Docker Desktop requiere reiniciar el equipo para completar la instalación."
        if (Test-Command "winget") {
            winget install --id Docker.DockerDesktop -e --source winget --accept-package-agreements --accept-source-agreements
        } else {
            Write-Warn "Descarga Docker Desktop desde: https://docs.docker.com/desktop/install/windows-install/"
        }
        Write-Success "Docker Desktop instalado. Reinicia el equipo para completar."
    }
} else {
    $dockerVer = docker --version
    Write-Success "Docker ya instalado: $dockerVer"
}

# ---------- AWS CLI ----------
if (-not (Test-Command "aws")) {
    if (Confirm-Install "AWS CLI v2 (opcional, para interactuar con servicios AWS)") {
        Write-Info "Instalando AWS CLI..."
        if (Test-Command "winget") {
            winget install --id Amazon.AWSCLI -e --source winget --silent --accept-package-agreements --accept-source-agreements
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        } else {
            Write-Warn "Descarga AWS CLI desde: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html"
        }
        Write-Success "AWS CLI instalado."
    }
} else {
    Write-Success "AWS CLI ya instalado: $(aws --version)"
}

# ---------- Claude Code ----------
if (-not (Test-Command "claude")) {
    if (Confirm-Install "Claude Code CLI (asistente AI — requiere Node.js)") {
        if (Test-Command "npm") {
            Write-Info "Instalando Claude Code..."
            npm install -g @anthropic-ai/claude-code
            Write-Success "Claude Code instalado."
        } else {
            Write-Warn "npm no está disponible. Instala Node.js primero."
        }
    }
} else {
    Write-Success "Claude Code ya instalado."
}

# ---------- n8n local ----------
if (Confirm-Install "n8n local vía Docker (plataforma de automatización — opcional)") {
    if (Test-Command "docker") {
        Write-Info "Descargando imagen de n8n..."
        docker pull n8nio/n8n
        Write-Success "Imagen de n8n descargada."
        Write-Host ""
        Write-Host "Para iniciar n8n (ejecutar en PowerShell):" -ForegroundColor Cyan
        Write-Host '  docker run -it --rm --name n8n -p 5678:5678 -v $HOME\.n8n:/home/node/.n8n n8nio/n8n'
        Write-Host "  Luego abre: http://localhost:5678" -ForegroundColor Cyan
    } else {
        Write-Warn "Docker no está instalado. Instala Docker Desktop primero."
    }
}

# ---------- VS Code ----------
if (-not (Test-Command "code")) {
    if (Confirm-Install "Visual Studio Code (editor — opcional)") {
        if (Test-Command "winget") {
            winget install --id Microsoft.VisualStudioCode -e --source winget --silent --accept-package-agreements --accept-source-agreements
        } else {
            Write-Warn "Descarga VS Code desde: https://code.visualstudio.com/download"
        }
        Write-Success "VS Code instalado."
    }
} else {
    Write-Success "VS Code ya instalado."
}

# ---------- Smoke Test ----------
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  Smoke Test — Verificación de versiones instaladas         " -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

$tools = @(
    @{ Name = "Git";        Cmd = "git";    Args = "--version" },
    @{ Name = "Python";     Cmd = "python"; Args = "--version" },
    @{ Name = "Node.js";    Cmd = "node";   Args = "--version" },
    @{ Name = "npm";        Cmd = "npm";    Args = "--version" },
    @{ Name = "Docker";     Cmd = "docker"; Args = "--version" },
    @{ Name = "AWS CLI";    Cmd = "aws";    Args = "--version" },
    @{ Name = "Claude Code";Cmd = "claude"; Args = "--version" }
)

foreach ($tool in $tools) {
    if (Test-Command $tool.Cmd) {
        try {
            $ver = & $tool.Cmd $tool.Args 2>&1 | Select-Object -First 1
            Write-Host "  ✓ $($tool.Name): $ver" -ForegroundColor Green
        } catch {
            Write-Host "  ✓ $($tool.Name): instalado" -ForegroundColor Green
        }
    } else {
        Write-Host "  — $($tool.Name): no instalado" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Bootstrap completado." -ForegroundColor Green
Write-Host ""
Write-Host "Próximos pasos:"
Write-Host "  1. Configurar Git:"
Write-Host "       git config --global user.name 'Tu Nombre'"
Write-Host "       git config --global user.email 'tu@email.com'"
Write-Host "  2. Crear API key en https://console.anthropic.com"
Write-Host "  3. Autenticar Claude Code: claude auth login"
Write-Host "  4. Revisar los templates en este repositorio"
Write-Host ""
