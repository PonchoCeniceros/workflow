-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- inicializacion del plugin de csv
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.csv",
  command = "CsvViewEnable display_mode=border header_lnn=2",
})

-- Función para enviar el tema a WezTerm
local function set_wezterm_theme()
  local theme = vim.g.colors_name
  -- Mapeo de nombres si el tema
  -- de Neovim no se llama igual en WezTerm
  local theme_map = {
    ["catppuccin-mocha"] = "Catppuccin Mocha",
    ["nightfox"] = "carbonfox",
  }

  local wez_theme = theme_map[theme] or theme

  -- Secuencia de escape para cambiar la variable 'THEME' en WezTerm
  io.write(string.format("\27]1337;SetUserVar=%s=%s\7", "THEME", vim.base64.encode(wez_theme)))
end

-- Ejecutar cuando cambie el esquema de colores
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_wezterm_theme,
})
