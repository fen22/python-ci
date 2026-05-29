#!/usr/bin/env bash
# ============================================================
# AI DevOps Bootstrap — macOS
# ClickIT Agentic Low-Code Templates
# ============================================================
# Instala herramientas de AI/DevOps en macOS.
# PIDE CONFIRMACIÓN antes de instalar cada grupo.
# NO instala nada sin aprobación explícita.
# NUNCA contiene secretos ni tokens.
# ============================================================

set -euo pipefail

# ---------- Colors ----------
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
info()    { echo -e "${BLUE}[INFO]${NC}  $1"; }
success() { echo -e "${GREEN}[OK]${NC}    $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC}  $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; }

# ---------- Helpers ----------
confirm() {
    local msg="$1"
    echo ""
    echo -e "${YELLOW}→ $msg${NC}"
    read -r -p "  ¿Instalar? [y/N] " response
    [[ "$response" =~ ^[yY]$ ]]
}

check_command() {
    command -v "$1" &>/dev/null
}

version_of() {
    "$1" --version 2>&1 | head -1
}

# ---------- Header ----------
echo ""
echo -e "${BLUE}============================================================${NC}"
echo -e "${BLUE}  AI DevOps Bootstrap — macOS                               ${NC}"
echo -e "${BLUE}  ClickIT Agentic Low-Code Templates                        ${NC}"
echo -e "${BLUE}============================================================${NC}"
echo ""
echo "Este script instalará herramientas de AI/DevOps en tu Mac."
echo "Se pedirá confirmación antes de instalar cada grupo."
echo ""
echo -e "${RED}Nota: Algunas instalaciones requieren contraseña de sudo.${NC}"
echo ""
read -r -p "¿Continuar? [y/N] " start
[[ "$start" =~ ^[yY]$ ]] || { echo "Abortado."; exit 0; }

# ---------- Homebrew ----------
if ! check_command brew; then
    if confirm "Homebrew (gestor de paquetes para macOS — requerido para el resto)"; then
        info "Instalando Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # Add to PATH for Apple Silicon
        if [[ -f "/opt/homebrew/bin/brew" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        success "Homebrew instalado: $(brew --version | head -1)"
    else
        error "Homebrew es requerido. Instálalo en https://brew.sh y re-ejecuta el script."
        exit 1
    fi
else
    success "Homebrew ya instalado: $(brew --version | head -1)"
fi

# ---------- Git ----------
if ! check_command git; then
    if confirm "Git (control de versiones — REQUERIDO)"; then
        brew install git
        success "Git instalado: $(version_of git)"
    fi
else
    success "Git ya instalado: $(version_of git)"
fi

# ---------- Python ----------
if ! check_command python3; then
    if confirm "Python 3.11+ (lenguaje para scripts y LLM apps)"; then
        brew install python@3.11
        success "Python instalado: $(version_of python3)"
    fi
else
    success "Python ya instalado: $(version_of python3)"
fi

# ---------- Node.js ----------
if ! check_command node; then
    if confirm "Node.js LTS (requerido para n8n, Claude Code y MCP servers)"; then
        brew install node@20
        brew link node@20 --force --overwrite 2>/dev/null || true
        success "Node.js instalado: $(version_of node)"
    fi
else
    success "Node.js ya instalado: $(version_of node)"
fi

# ---------- Docker ----------
if ! check_command docker; then
    if confirm "Docker Desktop (para correr n8n, Langflow y servicios locales)"; then
        warn "Descargando Docker Desktop... esto puede tardar varios minutos."
        brew install --cask docker
        warn "Abre Docker Desktop manualmente para completar la instalación."
        success "Docker Desktop instalado (requiere apertura manual)."
    fi
else
    success "Docker ya instalado: $(version_of docker)"
fi

# ---------- AWS CLI ----------
if ! check_command aws; then
    if confirm "AWS CLI v2 (para interactuar con servicios AWS — opcional)"; then
        brew install awscli
        success "AWS CLI instalado: $(aws --version)"
    fi
else
    success "AWS CLI ya instalado: $(aws --version)"
fi

# ---------- Claude Code ----------
if ! check_command claude; then
    if confirm "Claude Code CLI (asistente de IA para desarrollo — opcional)"; then
        info "Instalando Claude Code via npm..."
        npm install -g @anthropic-ai/claude-code
        success "Claude Code instalado: $(claude --version 2>/dev/null || echo 'ver -h para ayuda')"
    fi
else
    success "Claude Code ya instalado: $(claude --version 2>/dev/null || echo 'instalado')"
fi

# ---------- n8n local ----------
if confirm "n8n local vía Docker (plataforma de automatización — opcional)"; then
    if check_command docker; then
        info "Descargando imagen de n8n..."
        docker pull n8nio/n8n
        success "Imagen de n8n descargada."
        echo ""
        echo "Para iniciar n8n:"
        echo "  docker run -it --rm --name n8n -p 5678:5678 \\"
        echo "    -v ~/.n8n:/home/node/.n8n \\"
        echo "    n8nio/n8n"
        echo "  Luego abre: http://localhost:5678"
    else
        warn "Docker no está instalado. Instala Docker primero para correr n8n."
    fi
fi

# ---------- VS Code ----------
if ! check_command code; then
    if confirm "Visual Studio Code (editor — opcional, instala también Cursor si lo prefieres)"; then
        brew install --cask visual-studio-code
        success "VS Code instalado."
    fi
else
    success "VS Code ya instalado."
fi

# ---------- Smoke Test ----------
echo ""
echo -e "${BLUE}============================================================${NC}"
echo -e "${BLUE}  Smoke Test — Verificación de versiones instaladas         ${NC}"
echo -e "${BLUE}============================================================${NC}"
echo ""

print_version() {
    local name="$1"; local cmd="$2"
    if check_command "$cmd"; then
        echo -e "  ${GREEN}✓${NC} ${name}: $(version_of "$cmd")"
    else
        echo -e "  ${YELLOW}—${NC} ${name}: no instalado"
    fi
}

print_version "Git"     "git"
print_version "Python"  "python3"
print_version "Node.js" "node"
print_version "npm"     "npm"
print_version "Docker"  "docker"
print_version "AWS CLI" "aws"

if check_command claude; then
    echo -e "  ${GREEN}✓${NC} Claude Code: $(claude --version 2>/dev/null || echo 'instalado')"
else
    echo -e "  ${YELLOW}—${NC} Claude Code: no instalado"
fi

if check_command code; then
    echo -e "  ${GREEN}✓${NC} VS Code: instalado"
else
    echo -e "  ${YELLOW}—${NC} VS Code: no instalado"
fi

echo ""
echo -e "${GREEN}Bootstrap completado.${NC}"
echo ""
echo "Próximos pasos:"
echo "  1. Configurar Git: git config --global user.name 'Tu Nombre'"
echo "  2. Configurar Git: git config --global user.email 'tu@email.com'"
echo "  3. Crear API key en console.anthropic.com (para Claude Code)"
echo "  4. Ejecutar: claude auth login"
echo "  5. Revisar los templates en este repositorio para empezar"
echo ""
