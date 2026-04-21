#!/usr/bin/env bash

cat <<'LOGODELIMITER'
                                   __         ___  ___                         
   __                             /\ \      /'___\/\_ \                        
  /'_`\_  __  __  __    ___   _ __\ \ \/'\ /\ \__/\//\ \     ___   __  __  __  
 /'/'_` \/\ \/\ \/\ \  / __`\/\`'__\ \ , < \ \ ,__\ \ \ \   / __`\/\ \/\ \/\ \ 
/\ \ \L\ \ \ \_/ \_/ \/\ \L\ \ \ \/ \ \ \\`\\ \ \_/  \_\ \_/\ \L\ \ \ \_/ \_/ \
\ \ `\__,_\ \___x___/'\ \____/\ \_\  \ \_\ \_\ \_\   /\____\ \____/\ \___x___/'
 \ `\_____\\/__//__/   \/___/  \/_/   \/_/\/_/\/_/   \/____/\/___/  \/__//__/  
  `\/_____/                                                                    

LOGODELIMITER

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
ZSHRC="$HOME/.zshrc"

msg() { echo -e "\033[1;36m[@]\033[0m $1"; }
skip() { echo -e "\033[1;33m[↪]\033[0m $1"; }
ok() { echo -e "\033[1;32m[✓]\033[0m $1"; }
err() { echo -e "\033[1;31m[✕]\033[0m $1" >&2; }

msg "Verificando dependencias..."

deps=("nvim" "git")
for dep in "${deps[@]}"; do
  if command -v "$dep" &>/dev/null; then
    ok "$dep"
  else
    err "$dep no encontrado. Instálalo antes de continuar."
    exit 1
  fi
done

msg "Creando directorios..."
mkdir -p "$HOME/.config"

link_if_missing() {
  local src="$REPO_DIR/$1"
  local dst="$2"
  local dst_dir

  dst_dir="$(dirname "$dst")"

  if [[ ! -d "$dst_dir" ]]; then
    mkdir -p "$dst_dir"
  fi

  if [[ -L "$dst" ]]; then
    local current_target
    current_target="$(readlink "$dst" 2>/dev/null || true)"

    if [[ "$current_target" == "$src" ]]; then
      skip "$dst -> $src"
    else
      skip "$dst -> $current_target"
    fi
    return 0

  elif [[ -e "$dst" ]]; then
    err "$dst existe como archivo regular. No se puede crear symlink."
    return 1

  else
    ln -s "$src" "$dst"
    ok "$dst -> $src"
    return 0
  fi
}

msg "Creando symlinks..."

link_if_missing "ai/opencode" "$HOME/.config/opencode"
link_if_missing "ai/claude" "$HOME/.claude"
link_if_missing "ide" "$HOME/.config/nvim"
link_if_missing ".wezterm.lua" "$HOME/.wezterm.lua"

msg "Configurando .zshrc..."

append_if_missing() {
  local pattern="$1"
  local content="$2"

  if grep -q "$pattern" "$ZSHRC" 2>/dev/null; then
    skip "ya existe: $pattern"
  else
    echo "" >>"$ZSHRC"
    echo "$content" >>"$ZSHRC"
    ok "agregado: $pattern"
  fi
}

append_if_missing 'WezTerm.app/Contents/MacOS' 'export PATH="/Applications/WezTerm.app/Contents/MacOS:$PATH"'
append_if_missing 'AI_DEFAULT_TOOL=opencode' 'export AI_DEFAULT_TOOL=opencode'
append_if_missing 'workflow/.cmds.sh' '[ -f "$HOME/workflow/.cmds.sh" ] && source "$HOME/workflow/.cmds.sh"'

echo ""
msg "Instalación completa."
msg "Ejecuta: source ~/.zshrc"
