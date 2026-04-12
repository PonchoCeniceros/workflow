return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = opts.formatters_by_ft or {}
    opts.formatters_by_ft.json = { "prettier" }
    opts.formatters_by_ft.jsonc = { "prettier" }
    opts.formatters_by_ft.xml = { "xmlformatter" }
    -- npm install -g sql-formatter
    opts.formatters_by_ft.sql = { "sql_formatter" }
    opts.formatters.sql_formatter = {
      command = "sql-formatter",
      args = { "--language", "postgresql" },
      stdin = true,
    }
  end,
}
