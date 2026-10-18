-- prettierd (daemon, installed by mason) uses the project's prettier and .prettierrc when present.
local prettier = { "prettierd", "prettier", stop_after_first = true }

return {
  "stevearc/conform.nvim",
  enabled = require("config.profile").full,
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true })
      end,
      mode = { "n", "x" },
      desc = "Format buffer/selection",
    },
  },
  init = function()
    -- For repos with a foreign style: :FormatToggle (global), :FormatToggle! (this buffer).
    vim.api.nvim_create_user_command("FormatToggle", function(args)
      local scope = args.bang and vim.b or vim.g
      scope.autoformat = scope.autoformat == false
      vim.notify(
        ("Format on save %s (%s)"):format(scope.autoformat and "on" or "off", args.bang and "buffer" or "global")
      )
    end, { bang = true, desc = "Toggle format on save" })
  end,
  opts = {
    default_format_opts = { lsp_format = "fallback" },
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = prettier,
      typescript = prettier,
      javascriptreact = prettier,
      typescriptreact = prettier,
      css = prettier,
      html = prettier,
      json = prettier,
      yaml = prettier,
      markdown = prettier,
    },
    format_on_save = function(buf)
      if vim.g.autoformat == false or vim.b[buf].autoformat == false then
        return
      end
      return { timeout_ms = 1000 }
    end,
  },
}
