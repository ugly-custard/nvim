local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error("Cloning lazy.nvim failed:\n" .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins.ui" },
    { import = "plugins.editor" },
    { import = "plugins.tool" },
    { import = "plugins.completion" },
    { import = "plugins.lang" },
  },
  install = { colorscheme = { "tokyonight-night" } },
  -- Only dev machines update plugins; VPSes restore from the lockfile.
  checker = { enabled = require("config.profile").full, frequency = 86400 },
  performance = {
    rtp = {
      -- gzip/tar/zip are left enabled for reading rotated *.gz logs on VPSes.
      disabled_plugins = { "tohtml", "tutor", "netrwPlugin" },
    },
  },
})
