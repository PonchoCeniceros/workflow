return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      opts.handlers = opts.handlers or {}
      -- rustaceanvim maneja el adaptador y las configuraciones de debug
      -- automáticamente (vía SPC dR). No necesitamos los templates genéricos
      -- de codelldb que piden el path del binario manualmente.
      opts.handlers.codelldb = function() end
      return opts
    end,
  },
}
