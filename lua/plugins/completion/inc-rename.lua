return {
  "smjonas/inc-rename.nvim",
  enabled = require("config.profile").full,
  cmd = "IncRename",
  keys = {
    {
      "<leader>rN",
      function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end,
      expr = true,
      desc = "Rename with live preview",
    },
  },
  opts = { save_in_cmdline_history = false },
}
