# Workflow

![LazyVim Badge](https://img.shields.io/badge/LazyVim-2E7DE9?logo=lazyvim&logoColor=fff&style=for-the-badge)
![OpenCode Badge](https://img.shields.io/badge/OpenCode.ai-130F0F?logo=openai&logoColor=fff&style=for-the-badge)
![GNU Bash Badge](https://img.shields.io/badge/GNU%20Bash-4EAA25?logo=gnubash&logoColor=fff&style=for-the-badge)
![WezTerm Badge](https://img.shields.io/badge/WezTerm-4E49EE?logo=wezterm&logoColor=fff&style=for-the-badge)

Workflow es un monorepo de configuración personal que centraliza y sincroniza el entorno de desarrollo: **LazyVim** como IDE, **OpenCode.ai** como asistente de IA, **WezTerm** como terminal, y **shell aliases** como atajos productivos. Todo en un solo lugar, listo para clonar y enlazar.

## Instalación

```bash
# Instalar previamente nvim, OpenCode.ai y WezTerm
# Agregar WezTerm al PATH
echo 'export PATH="/Applications/WezTerm.app/Contents/MacOS:$PATH"' >> ~/.zshrc

# Clonar el repositorio
cd ~/
git clone https://github.com/PonchoCeniceros/workflow.git

# Enlazar configuraciones
ln -s ~/workflow/ai ~/.config/opencode        # OpenCode
ln -s ~/workflow/ide ~/.config/nvim           # LazyVim
ln -s ~/workflow/.wezterm.lua ~/.wezterm.lua  # WezTerm

# Cargar comandos personalizados al iniciar la shell
echo '[ -f ~/workflow/.cmds.sh ] && source ~/workflow/.cmds.sh' >> ~/.zshrc

# Recargar la configuración de la shell
source ~/.zshrc
```

## Comandos

| Comando | Acción |
|---------|--------|
| `gtnv` | Ir a la configuración de LazyVim |
| `gtoc` | Ir a la configuración de OpenCode |
| `gtz` | Abrir `.zshrc` en Neovim |
| `srcz` | Recargar configuración de `.zshrc` |
| `cls` | Limpiar pantalla |
| `ot` | Abrir nuevo tab en el mismo directorio |
| `nv` | Abrir Neovim |
| `nv c [arch]` | Abrir Neovim con tema Catppuccin |
| `nv x [arch]` | Abrir Neovim con tema Carbonfox |
| `nvc [arch]` | Abrir Neovim con Catppuccin directo |
| `nvx [arch]` | Abrir Neovim con Carbonfox directo |
| `nvcp` | Seleccionar proyecto (Projects) con fzf + Catppuccin |
| `nvcd` | Seleccionar proyecto (Development) con fzf + Catppuccin |
| `nvxp` | Seleccionar proyecto (Projects) con fzf + Carbonfox |
| `nvxd` | Seleccionar proyecto (Development) con fzf + Carbonfox |
| `sssh` | Seleccionar servidor SSH del catálogo con fzf |

## IDE

### Cheatsheet

| Edición de Código | Búsqueda y Navegación | Buffers y Ventanas | Productividad | LSP y Debug |
|--------------------|------------------------|----------------------|-----------------|--------------|
| `i` Insertar después del cursor | `<leader>ff` Buscar archivos | `<leader>bb` Buffer anterior | `<leader>w` Guardar archivo | `<leader>xx` Warnings/errores LSP |
| `a` Insertar antes del cursor | `<leader>sg` Buscar texto (grep) | `Shift + →` Buffer siguiente | `<leader>q` Cerrar buffer | `<leader>ls` Símbolos del buffer |
| `I` Insertar al final de línea | `<leader>fb` Buffers abiertos | `Shift + ←` Buffer anterior | `<leader>e` Explorador archivos | `<leader>lR` Rename proyecto |
| `A` Insertar al inicio de línea | `<leader>fh` Ayuda | `<leader>bd` Cerrar buffer | `<leader>gg` Git status | `<leader>la` Code actions |
| `gcc` Comentar línea | `<leader>fr` Archivos recientes | `<leader>bD` Cerrar otros buffers | `<leader>gl` Git log | `<leader>le` Diagnósticos |
| `gc` + mov. Comentar múltiple | `gd` Ir a definición | `Shift + ↓↓` Ventana superior | `<leader>ca` Code actions | `<leader>ld` Ir a definición |
| `yi"` Copiar entre comillas | `gr` Ir a referencias | `Shift + ↑↑` Ventana inferior | `<leader>rn` Renombrar variable | `<leader>lr` Mostrar referencias |
| `ci"` Cambiar entre comillas | `gi` Ir a implementación | `Shift + ←←` Ventana izquierda |`:qall` Cerrar Neovim | `<leader>li` Mostrar info |
| `di"` Eliminar entre comillas | `K` Documentación flotante | `Shift + →→` Ventana derecha |`<leader>.` Clipboard | `F5` Start / Continue debug |
| | `<leader>ft` Terminal flotante | `<S-Left>` Buffer anterior | | `F10` Step over |
| | | `<S-Right>` Buffer siguiente | | |
| | | `<C-w>s` Split horizontal | | |
| | | `<C-w>v` Split vertical | | |
| | | `<C-w>c` Cerrar ventana | | |


### OpenCode

IA basada en [opencode.ai](https://opencode.ai) usando `snacks.terminal`.


| Keymap | Modo | Acción |
|--------|------|--------|
| `<leader>aa` | Normal | Toggle OpenCode |
| `<leader>av` | Normal | OpenCode bottom |
| `<leader>ah` | Normal | OpenCode right |
| `ctrl + q` | insert | interrupt OpenCode |


### csvview.nvim

| Tipo | Atajo / Comando | Modo | Acción |
|-----|-----------------|------|-------|
| Text object | `if` | Operador / Visual | Seleccionar **contenido interno del campo** |
| Text object | `af` | Operador / Visual | Seleccionar **campo completo** |
| Navegación | `<Tab>` | Normal / Visual | Ir al **siguiente campo** (fin del campo) |
| Navegación | `<S-Tab>` | Normal / Visual | Ir al **campo anterior** (fin del campo) |
| Navegación | `<Enter>` | Normal / Visual | Ir a la **siguiente fila** |
| Navegación | `<S-Enter>` | Normal / Visual | Ir a la **fila anterior** |
| Comando | `:CsvViewEnable` | Comando | Habilitar vista CSV |
| Comando | `:CsvViewDisable` | Comando | Deshabilitar vista CSV |
| Comando | `:CsvViewToggle` | Comando | Alternar vista CSV |


### Mantenimiento

```bash
# 1. Borrar datos de ejecución y plugins (Esto NO borra tu código en ~/workflow/ide)
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# 2. (Opcional) Si quieres re-crear el enlace simbólico por seguridad
rm ~/.config/nvim
ln -s ~/workflow/ide ~/.config/nvim

# 3. Abrir Neovim para que reinstale todo desde cero
nvim
```

### Temas Disponibles
Puedes seleccionar el tema al iniciar Neovim utilizando la variable de entorno `NVIM_THEME`:

```bash
# para quienes pasan horas frente a la pantalla y quieren
# un entorno acogedor y visualmente cohesivo.
NVIM_THEME=catppuccin nvim

# para usuarios que buscan un aspecto serio, profesional
# y de alto rendimiento.
NVIM_THEME=carbonfox nvim
```

Usa el script `theme-selector.sh` para gestionar temas fácilmente:

```bash
# ver tema actual
./theme-selector.sh

# cambiar tema predeterminado
./theme-selector.sh catppuccin
./theme-selector.sh carbonfox
```

## SSH

Conexión rápida a servidores vía `sssh` — selecciona un servidor del catálogo con `fzf` y se conecta automáticamente por SSH con la llave correcta.

```bash
sssh
```
Los servidores están definidos en `.wallet/ssh.csv` y las llaves en `.wallet/pem/`.
