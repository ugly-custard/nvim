return {
  {
    "zbirenbaum/copilot.lua",
    dependencies = { "hrsh7th/nvim-cmp" },
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
      panel = {
        enabled = false,
        auto_refresh = true,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        accept = false,
        keymap = {
          prev = "<C-h",
          next = "<C-l>",
          dismiss = "<A-e>",
        },
      },
      filetypes = {},
    },
    config = function(_, opts)
      require("copilot").setup(opts)
      local cmp_status_ok, cmp = pcall(require, "cmp")
      if cmp_status_ok then
        cmp.event:on("menu_opened", function()
          vim.b.copilot_suggestion_hidden = true
        end)

        cmp.event:on("menu_closed", function()
          vim.b.copilot_suggestion_hidden = false
        end)
      end
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    enabled = true,
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = false,
    },
    config = function(_, opts)
      require("CopilotChat").setup(opts)
      require("CopilotChat.integrations.cmp").setup()
      vim.keymap.set("n", "<leader>c", ":CopilotChat<CR>", { desc = "Copilot Chat" })
    end,
  },
}
