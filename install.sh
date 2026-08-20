#!/usr/bin/env bash
# Persona AI — installateur de persona 🎭
#
# Tout installer :
#   curl -fsSL https://raw.githubusercontent.com/theophile-wallez/persona-ai/main/install.sh | bash
#
# Installer un persona, ou un thème :
#   curl -fsSL .../install.sh | bash -s -- jacqueline
#   curl -fsSL .../install.sh | bash -s -- --theme boomer
#
# Voir la bibliothèque :
#   curl -fsSL .../install.sh | bash -s -- --list

set -e

# PERSONA_AI_REPO et PERSONA_AI_BASE servent aux forks et aux tests
GITHUB_REPO="${PERSONA_AI_REPO:-theophile-wallez/persona-ai}"
RAW_BASE="${PERSONA_AI_BASE:-https://raw.githubusercontent.com/$GITHUB_REPO/main}"
MARKETPLACE="persona-ai"

# couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
PINK='\033[0;35m'
CYAN='\033[0;36m'
GREY='\033[0;90m'
NC='\033[0m'
BOLD='\033[1m'

# options
MODE="install"
WANTED=""
WANTED_THEMES=""
AGENT_FILTER="auto"
USE_PLUGIN="auto"
TMPDIR_PA=""

AGENT_NAMES=()
AGENT_ROOTS=()
INSTALLED=()
REMOVED_LEGACY=0

cleanup() {
  local status=$?
  if [ -n "$TMPDIR_PA" ]; then rm -rf "$TMPDIR_PA"; fi
  exit $status
}
trap cleanup EXIT

banner() {
  echo ""
  echo -e "${PINK}${BOLD}"
  echo "  ██████╗ ███████╗██████╗ ███████╗ ██████╗ ███╗   ██╗ █████╗ "
  echo "  ██╔══██╗██╔════╝██╔══██╗██╔════╝██╔═══██╗████╗  ██║██╔══██╗"
  echo "  ██████╔╝█████╗  ██████╔╝███████╗██║   ██║██╔██╗ ██║███████║"
  echo "  ██╔═══╝ ██╔══╝  ██╔══██╗╚════██║██║   ██║██║╚██╗██║██╔══██║"
  echo "  ██║     ███████╗██║  ██║███████║╚██████╔╝██║ ╚████║██║  ██║"
  echo "  ╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝"
  echo -e "${NC}"
  echo -e "${CYAN}  Persona AI 🎭 — une bibliothèque de persona pour ton agent${NC}"
  echo ""
}

usage() {
  cat <<'EOF'
Persona AI — installateur 🎭

USAGE
  install.sh [options] [persona|thème ...]

EXEMPLES
  install.sh                       installe tous les persona
  install.sh jacqueline            installe un persona
  install.sh boomer                installe un thème complet
  install.sh --theme boomer,kawaii installe deux thèmes
  install.sh --list                affiche la bibliothèque
  install.sh --themes              affiche les thèmes
  install.sh --uninstall jose      supprime un persona
  install.sh --uninstall --all     supprime tout

OPTIONS
  --all                installe tout (valeur par défaut)
  -t, --theme <liste>  thèmes séparés par une virgule
  -l, --list           affiche les persona par thème, puis sort
      --themes         affiche les thèmes, puis sort
  -a, --agent <nom>    claude | codex | gemini | opencode | all (défaut : détection)
  -u, --uninstall      supprime au lieu d'installer
      --skills-only    ignore le plugin marketplace de Claude Code
  -h, --help           affiche cette aide

Un argument sans tiret est un identifiant de persona, ou un identifiant de thème.

AGENTS ET DOSSIERS
  claude     ~/.claude/skills/<persona>
  codex      ~/.agents/skills/<persona>
  gemini     ~/.gemini/skills/<persona>
  opencode   ~/.config/opencode/skills/<persona>
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help) usage; exit 0 ;;
    -l|--list) MODE="list" ;;
    --themes) MODE="themes" ;;
    -u|--uninstall) MODE="uninstall" ;;
    --all) WANTED=""; WANTED_THEMES="" ;;
    --skills-only) USE_PLUGIN="no" ;;
    -t|--theme)
      shift
      [ $# -gt 0 ] || { echo -e "${RED}  ✗ --theme attend un nom${NC}"; exit 1; }
      WANTED_THEMES="$WANTED_THEMES $(echo "$1" | tr ',' ' ')"
      ;;
    --theme=*) WANTED_THEMES="$WANTED_THEMES $(echo "${1#*=}" | tr ',' ' ')" ;;
    -a|--agent)
      shift
      [ $# -gt 0 ] || { echo -e "${RED}  ✗ --agent attend un nom${NC}"; exit 1; }
      AGENT_FILTER="$1"
      ;;
    --agent=*) AGENT_FILTER="${1#*=}" ;;
    -*) echo -e "${RED}  ✗ option inconnue : $1${NC}"; usage; exit 1 ;;
    *) WANTED="$WANTED $1" ;;
  esac
  shift
