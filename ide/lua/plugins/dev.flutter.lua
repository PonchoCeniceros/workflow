return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local flutter = require("flutter-tools")

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      flutter.setup({
        lsp = {
          capabilities = capabilities,

          -- Nuevo hook LSP con Snacks (LazyVim 2025)
          on_attach = function(client, bufnr)
            local ok, snacks = pcall(require, "snacks")
            if ok and snacks.util and snacks.util.lsp and snacks.util.lsp.on_attach then
              snacks.util.lsp.on_attach(client, bufnr)
            end
          end,
        },
      })
    end,
  },
}
