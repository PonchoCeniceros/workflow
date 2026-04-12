return {
  --
  -- tema catppuccin
  --
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- El más oscuro y popular
      transparent_background = false,
      term_colors = true,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = { "bold" },
        functions = { "bold" },
        keywords = { "italic" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = { "bold", "italic" },
        properties = {},
        types = { "italic" },
        operators = {},
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        telescope = { enabled = true },
        which_key = true,
      },
    },
  },
  --
  -- tema carbonfox
  --
  {
    "EdenEast/nightfox.nvim",
    name = "nightfox",
    priority = 1000,
    opts = {
      options = {
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
      },
      palettes = {
        carbonfox = {
          bg0 = "#161616",
          bg1 = "#1a1a1a",
        },
      },
    },
  },
  --
  -- Configura LazyVim para cargar un tema de color dinámicamente
  --
  {
    "LazyVim/LazyVim",
    opts = function()
      local chosen_colorscheme = os.getenv("NVIM_THEME")
      if chosen_colorscheme == "catppuccin" then
        return { colorscheme = "catppuccin" }
      elseif chosen_colorscheme == "carbonfox" then
        return { colorscheme = "carbonfox" }
      else
        -- Por defecto usa catppuccin
        return { colorscheme = "catppuccin" }
      end
    end,
  },
}
