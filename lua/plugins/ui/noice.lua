return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  keys = {
    { "<leader>`", "<cmd>NoiceDismiss<CR>", desc = "Dismiss notifications" },
  },
  opts = {
    lsp = {
      -- fidget shows LSP progress.
      progress = { enabled = false },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      inc_rename = true,
      lsp_doc_border = true,
      long_message_to_split = true,
    },
    messages = { view = "mini", view_warn = "mini" },
  },
}
