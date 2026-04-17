vim.api.nvim_set_hl(0, "Border", { fg = "#93a1a1", bold = true })
vim.api.nvim_set_hl(0, "Paper", { italic = true })

return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { enabled = false },
      scratch = {
        name = "Clipboard",
        ft = "markdown",
        filekey = {
          cwd = false,
          branch = false,
          count = false,
        },
        autowrite = true,
        win = {
          width = 0.7,
          height = 0.8,
          border = "double",
          title = "Clipboard",
          title_pos = "left",
          wo = {
            winhighlight = "NormalFloat:Paper,FloatBorder:Border",
          },
        },
      },
      styles = {
        terminal = {
          keys = {
            term_normal = {
              "<esc>",
              function(self)
                vim.cmd("stopinsert")
              end,
              mode = "t",
              desc = "Escape to normal mode",
            },
            -- permitir el cambio de modo con el scroll
            -- scroll_up = {
            --   "<ScrollWheelUp>",
            --   function() end,
            --   mode = "t",
            -- },
            -- scroll_down = {
            --   "<ScrollWheelDown>",
            --   function() end,
            --   mode = "t",
            -- },
          },
        },
      },
    },
    keys = {
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle  Portapapeles",
      },
    },
  },
}
