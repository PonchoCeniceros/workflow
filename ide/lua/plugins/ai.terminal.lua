local tools = {
  { name = "OpenCode", cmd = "opencode" },
  { name = "Claude Code", cmd = "claude" },
  { name = "Kiro CLI", cmd = "kiro-cli" },
}

local width_term = 0.27

local function pick_terminal(win_opts)
  vim.ui.select(tools, {
    prompt = "AI Terminal",
    format_item = function(item)
      return item.name
    end,
  }, function(choice)
    if not choice then
      return
    end
    require("snacks.terminal").toggle(choice.cmd, { win = win_opts })
  end)
end

local function default_terminal(win_opts)
  local default_cmd = os.getenv("AI_DEFAULT_TOOL")
  if default_cmd then
    require("snacks.terminal").toggle(default_cmd, { win = win_opts })
  else
    pick_terminal(win_opts)
  end
end

return {
  "folke/snacks.nvim",
  opts = {
    terminal = {
      win = {
        position = "right",
        width = width_term,
      },
    },
  },
  keys = {
    {
      "<leader>aa",
      function()
        default_terminal({ position = "right", width = width_term })
      end,
      mode = { "n" },
      desc = "AI Terminal (right)",
    },
    {
      "<leader>as",
      function()
        pick_terminal({ position = "right", width = width_term })
      end,
      mode = { "n" },
      desc = "AI Terminal select (right)",
    },
    {
      "<leader>av",
      function()
        pick_terminal({ position = "bottom", height = width_term })
      end,
      mode = { "n" },
      desc = "AI Terminal (bottom)",
    },
    {
      "<leader>ah",
      function()
        pick_terminal({ position = "float" })
      end,
      mode = { "n" },
      desc = "AI Terminal (float)",
    },
  },
}
