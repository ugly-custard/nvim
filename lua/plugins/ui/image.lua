return {
  "3rd/image.nvim",
  enabled = require("config.profile").full,
  -- kitty graphics protocol only works in a local kitty window, not over SSH.
  cond = vim.env.KITTY_WINDOW_ID ~= nil and vim.env.SSH_CONNECTION == nil,
  -- neo-tree's preview only checks for image.nvim's autocmds; if they don't exist yet it calls
  -- setup() a second time with defaults, so image.nvim has to be loaded before the first preview.
  event = "VeryLazy",
  opts = { backend = "kitty", processor = "magick_cli" },
}
