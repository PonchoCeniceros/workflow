# -------------------------------------------------------------------
# Bienvenida al abrir la terminal (omitida dentro de una terminal de Neovim)
# El avatar ascii viene de https://blobatar.dev/
# -------------------------------------------------------------------

# Cuantas celdas ocupa un caracter braille: depende del font fallback de la
# terminal (JetBrains Mono no trae braille y el fallback suele ser doble ancho).
# Se mide preguntandole a la terminal la posicion del cursor.
_wf_braille_cells() {
  local resp col
  if [ -n "$WF_AVATAR_CELLS" ]; then
    print -r -- "$WF_AVATAR_CELLS"
    return
  fi
  if [[ ! -t 1 ]]; then
    print -r -- 1
    return
  fi
  printf '\r⠿\033[6n' >/dev/tty
  if ! IFS= read -rs -d R -t 0.3 resp </dev/tty 2>/dev/null; then
    printf '\r    \r' >/dev/tty
    print -r -- 1
    return
  fi
  printf '\r    \r' >/dev/tty
  col="${resp##*;}"
  if [[ "$col" == <-> ]] && (( col >= 3 )); then
    print -r -- 2
  else
    print -r -- 1
  fi
}

_wf_welcome() {
  local cells aw gap=4
  cells="$(_wf_braille_cells)"
  aw=$((10 * cells))

  # la interfaz usa la paleta ansi (0-15) para que la remapee cada tema;
  # el avatar va en truecolor porque es su color propio, no del tema
  local cream=$'\033[38;2;213;216;198m' # D5D8C6
  local accent=$'\033[38;5;3m'  # amarillo
  local dim=$'\033[38;5;8m'     # gris (negro brillante)
  local val=$'\033[39m'         # foreground por defecto
  local bold=$'\033[1m'
  local rst=$'\033[0m'
  local bar="${accent}▎${rst}"

  local -a avatar lines
  avatar=(
    '⠀⢀⣴⣾⣿⣿⣿⣶⣄⠀'
    '⢠⣿⠿⣿⣿⣿⠿⣿⣿⣆'
    '⣿⣿⣀⣿⣿⣿⣀⣿⣿⣿'
    '⠹⣿⣿⣿⣿⣿⣿⣿⣿⠏'
    '⠀⠈⠻⢿⣿⣿⣿⠿⠋⠀'
  )

  local name
  name="$(git config --global user.name 2>/dev/null)"
  name="${name%% *}"
  [ -n "$name" ] || name="$USER"

  lines=(
    "${bar} ${bold}Welcome back, ${name}!${rst}"
    "${bar} ${dim}host   ${rst}${val}${HOST%%.*}${rst}"
    "${bar} ${dim}os     ${rst}${val}macOS $(sw_vers -productVersion 2>/dev/null)${rst}"
    "${bar} ${dim}shell  ${rst}${val}zsh ${ZSH_VERSION}${rst}"
    "${bar} ${dim}dir    ${rst}${val}${PWD/#$HOME/~}${rst}"
  )

  # las dos columnas tienen distinto alto: cada una se centra verticalmente
  local i j k n ao io
  n=${#avatar[@]}
  (( ${#lines[@]} > n )) && n=${#lines[@]}
  ao=$(((n - ${#avatar[@]}) / 2))
  io=$(((n - ${#lines[@]}) / 2))

  echo
  for i in {1..$n}; do
    # zsh indexa desde 1 y los negativos cuentan desde el final: hay que acotar
    j=$((i - ao)); k=$((i - io))
    if (( j >= 1 && j <= ${#avatar[@]} )); then
      printf '  %s%s%s' "$cream" "${avatar[$j]}" "$rst"
    else
      printf '  %*s' $aw ""
    fi
    if (( k >= 1 && k <= ${#lines[@]} )); then
      printf '%*s%s' $gap "" "${lines[$k]}"
    fi
    printf '\n'
  done
  echo
}

if [ -z "$NVIM" ]; then
  _wf_welcome
fi

# -------------------------------------------------------------------
# Comandos generales
#
# 'gtnv' (Go To Neovim) Dirigirme a la configuracion de mi IDE Lazyvim
# 'gtoc' (Go To Opencode) Dirigirme a la configuracion de Opencode
# 'cls' (Clear screen) Limpiar el buffer de la session actual
# 'gtz' (Go To .zshrc) Acceder a la configuracion en .zshrc
# 'srcz' (Source .zshrc) Guardar la configuracion en .zshrc
# 'ot' (Open Tab) Abrir un nuevo tab en el mismo directorio
# 'opwl' (Open Wallet) Abrir el archivo de credenciales de uso cotidiano
# -------------------------------------------------------------------
alias gtnv="cd ~/.config/nvim"
alias gtoc="cd ~/.config/opencode"
alias cls="clear"
alias gtz="nvim ~/.zshrc"
srcz() {
  cd ~ && source .zshrc
}

ot() {
  wezterm cli spawn --cwd "$(pwd)" >/dev/null 2>&1
}

opwl() {
  local keys_file="$HOME/workflow/.wallet/keys.csv"
  nvim $keys_file
}

# -------------------------------------------------------------------
# Helper: selector de tema con fzf
# -------------------------------------------------------------------
_nvtheme() {
  printf '%s\n' \
    "catppuccin-mocha" \
    "catppuccin-macchiato" \
    "catppuccin-frappe" \
    "catppuccin-latte" \
    "carbonfox" \
    "dracula" \
    "gruvbox" | fzf \
    --prompt=" Theme > " \
    --height=35% \
    --layout=reverse \
    --border=rounded \
    --info=hidden \
    --header="Color Theme"
}

# OpenCode no tiene las variantes de catppuccin: se queda con la familia
_octheme() {
  sed -i "" "s/\"theme\": \".*\"/\"theme\": \"${1%%-*}\"/" ~/.config/opencode/tui.json
}

# Reescribe 'default_colorscheme' en ui.colorscheme.lua, que es de donde
# LazyVim toma el tema cuando no viene NVIM_THEME
_nvdefault() {
  sed -i "" \
    "s/local default_colorscheme = \".*\"/local default_colorscheme = \"$1\"/" \
    "$HOME/workflow/ide/lua/plugins/ui.colorscheme.lua"
}

# -------------------------------------------------------------------
# Abre Neovim con selector de tema
#
# Uso:
#   'nv'        -> selector de tema + abre Neovim.
#   'nv [arch]' -> selector de tema + abre archivo.
# -------------------------------------------------------------------
nv() {
  local theme
  theme=$(_nvtheme)
  [[ -z "$theme" ]] && return
  _octheme "$theme"
  NVIM_THEME="$theme" nvim "$@"
}

_wezscheme() {
  case "$1" in
  catppuccin | catppuccin-mocha) echo "Catppuccin Mocha" ;;
  catppuccin-macchiato) echo "Catppuccin Macchiato" ;;
  catppuccin-frappe) echo "Catppuccin Frappe" ;;
  catppuccin-latte) echo "Catppuccin Latte" ;;
  carbonfox) echo "carbonfox" ;;
  dracula) echo "Dracula" ;;
  gruvbox) echo "GruvboxDark" ;;
  *) return 1 ;;
  esac
}

# -------------------------------------------------------------------
# Cambia el tema de WezTerm + OpenCode al vuelo (no toca el default de LazyVim)
#
# Uso:
#   'theme'        -> selector de tema.
#   'theme [tema]' -> aplica directamente el tema indicado.
# -------------------------------------------------------------------
theme() {
  local theme="$1"
  [[ -z "$theme" ]] && theme=$(_nvtheme)
  [[ -z "$theme" ]] && return

  local repo="$HOME/workflow"
  local wezterm_scheme
  wezterm_scheme=$(_wezscheme "$theme") || {
    echo "Tema desconocido: $theme"
    return 1
  }
  [[ "$theme" == "catppuccin" ]] && theme="catppuccin-mocha"

  echo "$theme" >"$repo/ide/.theme"
  sed -i "" "s/config.color_scheme = \".*\"/config.color_scheme = \"$wezterm_scheme\"/" "$repo/.wezterm.lua"
  _octheme "$theme"
}

# -------------------------------------------------------------------
# Fija el tema por defecto de LazyVim: el que usa 'nvim' cuando no se
# le pasa NVIM_THEME (es decir, cuando no se abre con 'nv', 'nvp' o 'nvd')
#
# Uso:
#   'dtheme'        -> selector de tema.
#   'dtheme [tema]' -> fija directamente el tema indicado.
# -------------------------------------------------------------------
dtheme() {
  local theme="$1"
  [[ -z "$theme" ]] && theme=$(_nvtheme)
  [[ -z "$theme" ]] && return

  _wezscheme "$theme" >/dev/null || {
    echo "Tema desconocido: $theme"
    return 1
  }
  [[ "$theme" == "catppuccin" ]] && theme="catppuccin-mocha"

  _nvdefault "$theme"
  echo "Tema por defecto de LazyVim: $theme"
}

# -------------------------------------------------------------------
# Helper: selecciona proyecto con fzf, luego tema, abre README.md > package.json > bare
# -------------------------------------------------------------------
_nvproject() {
  local project_dir="$1"
  local selected
  selected=$(ls -1 "$project_dir" | fzf \
    --prompt=" Project > " \
    --height=25% \
    --layout=reverse \
    --border=rounded \
    --info=hidden \
    --header="Projects")
  [[ -z "$selected" ]] && return

  local theme
  theme=$(_nvtheme)
  [[ -z "$theme" ]] && return

  cd "$project_dir/$selected"
  _octheme "$theme"

  if [[ -f "README.md" ]]; then
    NVIM_THEME="$theme" nvim "README.md"
  elif [[ -f "package.json" ]]; then
    NVIM_THEME="$theme" nvim "package.json"
  elif [[ -f "CLAUDE.md" ]]; then
    NVIM_THEME="$theme" nvim "CLAUDE.md"
  else
    NVIM_THEME="$theme" nvim
  fi
}

# -------------------------------------------------------------------
# nvp -> selecciona proyecto de ~/Projects + selector de tema
# nvd -> selecciona proyecto de ~/Development + selector de tema
# -------------------------------------------------------------------
nvp() { _nvproject "$HOME/Projects" }
nvd() { _nvproject "$HOME/Development" }

# -------------------------------------------------------------------
# Selecciona un servidor del CSV y se conecta por SSH
# -------------------------------------------------------------------
sssh() {
  local csv_file="$HOME/workflow/.wallet/ssh.csv"
  local pem_dir="$HOME/workflow/.wallet/pem"

  [[ ! -f "$csv_file" ]] && echo "$csv_file not found" && return 1

  local selected=$(awk -F',' 'NR>1 {printf "%-4s %-4s %-25s %s\n", NR, $1, $2, $4}' "$csv_file" | fzf \
    --prompt=" SSH > " \
    --height=40% \
    --layout=reverse \
    --border=rounded \
    --info=hidden \
    --header="Line Type Name                         Host")

  [[ -z "$selected" ]] && return

  local line_num=$(echo "$selected" | awk '{print $1}')
  local line=$(sed -n "${line_num}p" "$csv_file")
  local name=$(echo "$line" | cut -d',' -f2 | tr -d '\r')
  local user=$(echo "$line" | cut -d',' -f3 | tr -d '\r')
  local ip=$(echo "$line" | cut -d',' -f4 | tr -d '\r')
  local pem=$(echo "$line" | cut -d',' -f5 | tr -d '\r')

  echo "Conecting to $name ($ip)..."
  chmod 600 "$pem_dir/$pem"
  ssh -i "$pem_dir/$pem" "$user@$ip"
}
