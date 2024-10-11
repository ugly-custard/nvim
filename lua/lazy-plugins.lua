local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  print("Installing Lazy.nvim. Close and reopen NVIM")
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  ui = {
    border = "rounded",
    title_pos = "center", ---@type "center" | "left" | "right"
  },
  checker = { enabled = false }, -- check for plugin updates
  change_detection = {
    enabled = true,
    notify = true,
  },
})
