return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      { "<leader>c", group = "code" },
      { "<leader>d", group = "document" },
      { "<leader>g", group = "git" },
      { "<leader>h", group = "git hunk", mode = { "n", "x" } },
      { "<leader>r", group = "rename" },
      { "<leader>s", group = "search" },
      { "<leader>t", group = "toggle/tab" },
      { "<leader>w", group = "workspace" },
      { "<leader>x", group = "trouble" },
      { "<leader>z", group = "zen" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "Show all keymaps",
    },
  },
}