done

fetch() {
  local url="$1" dest="$2"
  if command -v curl &>/dev/null; then
    curl -fsSL "$url" -o "$dest"
  elif command -v wget &>/dev/null; then
    wget -q "$url" -O "$dest"
  else
    echo -e "${RED}  ✗ curl et wget sont introuvables${NC}"
    return 1
  fi
}

# --- source : copie locale du dépôt, sinon GitHub ---
SCRIPT_DIR=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

LOCAL_MODE="no"
REGISTRY=""
if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/personas/registry.json" ]; then
  LOCAL_MODE="yes"
  REGISTRY="$SCRIPT_DIR/personas/registry.json"
else
  TMPDIR_PA="$(mktemp -d)"
  REGISTRY="$TMPDIR_PA/registry.json"
  fetch "$RAW_BASE/personas/registry.json" "$REGISTRY" || {
    echo -e "${RED}  ✗ la bibliothèque est inaccessible${NC}"
    exit 1
  }
fi

# --- registre → une ligne par persona ---
# thème|titre du thème|id|skill|titre|résumé|fichiers|état|anciens noms
read_registry() {
  awk '
    function val(line) {
      sub(/^[^:]*:[[:space:]]*/, "", line)
      sub(/^"/, "", line)
      sub(/",?[[:space:]]*$/, "", line)
      return line
    }
    /"theme"[[:space:]]*:/         { theme = val($0); next }
    /"theme_title"[[:space:]]*:/   { theme_title = val($0); next }
    /"theme_tagline"[[:space:]]*:/ { next }
    /"id"[[:space:]]*:/            { id = val($0); next }
    /"skill"[[:space:]]*:/         { skill = val($0); next }
    /"title"[[:space:]]*:/         { title = val($0); next }
    /"tagline"[[:space:]]*:/       { tagline = val($0); next }
    /"files"[[:space:]]*:/         { files = val($0); next }
    /"status"[[:space:]]*:/        { status = val($0); next }
    /"legacy"[[:space:]]*:/        { legacy = val($0); next }
    /^[[:space:]]*}/ {
      if (id != "") {
        if (skill == "") skill = id
        if (files == "") files = "SKILL.md"
        printf "%s|%s|%s|%s|%s|%s|%s|%s|%s\n", theme, theme_title, id, skill, title, tagline, files, status, legacy
      }
      id=""; skill=""; title=""; tagline=""; files=""; status=""; legacy=""
    }
  ' "$REGISTRY"
}

read_themes() {
  awk '
    function val(line) {
      sub(/^[^:]*:[[:space:]]*/, "", line)
      sub(/^"/, "", line)
      sub(/",?[[:space:]]*$/, "", line)
      return line
    }
    /"theme"[[:space:]]*:/         { theme = val($0); next }
    /"theme_title"[[:space:]]*:/   { title = val($0); next }
    /"theme_tagline"[[:space:]]*:/ { printf "%s|%s|%s\n", theme, title, val($0); next }
  ' "$REGISTRY"
}

field() { echo "$1" | cut -d'|' -f"$2"; }

ALL_IDS="$(read_registry | cut -d'|' -f3 | tr '\n' ' ')"
ALL_THEMES="$(read_themes | cut -d'|' -f1 | tr '\n' ' ')"

contains() {
  local needle="$1" list="$2" item
  # la liste est une chaîne séparée par des espaces : la découpe est voulue
  for item in $list; do
    [ "$item" = "$needle" ] && return 0
  done
  return 1
}

# --- listes ---
if [ "$MODE" = "themes" ]; then
  banner
  echo -e "  ${BOLD}Thèmes${NC}"
  echo ""
  while IFS= read -r line; do
    [ -n "$line" ] || continue
    t="$(field "$line" 1)"
    count=0
    for id in $(read_registry | awk -F'|' -v t="$t" '$1 == t { print $3 }'); do
      count=$((count + 1))
    done
    printf "  ${PINK}%-10s${NC} ${BOLD}%s${NC} ${GREY}— %s persona${NC}\n" "$t" "$(field "$line" 2)" "$count"
    printf "  %-10s ${GREY}%s${NC}\n\n" "" "$(field "$line" 3)"
  done <<EOF
$(read_themes)
EOF
  echo -e "  Installer un thème : ${CYAN}install.sh --theme <thème>${NC}"
  echo ""
  exit 0
fi

if [ "$MODE" = "list" ]; then
  banner
  for t in $ALL_THEMES; do
    t_title="$(read_themes | awk -F'|' -v t="$t" '$1 == t { print $2 }')"
    echo -e "  ${BOLD}${t_title}${NC} ${GREY}(--theme $t)${NC}"
    echo ""
    while IFS= read -r line; do
      [ -n "$line" ] || continue
      printf "    ${PINK}%-12s${NC} ${BOLD}%s${NC} ${GREY}(%s)${NC}\n" \
        "$(field "$line" 3)" "$(field "$line" 5)" "$(field "$line" 8)"
      printf "    %-12s ${GREY}%s${NC}\n\n" "" "$(field "$line" 6)"
    done <<EOF
$(read_registry | awk -F'|' -v t="$t" '$1 == t')
EOF
  done
  echo -e "  Un persona : ${CYAN}install.sh <persona>${NC}   ·   Un thème : ${CYAN}install.sh --theme <thème>${NC}   ·   Tout : ${CYAN}install.sh${NC}"
  echo ""
  exit 0
fi

# --- sélection : persona, thèmes, ou tout ---
SELECTED_IDS=""
SELECTED_THEMES="$WANTED_THEMES"

for want in $WANTED; do
  if contains "$want" "$ALL_IDS"; then
    SELECTED_IDS="$SELECTED_IDS $want"
  elif contains "$want" "$ALL_THEMES"; then
    SELECTED_THEMES="$SELECTED_THEMES $want"
  else
    echo -e "${RED}  ✗ nom inconnu : $want${NC}"
    echo -e "  Persona : ${CYAN}$ALL_IDS${NC}"
    echo -e "  Thèmes  : ${CYAN}$ALL_THEMES${NC}"
    exit 1
  fi
done

for want in $SELECTED_THEMES; do
  contains "$want" "$ALL_THEMES" && continue
  echo -e "${RED}  ✗ thème inconnu : $want${NC}"
  echo -e "  Thèmes : ${CYAN}$ALL_THEMES${NC}"
  exit 1
done

SELECT_ALL="no"
[ -z "$SELECTED_IDS" ] && [ -z "$SELECTED_THEMES" ] && SELECT_ALL="yes"

is_selected() {
  local id="$1" theme="$2"
  [ "$SELECT_ALL" = "yes" ] && return 0
  contains "$id" "$SELECTED_IDS" && return 0
  contains "$theme" "$SELECTED_THEMES" && return 0
  return 1
}

# --- agents ---
add_agent() {
  AGENT_NAMES+=("$1")
  AGENT_ROOTS+=("$2")
}

detect_agents() {
  case "$AGENT_FILTER" in
    claude)   add_agent "Claude Code" "$HOME/.claude/skills"; return ;;
    codex)    add_agent "Codex" "$HOME/.agents/skills"; return ;;
    gemini)   add_agent "Gemini CLI" "$HOME/.gemini/skills"; return ;;
    opencode) add_agent "OpenCode" "$HOME/.config/opencode/skills"; return ;;
    all)
      add_agent "Claude Code" "$HOME/.claude/skills"
      add_agent "Codex" "$HOME/.agents/skills"
      add_agent "Gemini CLI" "$HOME/.gemini/skills"
      add_agent "OpenCode" "$HOME/.config/opencode/skills"
      return ;;
    auto) ;;
    *)
      echo -e "${RED}  ✗ agent inconnu : $AGENT_FILTER${NC}"
      echo -e "  Valeurs : ${CYAN}claude codex gemini opencode all${NC}"
      exit 1 ;;
  esac

  if [ -d "$HOME/.claude" ] || command -v claude &>/dev/null; then
    add_agent "Claude Code" "$HOME/.claude/skills"
  fi
  if [ -d "$HOME/.agents" ] || command -v codex &>/dev/null; then
    add_agent "Codex" "$HOME/.agents/skills"
  fi
  if [ -d "$HOME/.gemini" ] || command -v gemini &>/dev/null; then
    add_agent "Gemini CLI" "$HOME/.gemini/skills"
  fi
  if [ -d "$HOME/.config/opencode" ] || command -v opencode &>/dev/null; then
    add_agent "OpenCode" "$HOME/.config/opencode/skills"
  fi

  if [ ${#AGENT_NAMES[@]} -eq 0 ]; then
    echo -e "${YELLOW}  Aucun agent détecté — Claude Code par défaut${NC}"
    add_agent "Claude Code" "$HOME/.claude/skills"
  fi
}

copy_persona() {
  local theme="$1" id="$2" skill="$3" files="$4" root="$5"
  local src="personas/$theme/$id/skills/$skill"
  local dest="$root/$skill"
  mkdir -p "$dest"
  for f in $files; do
    if [ "$LOCAL_MODE" = "yes" ]; then
      cp "$SCRIPT_DIR/$src/$f" "$dest/$f"
    else
      fetch "$RAW_BASE/$src/$f" "$dest/$f"
    fi
  done
  echo "$dest"
}

# --- Claude Code : plugin marketplace officiel ---
plugin_marketplace_ready="unknown"

plugin_install() {
  local id="$1"
  [ "$USE_PLUGIN" = "no" ] && return 1
  command -v claude &>/dev/null || return 1

  if [ "$plugin_marketplace_ready" = "unknown" ]; then
    if claude plugin marketplace add "$GITHUB_REPO" &>/dev/null; then
      plugin_marketplace_ready="yes"
    else
      plugin_marketplace_ready="no"
    fi
  fi
  [ "$plugin_marketplace_ready" = "yes" ] || return 1

  claude plugin install "$id@$MARKETPLACE" &>/dev/null || return 1
  return 0
}

plugin_uninstall() {
  local id="$1"
  command -v claude &>/dev/null || return 1
  claude plugin uninstall "$id@$MARKETPLACE" &>/dev/null || return 1
  return 0
}

remove_persona() {
  local skill="$1" root="$2"
  local dest="$root/$skill"
  case "$dest" in
    */skills/?*) ;;
    *) return 1 ;;
  esac
  [ -d "$dest" ] || return 1
  rm -rf "$dest"
  echo "$dest"
}

