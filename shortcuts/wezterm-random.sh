#!/bin/zsh
# Abre una ventana de WezTerm con tema aleatorio, pegada a la izquierda al 85%.
# Pensado para la accion "Run Shell Script" de Shortcuts:
#   ~/workflow/shortcuts/wezterm-random.sh

wezterm_bin="/Applications/WezTerm.app/Contents/MacOS/wezterm"

if "$wezterm_bin" cli list >/dev/null 2>&1; then
  "$wezterm_bin" cli spawn --new-window --cwd "$HOME" -- \
    env WORKFLOW_RANDOM_THEME=1 /bin/zsh -l >/dev/null
else
  open -na WezTerm --args start --cwd "$HOME" -- \
    env WORKFLOW_RANDOM_THEME=1 /bin/zsh -l
fi

open -a WezTerm
