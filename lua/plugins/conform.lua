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
        require("conform").format({ async = true, lsp_fallback = true })
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
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
  },
  -- init = function()
  --   vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  -- end,
}
