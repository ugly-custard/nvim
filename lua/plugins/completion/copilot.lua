return {
  "zbirenbaum/copilot.lua",
  enabled = require("config.profile").full,
  cmd = "Copilot",
  -- The server needs time to start; loaded on InsertEnter, the first insert session gets no suggestions.
  event = "VeryLazy",
  opts = {
    panel = { enabled = false },
    suggestion = {
      auto_trigger = true,
      keymap = {
        -- blink's <Tab> accepts (see blink.lua).
        accept = false,
        accept_word = "<M-w>",
        accept_line = "<M-j>",
        next = "<C-l>",
        prev = "<C-h>",
        dismiss = "<A-e>",
      },
    },
    -- Copilot skips these by default.
    filetypes = { markdown = true, yaml = true, gitcommit = true },
  },
  config = function(_, opts)
    require("copilot").setup(opts)
    -- Hide the inline suggestion while blink's menu is open, so the two ghost texts don't overlap.
    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuOpen",
      callback = function()
        vim.b.copilot_suggestion_hidden = true
      end,
    })
    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuClose",
      callback = function()
        vim.b.copilot_suggestion_hidden = false
      end,
    })
  end,
}
