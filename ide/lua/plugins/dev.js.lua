return {
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      local adapter_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = { adapter_path, "${port}" },
        },
      }

      local js_config = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
      }

      dap.configurations.javascript = js_config
      dap.configurations.typescript = js_config
    end,
  },
}
