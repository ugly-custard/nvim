return {
  "smjonas/inc-rename.nvim",
  event = "VeryLazy",
  opts = {
    cmd_name = "IncRename",
    preview_empty_name = false,
    show_message = true,
    save_in_cmdline_history = false,
    input_buffer_type = nil,
    post_hook = nil,
  },
  config = function(_, opts)
    require("inc_rename").setup(opts)
    vim.keymap.set("n", "<leader>rn", function()
      return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true, desc = "Rename Identifiers with LSP" })
  end,
}
