return {
  "folke/zen-mode.nvim",
  keys = {
    { "<leader>zz", desc = "A bit Zen" },
    { "<leader>zZ", desc = "Even more Zen" },
  },
  opts = {
    window = {
      width = 90,
      options = {},
    },
  },
  config = function(_, opts)
    require("zen-mode").setup(opts)

    vim.keymap.set("n", "<leader>zz", function()
      require("zen-mode").toggle()
      vim.wo.wrap = true
      vim.wo.number = true
      vim.wo.rnu = true
    end)

    vim.keymap.set("n", "<leader>zZ", function()
      require("zen-mode").toggle()
      vim.wo.wrap = false
      vim.wo.number = false
      vim.wo.rnu = false
      vim.wo.colorcolumn = "0"
    end)
  end,
}
