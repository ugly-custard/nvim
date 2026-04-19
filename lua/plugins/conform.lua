return {
  "stevearc/conform.nvim",
  -- dependencies = { "williamboman/mason.nvim" },
  lazy = true,
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- python = { "isort", "black" },
      -- javascript = { { "prettierd", "prettier" } },
    },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
    format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },
  },
  -- init = function()
  --   vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  -- end,
}
