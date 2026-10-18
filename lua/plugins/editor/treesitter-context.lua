return {
  "nvim-treesitter/nvim-treesitter-context",
  enabled = require("config.profile").full,
  event = { "BufReadPost", "BufNewFile" },
  opts = { max_lines = 3 },
}
