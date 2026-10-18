local function builtin(name, opts)
  return function()
    require("telescope.builtin")[name](opts)
  end
end

-- A node_modules that isn't gitignored would flood the results.
local excludes = { "--hidden", "--glob=!**/.git/*", "--glob=!**/node_modules/*" }

local function copy_hash(prompt_bufnr)
  local hash = require("telescope.actions.state").get_selected_entry().value
  require("telescope.actions").close(prompt_bufnr)
  vim.fn.setreg("+", hash)
  vim.notify("Copied " .. hash)
end

-- Overrides telescope's <C-t> (open in tab).
local default_mappings
if require("config.profile").full then
  local to_trouble = function(prompt_bufnr)
    require("trouble.sources.telescope").open(prompt_bufnr)
  end
  default_mappings = { i = { ["<C-t>"] = to_trouble }, n = { ["<C-t>"] = to_trouble } }
end

return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-live-grep-args.nvim", enabled = require("config.profile").full },
  },
  init = function()
    -- Load telescope on the first vim.ui.select (code actions etc.); its ui-select extension
    -- then replaces vim.ui.select.
    local select = vim.ui.select
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
      vim.ui.select = select
      require("lazy").load({ plugins = { "telescope.nvim" } })
      return vim.ui.select(...)
    end
  end,
  keys = {
    { "<leader>sh", builtin("help_tags"), desc = "Search help" },
    { "<leader>sk", builtin("keymaps"), desc = "Search keymaps" },
    { "<leader>sf", builtin("find_files"), desc = "Search files" },
    { "<leader>ss", builtin("builtin"), desc = "Search pickers" },
    { "<leader>sw", builtin("grep_string"), desc = "Search current word" },
    {
      "<leader>sg",
      function()
        local ok, lga = pcall(function()
          return require("telescope").extensions.live_grep_args
        end)
        if ok and lga then
          lga.live_grep_args()
        else
          require("telescope.builtin").live_grep()
        end
      end,
      desc = "Search by grep",
    },
    { "<leader>sd", builtin("diagnostics"), desc = "Search diagnostics" },
    { "<leader>sr", builtin("resume"), desc = "Resume last search" },
    { "<leader>s.", builtin("oldfiles"), desc = "Search recent files" },
    {
      "<leader>s/",
      builtin("live_grep", { grep_open_files = true, prompt_title = "Live Grep in Open Files" }),
      desc = "Search in open files",
    },
    { "<leader>sn", builtin("find_files", { cwd = vim.fn.stdpath("config") }), desc = "Search nvim config" },
    { "<leader><leader>", builtin("buffers"), desc = "Find buffers" },
    {
      "<leader>/",
      function()
        require("telescope.builtin").current_buffer_fuzzy_find(
          require("telescope.themes").get_dropdown({ previewer = false })
        )
      end,
      desc = "Fuzzy search in buffer",
    },
    { "<leader>gc", builtin("git_commits"), desc = "Git commits" },
    { "<leader>gs", builtin("git_status"), desc = "Git status" },
  },
  config = function()
    local telescope = require("telescope")
    local vimgrep = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--max-columns=300",
      "--max-columns-preview",
    }
    telescope.setup({
      defaults = {
        path_display = { "filename_first" },
        mappings = default_mappings,
        vimgrep_arguments = vim.list_extend(vimgrep, excludes),
      },
      pickers = {
        find_files = { find_command = vim.list_extend({ "rg", "--files", "--color=never" }, excludes) },
        oldfiles = { only_cwd = true },
        git_commits = { mappings = { i = { ["<C-y>"] = copy_hash }, n = { ["<C-y>"] = copy_hash } } },
      },
      extensions = {
        ["ui-select"] = { require("telescope.themes").get_dropdown() },
      },
    })
    for _, ext in ipairs({ "fzf", "ui-select", "noice", "live_grep_args" }) do
      pcall(telescope.load_extension, ext)
    end
  end,
}
