return {
  "nvimdev/dashboard-nvim",
  lazy = false,
  opts = function()
    local logo = [[
                                   __         ___  ___                         
   __                             /\ \      /'___\/\_ \                        
  /'_`\_  __  __  __    ___   _ __\ \ \/'\ /\ \__/\//\ \     ___   __  __  __  
 /'/'_` \/\ \/\ \/\ \  / __`\/\`'__\ \ , < \ \ ,__\ \ \ \   / __`\/\ \/\ \/\ \ 
/\ \ \L\ \ \ \_/ \_/ \/\ \L\ \ \ \/ \ \ \\`\\ \ \_/  \_\ \_/\ \L\ \ \ \_/ \_/ \
\ \ `\__,_\ \___x___/'\ \____/\ \_\  \ \_\ \_\ \_\   /\____\ \____/\ \___x___/'
 \ `\_____\\/__//__/   \/___/  \/_/   \/_/\/_/\/_/   \/____/\/___/  \/__//__/  
  `\/_____/                                                                    
]]

    logo = string.rep("\n", 15) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      hide = {
        statusline = false,
      },
      config = {
        header = vim.split(logo, "\n"),
        center = {
          -- comentar los comandos para mantener el minimalismo
          --
          -- { action = "ene | startinsert", desc = " New File", icon = " ", key = "n" },
          -- { action = "Telescope find_files", desc = " Find File", icon = " ", key = "f" },
          -- { action = "Telescope oldfiles", desc = " Recent Files", icon = " ", key = "r" },
          -- { action = "Telescope live_grep", desc = " Find Text", icon = " ", key = "g" },
          -- { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
          -- { action = "LazyExtras", desc = " Lazy Extras", icon = " ", key = "x" },
          -- { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
          -- { action = "qa", desc = " Quit", icon = " ", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }
    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    return opts
  end,
}
