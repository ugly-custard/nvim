-- Comment.nvim removed: Neovim 0.12 has built-in gc/gcc commenting.
-- nvim-ts-context-commentstring is kept for JSX/TSX support via built-in commenting.
return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  lazy = true,
  opts = {
    enable_autocmd = false,
  },
  init = function()
    -- Override the built-in get_option to use ts-context-commentstring
    local get_option = vim.filetype.get_option
    vim.filetype.get_option = function(filetype, option)
      return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
        or get_option(filetype, option)
    end
  end,
}
