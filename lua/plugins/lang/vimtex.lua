return {
  "lervag/vimtex",
  enabled = require("config.profile").full,
  -- vimtex lazy-loads itself per filetype; lazy-loading it breaks inverse search (README).
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_quickfix_mode = 0
    -- K stays LSP hover (texlab); package docs are still on :VimtexDocPackage
    vim.g.vimtex_mappings_disable = { n = { "K" } }
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "tex",
      callback = function()
        -- Render vimtex's conceals (\alpha -> α, \textbf{} bold); the cursor line stays raw.
        vim.opt_local.conceallevel = 2
      end,
    })
  end,
}
