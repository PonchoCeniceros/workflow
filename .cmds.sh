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
alias gtz="nv ~/.zshrc"
srcz() {
  cd ~ && source .zshrc
}

ot() {
  wezterm cli spawn --cwd "$(pwd)" >/dev/null 2>&1
}

opwl() {
  local keys_file="$HOME/workflow/.wallet/keys.csv"
  nv $keys_file
}

# -------------------------------------------------------------------
# Abre IDE directamente con el tema Catppuccin
# -------------------------------------------------------------------
nvc() {
  sed -i "" "s/\"theme\": \".*\"/\"theme\": \"catppuccin\"/" ~/.config/opencode/tui.json
  NVIM_THEME=catppuccin nvim "$@"
}

# -------------------------------------------------------------------
# Abre IDE directamente con el tema Carbonfox (Nightfox)
# -------------------------------------------------------------------
nvx() {
  sed -i "" "s/\"theme\": \".*\"/\"theme\": \"carbonfox\"/" ~/.config/opencode/tui.json
  NVIM_THEME=carbonfox nvim "$@"
}

# -------------------------------------------------------------------
# Abre IDE directamente con el tema Dracula
# -------------------------------------------------------------------
nvd() {
  sed -i "" "s/\"theme\": \".*\"/\"theme\": \"dracula\"/" ~/.config/opencode/tui.json
  NVIM_THEME=dracula nvim "$@"
}

# -------------------------------------------------------------------
# Comando maestro para Neovim
#
# Uso:
#   'nv'          -> Abre Neovim normal.
#   'nv c [arch]' -> Abre con Catppuccin.
#   'nv x [arch]' -> Abre con Carbonfox.
#   'nv d [arch]' -> Abre con Dracula.
# -------------------------------------------------------------------
nv() {
  if [[ "$1" == "c" ]]; then
    shift
    NVIM_THEME=catppuccin nvim "$@"
  elif [[ "$1" == "x" ]]; then
    shift
    NVIM_THEME=carbonfox nvim "$@"
  elif [[ "$1" == "d" ]]; then
    shift
    NVIM_THEME=dracula nvim "$@"
  else
    nvim "$@"
  fi
}

# -------------------------------------------------------------------
# Helper: selecciona proyecto con fzf y abre README.md > package.json > bare
# -------------------------------------------------------------------
_nvopen() {
  local cmd="$1"
  local project_dir="$2"
  local selected=$(ls -1 "$project_dir" | fzf \
    --prompt=" Choose Project > " \
    --height=20% \
    --layout=reverse \
    --border=rounded \
    --info=hidden \
    --header="Projects")
  [[ -z "$selected" ]] && return
  cd "$project_dir/$selected"
  if [[ -f "README.md" ]]; then
    $cmd "README.md"
  elif [[ -f "package.json" ]]; then
    $cmd "package.json"
  else
    $cmd
  fi
}

nvcp() { _nvopen nvc "$HOME/Projects" }
nvcd() { _nvopen nvc "$HOME/Development" }
nvxp() { _nvopen nvx "$HOME/Projects" }
nvxd() { _nvopen nvx "$HOME/Development" }
nvdp() { _nvopen nvd "$HOME/Projects" }
nvdd() { _nvopen nvd "$HOME/Development" }

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
