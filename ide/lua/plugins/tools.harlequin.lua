return {
  -- Necesitamos ToggleTerm para manejar la terminal de Harlequin
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = math.floor(vim.o.columns * 0.3),
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 3,
        },
      })

      -- Creamos la terminal específica para HANA
      local Terminal = require("toggleterm.terminal").Terminal

      -- Esta terminal invoca tu función 'hda' de zsh
      local hda_terminal = Terminal:new({
        -- '-i' asegura que cargue tus aliases y funciones
        cmd = "zsh -i -c 'hda'",
        direction = "vertical",
        size = math.floor(vim.o.columns * 0.3),
        close_on_exit = true,

        -- Atajo local para cerrar Harlequin rápido con 'q' desde Neovim
        on_open = function(term)
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
      })

      -- Atajos de teclado (Keymaps)
      local opts = { noremap = true, silent = true }
      -- Abrir Harlequin (Hana Database Access)
      vim.keymap.set("n", "<leader>hq", "<cmd>lua toggle_hda()<CR>", { desc = "Harlequin (HANA)" })
      -- Salir del modo terminal con 'jk'
      vim.keymap.set("t", "jk", [[<C-\><C-n>]], { desc = "Escapar terminal" })
      -- Cerrar la terminal de Harlequin con el mismo líder estando dentro
      vim.keymap.set("t", "<leader>hq", [[<C-\><C-n><cmd>lua toggle_hda()<CR>]], { desc = "Cerrar Harlequin" })

      -- Función para abrir/cerrar Harlequin
      function _G.toggle_hda()
        hda_terminal:toggle()
      end
    end,
  },
}
