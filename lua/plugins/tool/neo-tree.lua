return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    {
      "s1n7ax/nvim-window-picker",
      name = "window-picker",
      opts = {
        hint = "floating-big-letter",
        filter_rules = { bo = { buftype = { "terminal", "quickfix" } } },
      },
    },
  },
  cmd = "Neotree",
  keys = {
    { "\\", "<cmd>Neotree toggle<CR>", desc = "NeoTree toggle" },
  },
  init = function()
    -- neo-tree is lazy-loaded, so its own netrw hijack isn't active yet for `nvim <dir>`.
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("NeoTreeInit", { clear = true }),
      callback = function()
        local f = vim.fn.expand("%:p")
        if vim.fn.isdirectory(f) ~= 0 then
          vim.cmd("Neotree current dir=" .. f)
          vim.api.nvim_clear_autocmds({ group = "NeoTreeInit" })
        end
      end,
    })
  end,
  opts = {
    close_if_last_window = true,
    popup_border_style = "",
    filesystem = {
      filtered_items = { hide_dotfiles = false, hide_by_name = { ".git" } },
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    default_component_configs = {
      indent = { with_expanders = true },
    },
    window = {
      width = 30,
      mappings = {
        ["<space>"] = "none",
        ["l"] = "open_with_window_picker",
        ["h"] = "close_node",
        ["S"] = "split_with_window_picker",
        ["s"] = "vsplit_with_window_picker",

        ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
        ["L"] = "focus_preview",
        ["Y"] = {
          function(state)
            vim.fn.setreg("+", state.tree:get_node():get_id(), "c")
          end,
          desc = "Copy path to clipboard",
        },
        ["O"] = {
          function(state)
            vim.ui.open(state.tree:get_node().path)
          end,
          desc = "Open with system application",
        },
      },
    },
  },
}
