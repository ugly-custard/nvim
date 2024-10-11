return {
  { -- use `:Telescope colorscheme` to see installed colorscheme
    "folke/tokyonight.nvim",
    priority = 1000,
    init = function()
      vim.cmd.colorscheme("tokyonight-night")

      -- configure highlights
      vim.cmd.hi("Comment gui=none")
    end,
    -- opts = {
    -- 	transparent = true,
    -- },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true, -- load when called with `:colorscheme`
    -- priority = 1000,
    -- opts = {
    -- 	transparent_background = true,
    -- },
  },
  {
    "tiagovla/tokyodark.nvim",
    lazy = true,
    -- priority = 1000,
    -- opts = {
    --   transparent_background = true,
    --   gamma = 1.00, -- brightness
    -- },
  },
}
