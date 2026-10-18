local full = require("config.profile").full

-- Merged over nvim-lspconfig's lsp/<name>.lua defaults by vim.lsp.config().
local servers = {
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = "Replace" },
        diagnostics = { disable = { "missing-fields" } },
        telemetry = { enable = false },
      },
    },
  },
  html = {},
  cssls = {},
  gopls = { settings = { gopls = { staticcheck = true } } },
  tailwindcss = {},
  ts_ls = {},
  -- Only attaches where an eslint config exists (lspconfig's root_dir); uses the project's eslint.
  eslint = {},
  ruff = {},
  -- vimtex compiles/views; texlab adds completion, label rename and chktex lints.
  texlab = { settings = { texlab = { chktex = { onOpenAndSave = true } } } },
}

local function on_attach(event)
  local buf = event.buf
  local function map(lhs, rhs, desc, opts)
    vim.keymap.set("n", lhs, rhs, vim.tbl_extend("force", { buffer = buf, desc = desc }, opts or {}))
  end
  local function pick(name)
    return function()
      require("telescope.builtin")[name]()
    end
  end

  map("gd", pick("lsp_definitions"), "Go to definition")
  map("gD", vim.lsp.buf.declaration, "Go to declaration")
  map("gI", pick("lsp_implementations"), "Go to implementation")
  -- nowait: the built-in gr* maps (grn, gra, grr, gri, grt) would otherwise delay gr.
  map("gr", pick("lsp_references"), "Go to references", { nowait = true })
  map("<leader>D", pick("lsp_type_definitions"), "Type definition")
  map("<leader>ds", pick("lsp_document_symbols"), "Document symbols")
  map("<leader>ws", pick("lsp_dynamic_workspace_symbols"), "Workspace symbols")
  map("<leader>rn", vim.lsp.buf.rename, "Rename")
  map("<leader>ca", vim.lsp.buf.code_action, "Code action")

  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if not client then
    return
  end

  if client:supports_method("textDocument/documentHighlight") then
    local group = vim.api.nvim_create_augroup("lsp-highlight-" .. buf, { clear = true })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = buf,
      group = group,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = buf,
      group = group,
      callback = vim.lsp.buf.clear_references,
    })
    vim.api.nvim_create_autocmd("LspDetach", {
      buffer = buf,
      group = group,
      callback = function()
        vim.lsp.buf.clear_references()
        vim.api.nvim_del_augroup_by_id(group)
      end,
    })
  end

  if client:supports_method("textDocument/inlayHint") then
    map("<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
    end, "Toggle inlay hints")
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    enabled = full,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Loaded before servers start: its plugin/ file adds completion capabilities to vim.lsp.config("*").
      "saghen/blink.cmp",
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      vim.diagnostic.config({
        virtual_text = false,
        update_in_insert = true,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "󰌵",
            [vim.diagnostic.severity.INFO] = "",
          },
        },
        float = { source = true, header = "", prefix = "" },
      })

      -- nvim-highlight-colors draws color swatches (also in non-LSP files).
      vim.lsp.document_color.enable(false)

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = on_attach,
      })

      for name, cfg in pairs(servers) do
        vim.lsp.config(name, cfg)
      end

      require("mason-tool-installer").setup({
        ensure_installed = vim.list_extend(vim.tbl_keys(servers), { "stylua", "prettierd", "shellcheck" }),
      })
      -- Last: enabling starts servers for already-open buffers, which must see the config above.
      -- stylua is installed for conform; mason-lspconfig would also start its --lsp mode.
      require("mason-lspconfig").setup({ automatic_enable = { exclude = { "stylua" } } })
    end,
  },
  { "j-hui/fidget.nvim", enabled = full, event = "LspAttach", opts = {} },
  { "folke/lazydev.nvim", enabled = full, ft = "lua", opts = {} },
}
