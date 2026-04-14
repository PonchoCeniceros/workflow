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
# Comando maestro para Neovim
#
# Uso:
#   'nv'          -> Abre Neovim normal.
#   'nv c [arch]' -> Abre con Catppuccin.
#   'nv x [arch]' -> Abre con Carbonfox.
# -------------------------------------------------------------------
nv() {
  if [[ "$1" == "c" ]]; then
    shift
    NVIM_THEME=catppuccin nvim "$@"
  elif [[ "$1" == "x" ]]; then
    shift
    NVIM_THEME=carbonfox nvim "$@"
  else
    nvim "$@"
  fi
}

# -------------------------------------------------------------------
# Selecciona un proyecto con fzf y abre nvc
# -------------------------------------------------------------------
nvcp() {
  local project_dir="$HOME/Projects"
  local selected=$(ls -1 "$project_dir" | fzf \
    --prompt=" Choose Project > " \
    --height=20% \
    --layout=reverse \
    --border=rounded \
    --info=hidden \
    --header="Projects")
  [[ -z "$selected" ]] && return
  cd "$project_dir/$selected" && nvc
}

nvcd() {
  local project_dir="$HOME/Development"
  local selected=$(ls -1 "$project_dir" | fzf \
    --prompt=" Choose Project > " \
    --height=20% \
    --layout=reverse \
    --border=rounded \
    --info=hidden \
    --header="Projects")
  [[ -z "$selected" ]] && return
  cd "$project_dir/$selected" && nvc
}

# -------------------------------------------------------------------
# Selecciona un proyecto con fzf y abre nvx
# -------------------------------------------------------------------
nvxp() {
  local project_dir="$HOME/Projects"
  local selected=$(ls -1 "$project_dir" | fzf \
    --prompt=" Choose Project > " \
    --height=20% \
    --layout=reverse \
    --border=rounded \
    --info=hidden \
    --header="Projects")
  [[ -z "$selected" ]] && return
  cd "$project_dir/$selected" && nvx
}

nvxd() {
  local project_dir="$HOME/Development"
  local selected=$(ls -1 "$project_dir" | fzf \
    --prompt=" Choose Project > " \
    --height=20% \
    --layout=reverse \
    --border=rounded \
    --info=hidden \
    --header="Projects")
  [[ -z "$selected" ]] && return
  cd "$project_dir/$selected" && nvx
}

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
