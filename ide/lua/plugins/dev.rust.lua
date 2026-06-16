return {
  { import = "lazyvim.plugins.extras.lang.rust" },
  {
    "mrcjkb/rustaceanvim",
    opts = function(_, opts)
      opts.server = opts.server or {}
      opts.server.on_attach = function(client, bufnr)
        vim.keymap.set("n", "<leader>cR", function()
          vim.cmd.RustLsp("codeAction")
        end, { desc = "Code Action", buffer = bufnr })
        vim.keymap.set("n", "<leader>dR", function()
          vim.cmd.RustLsp("debuggables")
        end, { desc = "Rust Debuggables", buffer = bufnr })
      end
      opts.server.default_settings = opts.server.default_settings or {}
      opts.server.default_settings["rust-analyzer"] = vim.tbl_deep_extend(
        "force",
        opts.server.default_settings["rust-analyzer"] or {},
        { checkOnSave = { command = "clippy" } }
      )
      return opts
    end,
  },
}
