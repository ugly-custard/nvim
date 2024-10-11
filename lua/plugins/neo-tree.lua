return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    { -- Optional image support in preview window
      "3rd/image.nvim",
      dependencies = {
        "vhyrro/luarocks.nvim",
        priority = 1001,
        opts = {
          rocks = { "magick" },
        },
      },
      opts = { backend = "kitty" },
    },
    {
      "s1n7ax/nvim-window-picker",
      name = "window-picker",
      event = "VeryLazy",
      config = function()
        require("window-picker").setup({
          hint = "floating-big-letter", -- 'statusline-winbar'
        })
      end,
    },
  },
  cmd = "Neotree",
  keys = {
    { "\\", "<cmd>Neotree toggle<CR>", { desc = "NeoTree toggle" } },
  },
  init = function()
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
    close_if_last_window = false,
    -- when opening files, don't use windows containing these file/buftypes
    open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_by_name = {
          --"node_modules"
        },
        hide_by_pattern = { -- uses glob style patterns
          --"*.meta",
          --"*/src/*/tsconfig.json",
        },
      },
      follow_current_file = {
        enabled = true,
      },
      use_libuv_file_watcher = true,
    },
    default_component_configs = {
      indent = {
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      symlink_target = {
        enabled = false,
      },
    },
    window = {
      position = "left",
      width = 30,
      mappings = {
        -- ["\\"] = "close_window",

        ["l"] = "open_with_window_picker",
        ["h"] = "close_node",
        ["<space>"] = "none",

        ["S"] = "split_with_window_picker",
        ["s"] = "vsplit_with_window_picker",

        ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
        ["L"] = "focus_preview",

        ["Y"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg("+", path, "c")
          end,
          desc = "Copy Path to Clipboard",
        },
        ["O"] = {
          function(state)
            require("lazy.util").open(state.tree:get_node().path, { system = true })
          end,
          desc = "Open with System Application",
        },
        -- -- ["<cr>"] = "open_drop",
        -- -- ["t"] = "open_tab_drop",
        -- ["a"] = {
        --   "add",
        --   -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        --   config = {
        --     show_path = "none" -- "none", "relative", "absolute"
        --   }
        -- },
        -- ["c"] = "copy", -- takes text input for destination
        -- ["m"] = "move", -- takes text input for destination
      },
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
  end,
}
