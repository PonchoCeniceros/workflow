#!/bin/zsh
# Abre una ventana de WezTerm con tema aleatorio.
# Pensado para la accion "Run Shell Script" de Shortcuts:
#   ~/workflow/shortcuts/wezterm-random.sh

wezterm_bin="/Applications/WezTerm.app/Contents/MacOS/wezterm"

if "$wezterm_bin" cli list >/dev/null 2>&1; then
  "$wezterm_bin" cli spawn --new-window --cwd "$HOME" -- \
    env WORKFLOW_RANDOM_THEME=1 /bin/zsh -l >/dev/null
  # activate y no 'open -a': open manda un "reopen" y WezTerm abre otra ventana
  osascript -e 'tell application "WezTerm" to activate'
else
  open -a WezTerm --args start --cwd "$HOME" -- \
    env WORKFLOW_RANDOM_THEME=1 /bin/zsh -l
fi
