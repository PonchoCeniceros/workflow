# -------------------------------------------------------------------
# Bienvenida al abrir la terminal
# -------------------------------------------------------------------
cat << 'EOF'

                                   __         ___  ___
   __                             /\ \      /'___\/\_ \
  /'_`\_  __  __  __    ___   _ __\ \ \/'\ /\ \__/\//\ \     ___   __  __  __
 /'/'_` \/\ \/\ \/\ \  / __`\/\`'__\ \ , < \ \ ,__\ \ \ \   / __`\/\ \/\ \/\ \
/\ \ \L\ \ \ \_/ \_/ \/\ \L\ \ \ \/ \ \ \\`\\ \ \_/  \_\ \_/\ \L\ \ \ \_/ \_/ \
\ \ `\__,_\ \___x___/'\ \____/\ \_\  \ \_\ \_\ \_\   /\____\ \____/\ \___x___/'
 \ `\_____\\/__//__/   \/___/  \/_/   \/_/\/_/\/_/   \/____/\/___/  \/__//__/
  `\/_____/

EOF

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
  printf '%s\n' "catppuccin" "carbonfox" "dracula" "gruvbox" | fzf \
    --prompt=" Theme > " \
    --height=25% \
    --layout=reverse \
    --border=rounded \
    --info=hidden \
    --header="Color Theme"
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
  sed -i "" "s/\"theme\": \".*\"/\"theme\": \"$theme\"/" ~/.config/opencode/tui.json
  NVIM_THEME="$theme" nvim "$@"
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
  sed -i "" "s/\"theme\": \".*\"/\"theme\": \"$theme\"/" ~/.config/opencode/tui.json

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
