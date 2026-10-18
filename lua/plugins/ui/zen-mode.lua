-- toggle(opts) merges over the config, so window options only apply to the zen float
-- and nothing leaks into the original window on close.
local function zen(opts)
  return function()
    require("zen-mode").toggle(opts)
  end
end

return {
  "folke/zen-mode.nvim",
  opts = { window = { width = 90 } },
  keys = {
    { "<leader>zz", zen(), desc = "Zen" },
    {
      "<leader>zZ",
      zen({
        window = { options = { wrap = false, number = false, relativenumber = false, colorcolumn = "" } },
        plugins = { tmux = { enabled = true }, gitsigns = { enabled = true }, diagnostics = { enabled = true } },
      }),
      desc = "Zen, no numbers/signs/diagnostics",
    },
  },
}
