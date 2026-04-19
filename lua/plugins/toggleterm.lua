return {
  "akinsho/toggleterm.nvim",
  event = "VeryLazy",
  opts = {
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*",
      callback = function()
        local o = { noremap = true, buffer = 0 }
        vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]], o)
        vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]], o)
        vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]], o)
        vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]], o)
      end,
    })
  end,
}
