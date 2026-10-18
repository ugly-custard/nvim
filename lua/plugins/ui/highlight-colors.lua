return {
  "brenoprata10/nvim-highlight-colors",
  enabled = require("config.profile").full,
  event = { "BufReadPost", "BufNewFile" },
  -- The built-in vim.lsp.document_color is disabled in completion/lsp.lua
  -- so CSS/tailwind colors aren't highlighted twice.
  opts = { render = "virtual", enable_tailwind = true },
}
