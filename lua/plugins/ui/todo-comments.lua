return {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {},
  keys = {
    -- Shadows the built-in ]t/[t; :tnext/:tprevious are unaffected.
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next todo comment",
    },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous todo comment",
    },
    { "<leader>st", "<cmd>TodoTelescope<CR>", desc = "Search todo comments" },
  },
}
