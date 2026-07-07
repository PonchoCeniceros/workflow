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

> Revisa la guía paso a paso del [flujo de trabajo diario para desarrollo](docs/WORKFLOW.md).

# Documentación

- [Flujo de trabajo diario](docs/WORKFLOW.md)
- [Guía de levantamiento de VPS (DevOps)](docs/DEVOPS.md)
- [Utilidades](docs/UTILIDADES.md)

# Contenidos

- [Documentación](#documentación)
- [Requisitos](#requisitos)
- [Instalación](#instalación)
- [Comandos](#comandos)
- [IDE](#ide)
  - [Cheatsheet](#cheatsheet)
  - [Debugger Visual](#debugger-visual)
  - [AI Terminal](#ai-terminal)
  - [OpenCode TUI](#opencode-tui)
  - [Manejo de .CSV](#manejo-de-csv)
  - [Temas Disponibles](#temas-disponibles)
  - [Mantenimiento](#mantenimiento)
- [WezTerm](#wezterm)
- [SSH](#ssh)

# Requisitos

- `nvim`
- `git`
- `OpenCode.ai` y `WezTerm` (opcional)

# Instalación

```bash
# Clonar el repositorio
git clone https://github.com/PonchoCeniceros/workflow.git

# Ejecutar el instalador
cd workflow && ./install.sh
source ~/.zshrc
```

El instalador crea los symlinks y configura `.zshrc` automáticamente.

# Comandos

| Comando | Acción |
|---------|--------|
| `gtnv` | Ir a la configuración de LazyVim |
| `gtoc` | Ir a la configuración de OpenCode |
| `gtz` | Abrir `.zshrc` en Neovim |
| `srcz` | Recargar configuración de `.zshrc` |
| `cls` | Limpiar pantalla |
| `ot` | Abrir nuevo tab en el mismo directorio |
| `nv` | Selector de tema + abrir Neovim |
| `nv [arch]` | Selector de tema + abrir archivo |
| `nvp` | Selector de proyecto (~/Projects) + selector de tema |
| `nvd` | Selector de proyecto (~/Development) + selector de tema |
| `sssh` | Seleccionar servidor SSH del catálogo con fzf |

# IDE

## Cheatsheet

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
| | | `<S-Right>` Buffer siguiente | | `<leader>ud` Toggle diagnósticos |
| | | `<C-w>s` Split horizontal | | |
| | | `<C-w>v` Split vertical | | |
| | | `<C-w>c` Cerrar ventana | | |


## Debugger Visual

El debugger integra varias capas basadas en el **Debug Adapter Protocol (DAP)** — el mismo protocolo que usa VS Code, lo que permite reutilizar sus adaptadores por lenguaje.

```
┌─────────────────────────────────────────────────────────┐
│                    nvim-dap-ui                          │
│   (Panel de variables, pila, watches, REPL)             │
├─────────────────────────────────────────────────────────┤
│                    nvim-dap                             │
│   (Motor de debugging — sesiones, breakpoints, step)    │
├─────────────────────────────────────────────────────────┤
│         codelldb  |  debugpy  |  js-debug-adapter       │
│   (Adaptadores DAP por lenguaje, gestionados por Mason) │
├─────────────────────────────────────────────────────────┤
│              mason-nvim-dap.nvim                        │
│   (Auto-instalación y gestión de adaptadores)           │
└─────────────────────────────────────────────────────────┘
```

| Lenguaje | Adaptador | Cómo lanzar |
|----------|-----------|-------------|
| Rust | `codelldb` + rustaceanvim | `<leader>dR` → seleccionar target |
| Python | `debugpy` | `<leader>dc` |
| JS / TS | `js-debug-adapter` | `<leader>dc` |

### Proyectos de prueba

En `debug/` hay proyectos minimalistas para probar cada debugger:

```
debug/
├── rs/   → Cargo project (Rust)
├── py/   → script Python
└── js/   → script JavaScript
```

Los tres implementan el mismo programa (sumar una lista) para comparar el comportamiento del debugger entre lenguajes.

### Comandos generales

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
| `<leader>dP` | Pausar ejecución |
| `<leader>ds` | Mostrar sesión actual |
| `<leader>dl` | Re-ejecutar última configuración |
| `<leader>dw` | Widgets hover — información de variable bajo el cursor |
| `<leader>dg` | Ir a línea sin ejecutar |
| `<leader>dj` / `<leader>dk` | Navegar pila de llamadas (down/up) |

### Rust

El debugger se maneja desde **rustaceanvim** — `rust-analyzer` detecta automáticamente los targets debuggeables del proyecto (binarios, librerías, tests) y los expone vía `<leader>dR`.

**Flujo típico:**

1. Abrir un archivo Rust (`.rs`)
2. Poner breakpoints con `<leader>db`
3. Ejecutar `<leader>dR` para abrir el menú de debuggables
4. Seleccionar el target (`build --package ...` o `test --no-run ...`)
5. rustaceanvim compila en modo debug y lanza `codelldb` automáticamente
6. `nvim-dap-ui` se abre mostrando variables, pila y watches

> **Importante**: No usar las opciones "LLDB: Launch" genéricas de `mason-nvim-dap` — piden la ruta del binario manualmente. Siempre usar `<leader>dR`.

| Keymap | Acción |
|--------|--------|
| `<leader>dR` | Rust Debuggables — lista targets debuggeables |
| `<leader>cR` | Rust Code Actions |

**Debuggear tests:**
1. Poner breakpoints dentro del test
2. `<leader>dR` → seleccionar `test --no-run --package <name> --all-targets`
3. Elegir el test específico de la lista

### Python

Usa `debugpy` como adaptador. No requiere configuración adicional — `<leader>dc` lanza el archivo actual directamente.

**Flujo típico:**

1. Abrir un archivo Python (`.py`)
2. Poner breakpoints con `<leader>db`
3. Ejecutar `<leader>dc` para lanzar el debugger

### JS / TS

Usa `js-debug-adapter` (vscode-js-debug). Funciona igual que Python — `<leader>dc` lanza el archivo actual con Node.js.

**Flujo típico:**

1. Abrir un archivo `.js` o `.ts`
2. Poner breakpoints con `<leader>db`
3. Ejecutar `<leader>dc` para lanzar el debugger

### Configuración

| Archivo | Qué configura |
|---------|---------------|
| `ide/lua/plugins/dev.rust.lua` | rustaceanvim + keymaps de Rust |
| `ide/lua/plugins/dev.js.lua` | Adaptador DAP para JS/TS |
| `ide/lua/plugins/tools.dap.lua` | Handler de mason-nvim-dap |
| `ide/lua/plugins/lsp.mason.lua` | Instalación de codelldb, debugpy, js-debug-adapter |

## AI Terminal

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

## OpenCode TUI

Atajos configurados en `ai/opencode/tui.json`. Diseñados para evitar `ESC` (colisiona con modos de Neovim):

| Shortcut | Acción |
|----------|--------|
| `ctrl+q` | Interrumpir sesión / Salir de la app |
| `ctrl+c` | Cancelar preguntas interactivas |
| `ctrl+z` | Suspender terminal |

> **Nota**: `ctrl+q` reemplaza `ESC` para `session_interrupt`. `ctrl+c` es el estándar para cancelar en el TUI.


## Manejo de .CSV

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


## Mantenimiento

```bash
# 1. Borrar datos de ejecución y plugins
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

# 2. Re-crear symlinks (si es necesario)
./install.sh

# 3. Abrir Neovim para reinstallar plugins
nvim
```

## Temas Disponibles

Los temas se seleccionan con `fzf` al lanzar Neovim desde los comandos `nv`, `nvp` o `nvd`.

| Tema | Descripción |
|------|-------------|
| `catppuccin` | Acogedor y visualmente cohesivo, ideal para largas sesiones |
| `carbonfox` | Serio y profesional, alto rendimiento visual |
| `dracula` | Clásico oscuro con toques de púrpura |
| `gruvbox` | Retro y cálido, tonos terrosos con contraste ajustado |

También puedes forzar un tema manualmente con la variable de entorno:

```bash
NVIM_THEME=catppuccin nvim
NVIM_THEME=carbonfox nvim
NVIM_THEME=dracula nvim
NVIM_THEME=gruvbox nvim
```

Usa el script `theme-selector.sh` para cambiar el tema predeterminado:

```bash
# ver tema actual
./theme-selector.sh

# cambiar tema predeterminado
./theme-selector.sh catppuccin
./theme-selector.sh carbonfox
./theme-selector.sh dracula
./theme-selector.sh gruvbox
```

# WezTerm

Configuración en `.wezterm.lua`.

| Shortcut | Acción |
|----------|--------|
| `CMD + CTRL + F` | Toggle fullscreen |
| `CMD + H` | Ocultar ventana |
| `CMD + SHIFT + R` | Renombrar la ventana actual (útil para identificarla en Mission Control / Dock cuando tienes varias abiertas) |

# SSH

Conexión rápida a servidores vía `sssh` — selecciona un servidor del catálogo con `fzf` y se conecta automáticamente por SSH con la llave correcta.

```bash
sssh
```
Los servidores están definidos en `.wallet/ssh.csv` y las llaves en `.wallet/pem/`.
