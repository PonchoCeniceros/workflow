<p align="center">
  <img src="https://github.com/PonchoCeniceros/workflow/blob/main/.assets/logo.png">
</p>

![WezTerm Badge](https://img.shields.io/badge/WezTerm-4E49EE?logo=wezterm&logoColor=fff&style=for-the-badge)
![GNU Bash Badge](https://img.shields.io/badge/GNU%20Bash-4EAA25?logo=gnubash&logoColor=fff&style=for-the-badge)
![Zsh Badge](https://img.shields.io/badge/Zsh-F15A24?logo=zsh&logoColor=fff&style=for-the-badge)
![LazyVim Badge](https://img.shields.io/badge/LazyVim-2E7DE9?logo=lazyvim&logoColor=fff&style=for-the-badge)
![OpenCode Badge](https://img.shields.io/badge/OpenCode.ai-130F0F?logo=openai&logoColor=fff&style=for-the-badge)
![Claude Badge](https://img.shields.io/badge/Claude-D97757?logo=claude&logoColor=fff&style=for-the-badge)

Workflow es un monorepo de configuración personal que centraliza y sincroniza el entorno de desarrollo: **LazyVim** como IDE, **OpenCode.ai** como asistente de IA, **WezTerm** como terminal, y **shell aliases** como atajos productivos. Todo en un solo lugar, listo para clonar y enlazar.

## Requisitos

- `nvim`
- `git`
- `OpenCode.ai` y `WezTerm` (opcional)

## Instalación

```bash
# Clonar el repositorio
git clone https://github.com/PonchoCeniceros/workflow.git

# Ejecutar el instalador
cd workflow && ./install.sh
source ~/.zshrc
```

El instalador crea los symlinks y configura `.zshrc` automáticamente.

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
| `A` Insertar al inicio de línea | `<leader>fh` Ayuda | `<leader>bd` Cerrar buffer | `<leader>gs` Git status | `<leader>la` Code actions |
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


### Debugger Visual (Rust)

El debugger visual para Rust integra varias capas que trabajan en conjunto:

```
┌─────────────────────────────────────────────────────────┐
│                    nvim-dap-ui                          │
│   (Panel de variables, pila, watches, REPL)             │
├─────────────────────────────────────────────────────────┤
│                    nvim-dap                             │
│   (Motor de debugging — manage sessions, breakpoints)   │
├─────────────────────────────────────────────────────────┤
│              rustaceanvim + codelldb                    │
│   (Adaptador DAP con --liblldb para macOS)              │
├─────────────────────────────────────────────────────────┤
│              mason-nvim-dap.nvim                        │
│   (Auto-instalación y gestión de adaptadores)           │
└─────────────────────────────────────────────────────────┘
```

| Capa | Plugin | Rol |
|------|--------|-----|
| Interfaz | `rcarriga/nvim-dap-ui` | Paneles visuales (variables, pila, watches, REPL) |
| Virtual text | `theHamsta/nvim-dap-virtual-text` | Muestra valores de variables inline |
| Motor | `mfussenegger/nvim-dap` | Sesiones, breakpoints, step, etc. |
| Adapter | `mrcjkb/rustaceanvim` | Configuración de `codelldb` + `--liblldb` |
| Gestión | `jay-babu/mason-nvim-dap.nvim` | Instalación automática de adaptadores |


#### Funcionamiento

El debugger se maneja desde **rustaceanvim** — `rust-analyzer` detecta automáticamente los targets debuggeables de tu proyecto (binarios, librerías, tests) y los expone vía `SPC dR`.

**Flujo típico:**

1. Abrí un archivo Rust (`.rs`)
2. Poné breakpoints con `SPC db` en las líneas que quieras inspeccionar
3. Ejecutá `SPC dR` para abrir el menú de debuggables de `rust-analyzer`
4. Seleccioná el target deseado:
   - `build --package ...` para debuggear el binario
   - `test --no-run --package ...` para debuggear tests
5. rustaceanvim compila automáticamente el proyecto en modo debug
6. Busca el binario compilado en la salida de `cargo build`
7. Configura y lanza `codelldb` con la ruta correcta
8. `nvim-dap-ui` se abre automáticamente mostrando variables, pila y watches
9. La ejecución se pausa en el primer breakpoint

> **Importante**: No uses las opciones "LLDB: Launch" genéricas de `mason-nvim-dap`. Esas preguntan la ruta del binario manualmente. Siempre usa `SPC dR` para que rustaceanvim maneje todo automáticamente.

#### Comandos

| Keymap | Acción |
|--------|--------|
| `<leader>db` | Toggle breakpoint en la línea actual |
| `<leader>dB` | Breakpoint condicional (pide expresión) |
| `<leader>dc` | Run/Continue — inicia o reanuda la ejecución |
| `<leader>da` | Run with Args — ejecuta con argumentos |
| `<leader>dC` | Run to Cursor — corre hasta la línea del cursor |
| `<leader>dO` | Step Over — avanza sin entrar en funciones |
| `<leader>di` | Step Into — entra en la función |
| `<leader>do` | Step Out — sale de la función actual |
| `<leader>dt` | Terminate — termina la sesión de debug |
| `<leader>dr` | Toggle REPL — consola interactiva de debug |
| `<leader>du` | Toggle DAP UI — abre/cierra los paneles |
| `<leader>de` | Evaluar expresión (modo normal o visual) |
| `<leader>dR` | Rust Debuggables — lista targets debuggeables |
| `<leader>dP` | Pausar ejecución |
| `<leader>ds` | Mostrar sesión actual |
| `<leader>dl` | Re-ejecutar última configuración |
| `<leader>dw` | Widgets hover — información de variable bajo el cursor |
| `<leader>dg` | Ir a línea sin ejecutar |
| `<leader>dj` / `<leader>dk` | Navegar pila de llamadas (down/up) |

#### Debuggear tests

1. Poné breakpoints dentro del test (ej. en un `assert_eq!`)
2. `<leader>dR` → selecciona `test --no-run --package <name> --all-targets`
3. Elegí el test específico de la lista
4. El debugger se detendrá en los breakpoints del test

#### Configuración

Las opciones se definen en `ide/lua/plugins/dev.rust.lua` (rustaceanvim) y `ide/lua/plugins/tools.dap.lua` (DAP core + handler de mason-nvim-dap).

### AI Terminal

Terminal de IA integrada via `snacks.terminal`. Soporta múltiples herramientas: **OpenCode**, **Claude Code** y **Kiro CLI**.

La herramienta por defecto se configura con la variable de entorno `AI_DEFAULT_TOOL` en `.zshrc`:

```bash
export AI_DEFAULT_TOOL=claude     # trabajo
export AI_DEFAULT_TOOL=opencode   # personal
```

Si la variable no está definida, `<leader>aa` abre el selector automáticamente.

| Keymap | Modo | Acción |
|--------|------|--------|
| `<leader>aa` | Normal | Toggle herramienta por defecto |
| `<leader>as` | Normal | Seleccionar herramienta (picker) |
| `<leader>av` | Normal | AI Terminal bottom |
| `<leader>ah` | Normal | AI Terminal float |
| `ctrl + q` | insert | Interrumpir |

### OpenCode TUI

Atajos configurados en `ai/opencode/tui.json`. Diseñados para evitar `ESC` (colisiona con modos de Neovim):

| Shortcut | Acción |
|----------|--------|
| `ctrl+q` | Interrumpir sesión / Salir de la app |
| `ctrl+c` | Cancelar preguntas interactivas |
| `ctrl+z` | Suspender terminal |

> **Nota**: `ctrl+q` reemplaza `ESC` para `session_interrupt`. `ctrl+c` es el estándar para cancelar en el TUI.


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
# 1. Borrar datos de ejecución y plugins
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

# 2. Re-crear symlinks (si es necesario)
./install.sh

# 3. Abrir Neovim para reinstallar plugins
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
