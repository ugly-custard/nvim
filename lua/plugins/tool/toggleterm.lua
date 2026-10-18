local lazygit
local function toggle_lazygit()
  lazygit = lazygit
    or require("toggleterm.terminal").Terminal:new({
      cmd = "lazygit",
      direction = "float",
      hidden = true,
      on_open = function(term)
        -- The global <Esc><Esc> terminal map would make every single <Esc> wait 'timeoutlen'.
        vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = term.bufnr, nowait = true })
      end,
    })
  lazygit:toggle()
end

return {
  "akinsho/toggleterm.nvim",
  keys = {
    -- v:count, not v:count1: without a count ToggleTerm closes whatever terminal is open
    -- (same as toggleterm's own open_mapping); 2<C-\> still opens terminal 2.
    { "<C-\\>", '<cmd>exe v:count . "ToggleTerm"<CR>', mode = { "n", "i", "t" }, desc = "Toggle terminal" },
    vim.fn.executable("lazygit") == 1 and { "<leader>gg", toggle_lazygit, desc = "Lazygit" } or nil,
  },
  opts = {
    direction = "float",
    -- Without an explicit border toggleterm uses "single"; it doesn't read 'winborder'.
    float_opts = { border = "curved", highlights = { border = "Normal", background = "Normal" } },
  },
}
