return {
  { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      local wk = require("which-key")
      wk.setup()

      -- Browse all keymaps
      vim.keymap.set("n", "<leader>?", function()
        wk.show({ global = true })
      end, { desc = "Show all keymaps" })

      -- Document existing key chains
      wk.add({

        { "<leader>c", group = "[C]ode" },
        { "<leader>c_", hidden = true },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>d_", hidden = true },
        { "<leader>r", group = "[R]ename" },
        { "<leader>r_", hidden = true },
        { "<leader>s", group = "[S]earch" },
        { "<leader>s_", hidden = true },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>t_", hidden = true },
        { "<leader>h", group = "Git [H]unk" },
        { "<leader>h_", hidden = true },

        -- visual mode
        { "<leader>h", desc = "Git [H]unk", mode = "v" },
      })
    end,
  },
}
