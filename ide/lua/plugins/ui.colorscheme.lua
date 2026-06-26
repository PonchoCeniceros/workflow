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
  -- tema dracula
  --
  {
    "Mofiqul/dracula.nvim",
    name = "dracula",
    priority = 1000,
    opts = {
      transparent_background = false,
      term_colors = true,
      styles = {
        comments = { "italic" },
        functions = { "bold" },
        keywords = { "italic" },
        variables = {},
        types = { "italic" },
      },
    },
  },
  --
  -- tema gruvbox
  --
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    priority = 1000,
    opts = {
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = false,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true,
      contrast = "hard",
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
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
        return { colorscheme = "catppuccin-mocha" }
      elseif chosen_colorscheme == "carbonfox" then
        return { colorscheme = "carbonfox" }
      elseif chosen_colorscheme == "dracula" then
        return { colorscheme = "dracula" }
      elseif chosen_colorscheme == "gruvbox" then
        vim.o.background = "dark"
        return { colorscheme = "gruvbox" }
      else
        return { colorscheme = "catppuccin-mocha" }
      end
    end,
  },
}
