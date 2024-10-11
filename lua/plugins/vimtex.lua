return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.tex_flavor = "latex"
    vim.g.vimtex_quickfix_mode = 0
    vim.g.tex_conceal = "abdmg"
    -- vim.g.vimtex_syntax_enabled = 1
  end,
}
