# -------------------------------------------------------------------
# Comandos generales
#
# 'gtnv' (Go To Neovim) Dirigirme a la configuracion de mi IDE Lazyvim
# 'gtoc' (Go To Opencode) Dirigirme a la configuracion de Opencode
# 'cls' (Clear screen) Limpiar el buffer de la session actual
# 'gtz' (Go To .zshrc) Acceder a la configuracion en .zshrc
# 'srcz' (Source .zshrc) Guardar la configuracion en .zshrc
# -------------------------------------------------------------------
alias gtnv="cd ~/.config/nvim"
alias gtoc="cd ~/.config/opencode"
alias cls="clear"
alias gtz="nv ~/.zshrc"
alias srcz="source .zshrc"

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
# 'nvcp' (Neovim Catppuccin Project):
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
