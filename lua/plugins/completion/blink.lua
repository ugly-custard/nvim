local function copilot_accept()
  local ok, suggestion = pcall(require, "copilot.suggestion")
  if ok and suggestion.is_visible() then
    suggestion.accept()
    return true
  end
end

return {
  "saghen/blink.cmp",
  enabled = require("config.profile").full,
  -- Release tag: blink downloads its prebuilt Rust fuzzy matcher for it.
  version = "1.*",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "rafamadriz/friendly-snippets",
    "mikavilpas/blink-ripgrep.nvim",
    "joelazar/blink-calc",
  },
  opts = {
    keymap = {
      preset = "none",
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      -- Copilot first: its suggestion is hidden while the menu is open (see copilot.lua).
      ["<Tab>"] = { copilot_accept, "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    completion = {
      list = { selection = { preselect = true, auto_insert = false } },
      menu = {
        draw = {
          treesitter = { "lsp" },
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
        },
      },
      documentation = { auto_show = true },
      ghost_text = { enabled = true },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "ripgrep", "calc" },
      per_filetype = { lua = { inherit_defaults = true, "lazydev" } },
      providers = {
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
        ripgrep = {
          name = "Ripgrep",
          module = "blink-ripgrep",
          opts = { backend = { use = "gitgrep-or-ripgrep" } },
        },
        calc = { name = "Calc", module = "blink-calc" },
        snippets = {
          opts = { extended_filetypes = { javascriptreact = { "html" }, typescriptreact = { "html" } } },
        },
      },
    },
    cmdline = {
      keymap = { ["<Tab>"] = { "show", "accept" } },
      -- Auto-show for : commands only, not / searches or input prompts.
      completion = {
        menu = {
          auto_show = function()
            return vim.fn.getcmdtype() == ":"
          end,
        },
      },
    },
  },
}
