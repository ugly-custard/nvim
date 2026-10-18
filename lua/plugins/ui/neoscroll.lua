return {
  "karb94/neoscroll.nvim",
  -- Over SSH every animation frame costs a round trip; native scrolling instead.
  cond = vim.env.SSH_CONNECTION == nil,
  event = "VeryLazy",
  opts = {
    -- No <C-e>/<C-y>: neoscroll turns them into 10%-of-window jumps instead of one line.
    mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
    -- Hiding works via guicursor, which kitty/tmux render as a shape change mid-scroll.
    hide_cursor = false,
  },
}
