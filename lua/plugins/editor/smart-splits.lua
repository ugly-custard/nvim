local function ss(fn)
  return function()
    require("smart-splits")[fn]()
  end
end

return {
  "smart-splits-nvim/smart-splits.nvim",
  -- Not keys-only: loading marks the pane as nvim for tmux (@pane-is-vim); until then tmux
  -- handles C-h/j/k/l itself.
  event = "VeryLazy",
  opts = {},
  keys = {
    { "<C-h>", ss("move_cursor_left"), desc = "Window left" },
    { "<C-j>", ss("move_cursor_down"), desc = "Window down" },
    { "<C-k>", ss("move_cursor_up"), desc = "Window up" },
    { "<C-l>", ss("move_cursor_right"), desc = "Window right" },
    { "<C-Left>", ss("resize_left"), desc = "Resize left" },
    { "<C-Down>", ss("resize_down"), desc = "Resize down" },
    { "<C-Up>", ss("resize_up"), desc = "Resize up" },
    { "<C-Right>", ss("resize_right"), desc = "Resize right" },
    -- Not C-S-arrows: kitty takes those (previous/next tab, scroll line).
    { "<M-H>", ss("swap_buf_left"), desc = "Swap buffer left" },
    { "<M-J>", ss("swap_buf_down"), desc = "Swap buffer down" },
    { "<M-K>", ss("swap_buf_up"), desc = "Swap buffer up" },
    { "<M-L>", ss("swap_buf_right"), desc = "Swap buffer right" },
  },
}
