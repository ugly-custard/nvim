return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
      -- ensure parsers are installed
      local langs = {
        "bash",
        "c",
        "diff",
        "vim",
        "lua",
        "markdown",
        "markdown_inline",
        "javascript",
        "typescript",
        "css",
        "html",
        "json",
      }
      -- Install missing parsers on startup
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local installed = require("nvim-treesitter.config").get_installed()
          local to_install = vim.tbl_filter(function(lang)
            return not vim.list_contains(installed, lang)
          end, langs)
          if #to_install > 0 then
            require("nvim-treesitter").install(to_install)
          end
        end,
        once = true,
      })
    end,
  },
}
