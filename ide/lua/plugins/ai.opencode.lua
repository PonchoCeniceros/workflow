return {
  "folke/snacks.nvim",
  opts = {
    terminal = {
      win = {
        position = "right",
        width = 0.3,
        wo = {
          -- winbar = " ",
        },
      },
    },
  },
  keys = {
    {
      "<leader>aa",
      function()
        require("snacks.terminal").toggle("opencode --port", {
          win = {
            wo = {
              -- winbar = " ",
            },
          },
        })
      end,
      mode = { "n" },
      desc = "Toggle OpenCode",
    },
    {
      "<leader>av",
      function()
        require("snacks.terminal").toggle("opencode --port", {
          win = {
            position = "bottom",
            height = 0.3,
            wo = {
              -- winbar = " ",
            },
          },
        })
      end,
      mode = { "n" },
      desc = "OpenCode bottom",
    },
    {
      "<leader>ah",
      function()
        require("snacks.terminal").toggle("opencode --port", {
          win = {
            position = "right",
            width = 0.3,
            wo = {
              -- winbar = " ",
            },
          },
        })
      end,
      mode = { "n" },
      desc = "OpenCode right",
    },
  },
}