# --- anciens noms : un persona renommé laisse un dossier orphelin ---
remove_legacy() {
  local legacy="$1" skill="$2" root="$3" gone=""
  for old in $legacy; do
    [ "$old" = "$skill" ] && continue
    gone="$(remove_persona "$old" "$root")" || continue
    echo -e "  ${YELLOW}⌫${NC} ancien nom ${GREY}$gone${NC}"
    REMOVED_LEGACY=$((REMOVED_LEGACY + 1))
  done
}

banner
detect_agents

if [ "$MODE" = "uninstall" ]; then
  echo -e "${CYAN}  Suppression...${NC}"
  echo ""
  while IFS= read -r line; do
    [ -n "$line" ] || continue
    theme="$(field "$line" 1)"
    id="$(field "$line" 3)"
    skill="$(field "$line" 4)"
    legacy="$(field "$line" 9)"
    is_selected "$id" "$theme" || continue
    if [ -n "$legacy" ]; then
      i=0
      while [ $i -lt ${#AGENT_ROOTS[@]} ]; do
        remove_legacy "$legacy" "$skill" "${AGENT_ROOTS[$i]}"
        i=$((i + 1))
      done
    fi
    if plugin_uninstall "$id"; then
      echo -e "  ${GREEN}✓${NC} $id ${GREY}— plugin Claude Code${NC}"
      INSTALLED+=("$id (plugin)")
    fi
    i=0
    while [ $i -lt ${#AGENT_ROOTS[@]} ]; do
      if gone="$(remove_persona "$skill" "${AGENT_ROOTS[$i]}")"; then
        echo -e "  ${GREEN}✓${NC} $id ${GREY}— ${AGENT_NAMES[$i]} → $gone${NC}"
        INSTALLED+=("$id (${AGENT_NAMES[$i]})")
      fi
      i=$((i + 1))
    done
  done <<EOF
$(read_registry)
EOF
  echo ""
  if [ ${#INSTALLED[@]} -eq 0 ] && [ $REMOVED_LEGACY -eq 0 ]; then
    echo -e "  ${YELLOW}Rien à supprimer${NC}"
  else
    echo -e "${PINK}${BOLD}  Persona supprimés 🎭${NC}"
  fi
  echo ""
  exit 0
fi

echo -e "${CYAN}  Installation...${NC}"
echo ""

while IFS= read -r line; do
  [ -n "$line" ] || continue
  theme="$(field "$line" 1)"
  id="$(field "$line" 3)"
  skill="$(field "$line" 4)"
  files="$(field "$line" 7)"
  legacy="$(field "$line" 9)"
  is_selected "$id" "$theme" || continue

  # un persona renommé laisse un dossier orphelin qui répond aux mêmes mots
  if [ -n "$legacy" ]; then
    i=0
    while [ $i -lt ${#AGENT_ROOTS[@]} ]; do
      remove_legacy "$legacy" "$skill" "${AGENT_ROOTS[$i]}"
      i=$((i + 1))
    done
  fi

  done_plugin="no"
  if plugin_install "$id"; then
    echo -e "  ${GREEN}✓${NC} ${BOLD}$id${NC} ${GREY}[$theme] — plugin Claude Code (marketplace)${NC}"
    INSTALLED+=("$id → Claude Code (plugin)")
    done_plugin="yes"
  fi
  i=0
  while [ $i -lt ${#AGENT_ROOTS[@]} ]; do
    name="${AGENT_NAMES[$i]}"
    # le plugin couvre déjà Claude Code
    if [ "$done_plugin" = "yes" ] && [ "$name" = "Claude Code" ]; then
      i=$((i + 1))
      continue
    fi
    dest="$(copy_persona "$theme" "$id" "$skill" "$files" "${AGENT_ROOTS[$i]}")"
    echo -e "  ${GREEN}✓${NC} ${BOLD}$id${NC} ${GREY}[$theme] — $name → $dest${NC}"
    INSTALLED+=("$id → $name")
    i=$((i + 1))
  done
done <<EOF
$(read_registry)
EOF

echo ""
if [ ${#INSTALLED[@]} -eq 0 ]; then
  echo -e "  ${YELLOW}Aucun persona installé${NC}"
  echo ""
  exit 1
fi

echo -e "${PINK}${BOLD}  Persona AI installé 🎭${NC}"
echo ""
echo -e "  ${BOLD}Installations :${NC}"
for item in "${INSTALLED[@]}"; do
  echo -e "  ${PINK}•${NC} $item"
done
echo ""
echo -e "  ${BOLD}Activer un persona :${NC} tape ${CYAN}/<persona>${NC} ou dis ${CYAN}\"active <persona>\"${NC}"
echo -e "  ${BOLD}Revenir en normal :${NC}  dis ${CYAN}\"mode normal\"${NC}"
echo ""
