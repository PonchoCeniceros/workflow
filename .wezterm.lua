local wezterm = require("wezterm")
local config = wezterm.config_builder()

--
-- Escuchar el evento personalizado de Neovim
--
wezterm.on("user-var-changed", function(window, pane, name, value)
  if name == "THEME" then
    window:set_config_overrides({ color_scheme = value })
  end
end)

-- tema clásico por defecto
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrains Mono")
config.font_size = 12.5

-- Quitar la barra de pestañas superior por completo
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- Quitar los botones de cerrar/minimizar/maximizar
-- (opcional, muy limpio)
config.window_decorations = "RESIZE"

-- Añadir un poco de aire (padding)
-- para que el código no toque los bordes
config.window_padding = {
  left = 15,
  right = 15,
  top = 15,
  -- bottom = 10,
}

-- Define el ancho (columnas) y alto (filas)
config.initial_cols = 120
config.initial_rows = 20

-- comando para maximizar la terminal
config.keys = {
  {
    key = "f",
    mods = "CMD|CTRL",
    action = wezterm.action.ToggleFullScreen,
  },
  {
    key = "h",
    mods = "CMD",
    action = wezterm.action.Hide,
  },
}

return config
