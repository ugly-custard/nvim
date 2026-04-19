return {
  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      { "j-hui/fidget.nvim", opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { "folke/lazydev.nvim", opts = {} },
    },
    config = function()
      vim.diagnostic.config({
        virtual_text = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "󰌵",
            [vim.diagnostic.severity.INFO] = "",
          },
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = true,
          header = "",
          prefix = "",
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- Jump to the definition (int x = 0;) of the word under your cursor.
          --  To jump back, press <C-t>.
          map("gd", function() require("telescope.builtin").lsp_definitions() end, "[G]oto [D]efinition")

          -- Jump to the definition (int x;) of the word under your cursor.
          --  For example, in C this would take you to the header.
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          map("gl", vim.diagnostic.open_float, "Open Diagnostics Float")

          -- Jump to the implementation of the word under your cursor.
          map("gI", function() require("telescope.builtin").lsp_implementations() end, "[G]oto [I]mplementation")

          -- Find references for the word under your cursor.
          map("gr", function() require("telescope.builtin").lsp_references() end, "[G]oto [R]eferences")

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map("<leader>D", function() require("telescope.builtin").lsp_type_definitions() end, "Type [D]efinition")

          -- Fuzzy find all the symbols in your current document (single file).
          --  Symbols are things like variables, functions, types, etc.
          map("<leader>ds", function() require("telescope.builtin").lsp_document_symbols() end, "[D]ocument [S]ymbols")

          -- Fuzzy find all the symbols in your current workspace (entire project).
          map("<leader>ws", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, "[W]orkspace [S]ymbols")

          -- Rename the variable under your cursor, across all files.
          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

          -- Opens a popup that displays documentation about the word under your cursor
          map("K", vim.lsp.buf.hover, "Hover Documentation")

          local client = vim.lsp.get_clients({ id = event.data.client_id })[1]
          -- Highlight all references of a word under the cursor
          -- Clear them when cursor is moved
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
              end,
            })
          end

          -- Enable inlay hints. may be unwanted, since they displace some of the code
          if client and client.server_capabilities.inlayHintProvider then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local servers = {
        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              -- Ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { "missing-fields" } },
              telemetry = {
                enable = false,
              },
            },
          },
        },
        html = {},
        cssls = {},
        gopls = {
          settings = {
            gopls = {
              staticcheck = true,
            },
          },
        },
        tailwindcss = {
          root_dir = require("lspconfig.util").root_pattern(".git"),
        },
        ts_ls = {
          root_dir = require("lspconfig.util").root_pattern(".git"),
          settings = {
            typescript = {
              -- Disable TS Server's built-in formatting so we can use Prettier
              format = nil,
            },
            javascript = {
              -- Disable TS Server's built-in formatting so we can use Prettier
              format = nil,
            },
          },
        },
        ruff = {},
      }

      require("mason").setup({
        ui = { border = "rounded" },
      })

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua", -- Used to format Lua code
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
