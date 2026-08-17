#!/usr/bin/env bash
# boomer install script
# usage: curl -fsSL https://raw.githubusercontent.com/theophile-wallez/boomer/main/install.sh | bash

set -e

REPO="https://raw.githubusercontent.com/theophile-wallez/boomer/main/plugins/boomer-plugin/skills/boomer"
GITHUB_REPO="theophile-wallez/boomer"

# colors
RED='\033[0;31m'
PINK='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

echo ""
echo -e "${PINK}${BOLD}"
echo "  ██████╗  ██████╗  ██████╗ ███╗   ███╗███████╗██████╗ "
echo "  ██╔══██╗██╔═══██╗██╔═══██╗████╗ ████║██╔════╝██╔══██╗"
echo "  ██████╔╝██║   ██║██║   ██║██╔████╔██║█████╗  ██████╔╝"
echo "  ██╔══██╗██║   ██║██║   ██║██║╚██╔╝██║██╔══╝  ██╔══██╗"
echo "  ██████╔╝╚██████╔╝╚██████╔╝██║ ╚═╝ ██║███████╗██║  ██║"
echo "  ╚═════╝  ╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝"
echo -e "${NC}"
echo -e "${PINK}  Coucou ma Vero , c'est Natacha ✌️🥰👍💐${NC}"
echo ""

INSTALLED_AGENTS=()

fetch() {
  local url="$1" dest="$2"
  if command -v curl &>/dev/null; then
    curl -fsSL "$url" -o "$dest"
  elif command -v wget &>/dev/null; then
    wget -q "$url" -O "$dest"
  else
    echo -e "${RED}  ✗ curl/wget introuvable${NC}"
    return 1
  fi
}

install_skill_files() {
  local dest="$1"
  mkdir -p "$dest"
  fetch "$REPO/SKILL.md" "$dest/SKILL.md"
  fetch "$REPO/patois.md" "$dest/patois.md"
}

# --- Claude Code : plugin marketplace (officiel) ---
install_claude_code_plugin() {
  if command -v claude &>/dev/null; then
    echo -e "${CYAN}  Tentative install via /plugin marketplace (Claude Code natif)...${NC}"
    if claude plugin marketplace add "$GITHUB_REPO" 2>/dev/null && \
       claude plugin install "boomer-plugin@boomer" 2>/dev/null; then
      echo -e "${PINK}  ✓ Claude Code plugin ${NC}(marketplace officiel)"
      INSTALLED_AGENTS+=("Claude Code (plugin)")
      return 0
    fi
  fi
  return 1
}

# --- Claude Code : skills fallback ---
install_claude_code_skills() {
  local dest="$HOME/.claude/skills/boomer"
  install_skill_files "$dest"
  echo -e "${PINK}  ✓ Claude Code skills ${NC}→ $dest"
  INSTALLED_AGENTS+=("Claude Code (skills)")
}

install_claude_code() {
  install_claude_code_plugin || install_claude_code_skills
}

# --- Codex ---
install_codex() {
  local dest="$HOME/.agents/skills/boomer"
  install_skill_files "$dest"
  echo -e "${PINK}  ✓ Codex ${NC}→ $dest"
  INSTALLED_AGENTS+=("Codex")
}

# --- OpenCode ---
install_opencode() {
  local dest="$HOME/.config/opencode/skills/boomer"
  install_skill_files "$dest"
  echo -e "${PINK}  ✓ OpenCode ${NC}→ $dest"
  INSTALLED_AGENTS+=("OpenCode")
}

# --- Gemini CLI ---
install_gemini() {
  local dest="$HOME/.gemini/skills/boomer"
  install_skill_files "$dest"
  echo -e "${PINK}  ✓ Gemini CLI ${NC}→ $dest"
  INSTALLED_AGENTS+=("Gemini CLI")
}

echo -e "${CYAN}  Détection des agents...${NC}"
echo ""

if [ -d "$HOME/.claude" ] || command -v claude &>/dev/null; then
  install_claude_code
fi

if [ -d "$HOME/.agents" ] || command -v codex &>/dev/null; then
  install_codex
fi

if [ -d "$HOME/.gemini" ] || command -v gemini &>/dev/null; then
  install_gemini
fi

if [ -d "$HOME/.config/opencode" ] || command -v opencode &>/dev/null; then
  install_opencode
fi

# fallback si rien détecté
if [ ${#INSTALLED_AGENTS[@]} -eq 0 ]; then
  echo -e "${CYAN}  Aucun agent détecté — installation Claude Code par défaut${NC}"
  install_claude_code_skills
fi

echo ""
echo -e "${PINK}${BOLD}  boomer installé 🥰💐${NC}"
echo ""
echo -e "  Agents installés :"
for agent in "${INSTALLED_AGENTS[@]}"; do
  echo -e "  ${PINK}•${NC} $agent"
done
echo ""
echo -e "  ${BOLD}Activation :${NC} tape ${CYAN}/boomer${NC} ou dis ${CYAN}\"active boomer\"${NC}"
echo -e "  ${BOLD}Désactivation :${NC} dis ${CYAN}\"stop boomer\"${NC} ou ${CYAN}\"mode normal\"${NC}"
echo ""
echo -e "  Bisous à Patrick et aux petits loulous 😘💐"
echo -e "  PS : n'oublie pas le plat à gratin de 2019 😂😂😂"
echo ""
