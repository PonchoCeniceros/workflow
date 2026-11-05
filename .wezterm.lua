local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()
config.window_decorations = "RESIZE"

--
-- Escuchar el evento personalizado de Neovim
--
wezterm.on("user-var-changed", function(window, pane, name, value)
	if name == "THEME" then
		window:set_config_overrides({ color_scheme = value })
	end
end)

--
-- maximizar terminal
--
-- wezterm.on("gui-startup", function(cmd)
-- 	local tab, pane, window = mux.spawn_window(cmd or {})
-- 	window:gui_window():maximize()
-- 	-- window:gui_window():toggle_fullscreen()
-- end)

-- tema clásico por defecto
config.color_scheme = "Dracula"
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

-- Configuración de dimensiones fijas (basadas en tu stty size)
-- Define el ancho (columnas) y alto (filas)
config.initial_cols = 179
config.initial_rows = 43

-- config.initial_cols = 120
-- config.initial_rows = 20

--
-- Nombres de ventana y de pestaña
--
-- El titulo de la ventana WezTerm lo recalcula en cada cambio, asi que un
-- set_title directo se pierde: el nombre se guarda en wezterm.GLOBAL (que
-- sobrevive a las recargas de config) y format-window-title lo usa.
-- Las pestañas si guardan su titulo de forma nativa (tab:set_title).
local function global_get(clave)
	return wezterm.GLOBAL[clave] or {}
end

local function global_set(clave, id, valor)
	local tabla = global_get(clave)
	tabla[id] = valor
	wezterm.GLOBAL[clave] = tabla
end

-- al_crear: la primera pestaña toma el mismo nombre. Solo al crear, para que
-- renombrar la ventana despues no pise el nombre que ya tenga esa pestaña.
local function nombrar_ventana(window, pane, al_crear)
	window:perform_action(
		wezterm.action.PromptInputLine({
			description = "Nombre para la ventana (Enter vacío = automático):",
			action = wezterm.action_callback(function(win, _, line)
				if line and line ~= "" then
					global_set("nombres_ventana", tostring(win:window_id()), line)
					if al_crear then
						win:mux_window():tabs()[1]:set_title(line)
					end
					-- el titulo solo se recalcula cuando algo cambia: reaplicar los
					-- overrides fuerza que se vuelva a correr format-window-title
					win:set_config_overrides(win:get_config_overrides() or {})
				end
			end),
		}),
		pane
	)
end

local function nombrar_pestana(window, pane)
	window:perform_action(
		wezterm.action.PromptInputLine({
			description = "Nombre para la pestaña (Enter vacío = automático):",
			action = wezterm.action_callback(function(win, p, line)
				if line and line ~= "" then
					p:tab():set_title(line)
				end
			end),
		}),
		pane
	)
end

-- Pide nombre al crear: no hay un evento de "ventana/pestaña nueva", asi que
-- update-status (que corre cada segundo) detecta ids que aun no ha visto. Una
-- ventana nueva pide solo su nombre; su primera pestaña se deja automatica.
wezterm.on("update-status", function(window, pane)
	local tab = pane:tab()
	if not tab then
		return
	end

	local wid = tostring(window:window_id())
	if not global_get("ventanas_vistas")[wid] then
		global_set("ventanas_vistas", wid, true)
		for _, t in ipairs(window:mux_window():tabs()) do
			global_set("pestanas_vistas", tostring(t:tab_id()), true)
		end
		nombrar_ventana(window, pane, true)
		return
	end

	local tid = tostring(tab:tab_id())
	if not global_get("pestanas_vistas")[tid] then
		global_set("pestanas_vistas", tid, true)
		nombrar_pestana(window, pane)
	end
end)

wezterm.on("format-window-title", function(tab, pane, tabs, panes, cfg)
	local titulo = tab.tab_title ~= "" and tab.tab_title or pane.title
	local indice = ""
	if #tabs > 1 then
		indice = string.format("[%d/%d] ", tab.tab_index + 1, #tabs)
	end
	local nombre = global_get("nombres_ventana")[tostring(tab.window_id)]
	if nombre then
		return nombre .. " · " .. indice .. titulo
	end
	return indice .. titulo
end)

-- comando para maximizar la terminal
config.keys = {
	{
		key = "f",
		mods = "CMD|CTRL",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		-- ventana pegada a la izquierda, para dejar visible la franja
		-- derecha del escritorio (iconos, imagenes para arrastrar)
		-- no usar 'd': Ctrl+Cmd+D es el "Look Up" de macOS y nunca llega aqui
		key = "l",
		mods = "CMD|CTRL",
		action = wezterm.action_callback(function(window, pane)
			if window:get_dimensions().is_full_screen then
				window:toggle_fullscreen()
			end
			local screen = wezterm.gui.screens().active
			window:set_position(screen.x, screen.y)
			-- 0.85: deja libre la columna de iconos del escritorio tambien en pantallas mas angostas
			local fraccion = 0.85
			window:set_inner_size(math.floor(screen.width * fraccion), screen.height)
		end),
	},
	{
		key = "h",
		mods = "CMD",
		action = wezterm.action.Hide,
	},
	{
		-- renombrar la ventana actual
		key = "r",
		mods = "CMD|SHIFT",
		action = wezterm.action_callback(function(window, pane)
			nombrar_ventana(window, pane, false)
		end),
	},
	{
		-- renombrar la pestaña actual
		key = "t",
		mods = "CMD|SHIFT",
		action = wezterm.action_callback(nombrar_pestana),
	},
}

return config
