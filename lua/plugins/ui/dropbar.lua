return {
  "Bekaboo/dropbar.nvim",
  -- `keys` would make lazy.nvim defer the whole plugin. Its plugin/ file already defers setup()
  -- to the first FileType, so no `opts` here (lazy would call setup() at startup).
  lazy = false,
  -- Fuzzy search inside dropbar menus; built by telescope's spec.
  dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
  keys = {
    {
      "<leader>;",
      function()
        require("dropbar.api").pick()
      end,
      desc = "Pick breadcrumb",
    },
    {
      "[;",
      function()
        require("dropbar.api").goto_context_start()
      end,
      desc = "Start of current context",
    },
    {
      "];",
      function()
        require("dropbar.api").select_next_context()
      end,
      desc = "Next context",
    },
  },
}
