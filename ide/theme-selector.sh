#!/bin/bash

# Script para cambiar temas de Neovim
# Uso: ./theme-selector.sh [tema]

THEME_FILE="$HOME/.config/nvim/.theme"

# Lista de temas disponibles
THEMES=("catppuccin" "carbonfox")

# Función para mostrar uso
show_usage() {
	echo "Uso: $0 [tema]"
	echo ""
	echo "Temas disponibles:"
	for theme in "${THEMES[@]}"; do
		echo "  - $theme"
	done
	echo ""
	echo "Ejemplos:"
	echo "  $0 carbonfox    # Usar tema carbonfox"
	echo "  $0 catppuccin   # Usar tema catppuccin"
	echo "  $0              # Mostrar tema actual"
}

# Función para obtener tema actual
get_current_theme() {
	if [ -f "$THEME_FILE" ]; then
		current_theme=$(cat "$THEME_FILE")
		echo "Tema actual: $current_theme"
	else
		echo "No hay tema configurado. Usando tema por defecto: carbonfox"
	fi
}

# Función para establecer tema
set_theme() {
	local theme=$1

	# Verificar que el tema existe
	if [[ ! " ${THEMES[@]} " =~ " ${theme} " ]]; then
		echo "Error: Tema '$theme' no está disponible"
		show_usage
		exit 1
	fi

	# Guardar tema en archivo
	echo "$theme" >"$THEME_FILE"
	echo "Tema cambiado a: $theme"
	echo ""
	echo "Reinicia Neovim o usa ':Lazy sync' para aplicar los cambios"
	echo "Para reiniciar con el nuevo tema: NVIM_THEME=$theme nvim"
}

# Main
if [ $# -eq 0 ]; then
	get_current_theme
else
	set_theme "$1"
fi
