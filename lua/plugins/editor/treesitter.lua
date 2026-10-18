local parsers = {
  "bash",
  "diff",
  "dockerfile",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "toml",
  "vim",
  "vimdoc",
  "yaml",
}

if require("config.profile").full then
  vim.list_extend(parsers, {
    "c",
    "cpp",
    "css",
    "go",
    "html",
    "javascript",
    "python",
    "tsx",
    "typescript",
  })
end

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false, -- doesn't support lazy-loading
  build = ":TSUpdate",
  config = function()
    -- Async; skips parsers that are already installed.
    require("nvim-treesitter").install(parsers)
  end,
}
