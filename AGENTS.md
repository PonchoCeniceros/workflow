# AGENTS.md

Personal developer workflow/productivity configuration monorepo. Not a traditional application — no build system, test suite, or CI pipeline.

## Project Structure

```
/Users/giovannychavez/workflow/
├── ide/                    # LazyVim (Neovim) configuration (Lua)
│   ├── init.lua            # Entry point
│   ├── stylua.toml         # Lua formatter config
│   ├── lua/config/         # Core config (keymaps, autocmds, lazy bootstrap)
│   └── lua/plugins/        # Plugin specs (<category>.<name>.lua)
├── ai/                     # OpenCode AI configuration
│   ├── opencode.json       # Main config (MCP servers, permissions)
│   ├── tui.json            # TUI theme & keybinds
│   └── skills/             # Custom skill definitions (SKILL.md + scripts)
├── .cmds.sh                # Shell aliases & helper functions
├── .wezterm.lua            # WezTerm terminal config
└── README.md               # Setup docs (Spanish)
```

## Build / Lint / Test

This is a configuration-only repo. There are no build or test commands.

### Formatting

```bash
# Format Lua files with StyLua (config in ide/stylua.toml)
npx stylua ide/

# Format JSON with prettier (if available)
npx prettier --write "ai/**/*.json"
```

### Linting

```bash
# Lint Lua with selene (configured via Mason in Neovim)
selene ide/

# Format Python with black (no config file, 4-space indent convention)
black ai/skills/
```

### Running Single Skill Scripts

```bash
# Run a Python skill script directly
python3 ai/skills/ftcpm-ping-checker/ping_checker.py path/to/urls.csv
python3 ai/skills/ftcpm-audit-visualizer/visualizar_auditoria.py
python3 ai/skills/ftcpm-import-order/reorder_imports.py path/to/file.ts
```

There are no tests. Do not create test files unless explicitly asked.

## Code Style Guidelines

### Lua (Neovim & WezTerm)

- **Indent**: 2 spaces, 120-column line width (enforced by `stylua.toml`)
- **Variables**: `snake_case` — e.g., `chosen_colorscheme`, `lazypath`
- **Functions**: defined as local variables with `function()` syntax
- **Requires**: `require("dotted.module.path")` with quoted strings
- **Returns**: each plugin file returns a single Lua table (or list of tables)
- **Error handling**: use `pcall` for conditional/safe module loading
- **Conditional config**: `if/elseif/else` chains for environment-based config (e.g., theme selection via `os.getenv`)
- **File existence**: check with `(vim.uv or vim.loop).fs_stat(path)` before file operations

**Plugin file naming**: `<category>.<name>.lua`

Categories: `ai`, `dev`, `editor`, `lsp`, `tools`, `ui`

Example: `lsp.mason.lua`, `ui.colorscheme.lua`, `tools.csv.lua`

**Plugin spec pattern**:

```lua
return {
  "author/plugin-name",
  opts = { ... },
  keys = { ... },
  dependencies = { ... },
  config = function() ... end,
}
```

**Type annotations**: use LuaCATS/EmmyLua when annotating (e.g., `---@type Plugin.Options`). Most files don't use annotations — follow the existing pattern of the file you're editing.

### Python (Skill Scripts)

- **Indent**: 4 spaces
- **Constants**: `UPPER_SNAKE_CASE` at module level — e.g., `CSV_PATH`, `TIMEOUT`, `COLORS`
- **Functions**: `snake_case` — Spanish names are common (e.g., `cargar_datos`, `seleccionar_dia`)
- **Entry point**: always `main()` function with `if __name__ == "__main__":` guard
- **CLI**: use `argparse` for command-line interfaces
- **Import order**: stdlib first, then third-party, no strict blank-line grouping required
- **Error handling**: `try/except` with specific exception types; `sys.exit(1)` for CLI argument validation failures; `raise FileNotFoundError` for missing data
- **Type hints**: optional — use `from typing import List, Tuple` etc. when adding them; follow the pattern of the existing file
- **Docstrings**: write in Spanish

### Shell/Bash

- **Aliases**: short lowercase abbreviations — e.g., `gtnv`, `gtoc`, `nv`, `nvc`
- **Functions**: `snake_case` or short abbreviations — e.g., `set_theme()`, `nvc()`
- **Validation**: use regex pattern matching (`[[ =~ ]]`) and guard clauses (`[[ -z ]] && return`)
- **Local variables**: always `local` keyword with `snake_case` names

### JSON (OpenCode Config)

- **Indent**: 2 spaces
- **Schema**: include `$schema` references when available

## Naming Conventions Summary

| Context | Convention | Example |
|---------|-----------|---------|
| Lua plugin files | `<category>.<name>.lua` | `dev.rust.lua`, `ui.dashboard.lua` |
| Python files | `snake_case.py` | `ping_checker.py`, `reorder_imports.py` |
| Shell scripts | `kebab-case.sh` | `theme-selector.sh` |
| Skill directories | `kebab-case/` | `ftcpm-audit-visualizer/` |
| Config dotfiles | `.lowercase` | `.wezterm.lua`, `.cmds.sh`, `.theme` |
| Lua variables | `snake_case` | `chosen_colorscheme`, `window_padding` |
| Python functions | `snake_case` | `cargar_datos`, `check_url` |
| Python constants | `UPPER_SNAKE_CASE` | `CSV_PATH`, `TIMEOUT`, `COLORS` |
| Bash variables | `snake_case` | `project_dir`, `selected_theme` |

## Language & Localization

- **Comments**: written in **Spanish**
- **Documentation**: primarily in **Spanish** (README, SKILL.md descriptions)
- **Code identifiers**: mixed Spanish and English — follow the pattern of the file you're editing
- **Commit messages**: follow existing convention in the repo

## Skill Definition Pattern (OpenCode)

Each skill lives in `ai/skills/<skill-name>/SKILL.md` with this structure:

```markdown
---
name: skill-name
description: "Short description"
tools: Bash (optional)
---

## Purpose
...

## Execution
...
```

When creating new skills, follow this YAML frontmatter + Markdown body pattern.

## WezTerm Theme Sync

The WezTerm config (`.wezterm.lua`) syncs themes with Neovim via a `user-var-changed` event. When modifying theme logic, ensure both `.wezterm.lua` and `ide/lua/config/autocmds.lua` are updated together to keep theme names consistent.

## Key Conventions

1. Do not add comments unless explicitly requested
2. Do not create test files unless explicitly asked
3. Follow the existing file's style — if a file uses type annotations, add them; if not, don't introduce them
4. Spanish is the primary language for comments and documentation
5. Plugin specs always return a single table (or list of tables) — never use side-effect-only files
6. Use `pcall(require, ...)` for any module that may not be available at runtime