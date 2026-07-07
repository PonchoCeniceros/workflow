# Flujo de Trabajo

Guía práctica de cómo se conectan las herramientas en el día a día.

## 1. Abrir un proyecto

Usa los selectores de proyecto para elegir con `fzf` y abrir directamente en Neovim con el tema de tu preferencia:

```bash
nvcp    # Projects + Catppuccin
nvcd    # Development + Catppuccin
nvxp    # Projects + Carbonfox
```

O si ya sabes la ruta:

```bash
nvc ~/Development/mi-proyecto
```

## 2. Navegar el código

Una vez dentro, oriéntate con:

| Qué quieres | Keymap |
|---|---|
| Buscar un archivo | `<leader>ff` |
| Buscar texto en todo el proyecto | `<leader>sg` |
| Ver el árbol de archivos | `<leader>e` |
| Ir a la definición de un símbolo | `gd` |
| Ver todas las referencias | `gr` |
| Ver documentación del símbolo | `K` |

## 3. Escribir código

El LSP trabaja en segundo plano dando sugerencias, errores y refactors:

| Qué quieres | Keymap |
|---|---|
| Renombrar una variable en todo el proyecto | `<leader>lR` |
| Ver y aplicar code actions | `<leader>la` |
| Formatear el archivo | `<leader>cf` |
| Comentar una línea | `gcc` |
| Comentar una selección | `gc` + movimiento |
| Ocultar warnings/errores temporalmente | `<leader>ud` |

## 4. Debuggear

Pon breakpoints y lanza el debugger según el lenguaje:

**Rust**
```
<leader>db    → breakpoint en la línea
<leader>dR    → menú de targets (binario, test, librería)
```

**Python / JS / TS**
```
<leader>db    → breakpoint en la línea
<leader>dc    → lanzar el archivo actual
```

Una vez pausado en un breakpoint:

| Qué quieres | Keymap |
|---|---|
| Avanzar sin entrar a funciones | `<leader>dO` |
| Entrar a la función | `<leader>di` |
| Salir de la función actual | `<leader>do` |
| Evaluar una expresión | `<leader>de` |
| Ver/ocultar paneles (variables, stack) | `<leader>du` |
| Terminar la sesión | `<leader>dt` |

## 5. Consultar un agente IA

Abre el terminal de IA sin salir de Neovim:

| Keymap | Acción |
|---|---|
| `<leader>aa` | Toggle herramienta por defecto (Claude o OpenCode) |
| `<leader>as` | Elegir herramienta desde un picker |
| `<leader>av` | Abrir en panel inferior |
| `<leader>ah` | Abrir flotante |

La herramienta por defecto se configura en `.zshrc`:

```bash
export AI_DEFAULT_TOOL=claude
```

## 6. Git

| Qué quieres | Keymap |
|---|---|
| Ver status del repo | `<leader>gs` |
| Ver historial de commits | `<leader>gl` |

## 7. Conectar a un servidor remoto

```bash
sssh    # selector fzf → conexión automática con la llave correcta
```
