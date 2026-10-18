return {
  "MagicDuck/grug-far.nvim",
  enabled = require("config.profile").full,
  cmd = { "GrugFar", "GrugFarWithin" },
  keys = {
    {
      "<leader>sR",
      function()
        require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
      end,
      desc = "Search & replace in project",
    },
    {
      "<leader>sR",
      function()
        require("grug-far").with_visual_selection()
      end,
      mode = "x",
      desc = "Search & replace selection in project",
    },
  },
  opts = {},
}
