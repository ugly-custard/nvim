return {
  "folke/trouble.nvim",
  enabled = require("config.profile").full,
  cmd = "Trouble",
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
    { "<leader>xs", "<cmd>Trouble symbols toggle<CR>", desc = "Symbols" },
    { "<leader>xl", "<cmd>Trouble lsp toggle win.position=right<CR>", desc = "LSP definitions/references" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix list" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<CR>", desc = "Location list" },
    { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Todo comments" },
  },
  opts = {},
}
