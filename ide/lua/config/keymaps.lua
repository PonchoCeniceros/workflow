-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Deshabilitar keymaps originales de navegación de ventanas y buffers
vim.keymap.del("n", "<C-h>")
vim.keymap.del("n", "<C-j>")
vim.keymap.del("n", "<C-k>")
vim.keymap.del("n", "<C-l>")
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")

-- Navegación de ventanas con Shift + doble flecha
vim.keymap.set("n", "<S-Left><S-Left>", "<C-w>h", { desc = "Go to Left Window" })
vim.keymap.set("n", "<S-Down><S-Down>", "<C-w>j", { desc = "Go to Lower Window" })
vim.keymap.set("n", "<S-Up><S-Up>", "<C-w>k", { desc = "Go to Upper Window" })
vim.keymap.set("n", "<S-Right><S-Right>", "<C-w>l", { desc = "Go to Right Window" })

-- Navegación de buffers con Shift + flechas
vim.keymap.set("n", "<S-Left>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-Right>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- Quit all windows
vim.keymap.set("n", "<leader>qq", "<cmd>qa!<cr>", { desc = "Quit all windows" })

-- Terminal de proposito general
-- (desplegada siempre abajo para mayor comodidad)
vim.keymap.set("n", "<leader>ft", function()
  Snacks.terminal(nil, {
    cwd = require("lazyvim.util").root(),
    win = {
      position = "bottom",
      height = 15, -- 15 lineas de altura para la terminal flotante
      wo = {
        -- winbar = " ",
      },
    },
  })
end, { desc = "Terminal (Root Dir)" })

-- Invertir efecto de 'i' y 'a'
-- vim.keymap.set("n", "i", "a", { desc = "Append after cursor" })
-- vim.keymap.set("n", "a", "i", { desc = "Insert before cursor" })
-- vim.keymap.set("n", "I", "A", { desc = "Append at end of line" })
-- vim.keymap.set("n", "A", "I", { desc = "Insert at start of line" })

-- Interfaz embebida de Git
-- Implementacion de GitUI como interfaz.
-- ajuste a la derecha para no inteferir
-- con las herramientas de IA

vim.keymap.del("n", "<leader>gG")
vim.keymap.del("n", "<leader>gg")
--
-- vim.keymap.set("n", "<leader>gg", function()
--   Snacks.terminal("gitui", {
--     cwd = require("lazyvim.util").root(),
--     win = {
--       position = "left",
--       width = 0.5,
--       wo = {
--         -- winbar = " ",
--       },
--     },
--   })
-- end, { desc = "Git (Root Dir)" })
