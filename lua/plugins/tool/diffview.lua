return {
  "dlyongemallo/diffview-plus.nvim",
  enabled = require("config.profile").full,
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diff working tree" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "File history" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "Repo history" },
  },
  opts = { enhanced_diff_hl = true },
}
