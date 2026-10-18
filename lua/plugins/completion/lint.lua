return {
  "mfussenegger/nvim-lint",
  enabled = require("config.profile").full,
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = { sh = { "shellcheck" }, bash = { "shellcheck" } }
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("lint", { clear = true }),
      callback = function()
        if vim.bo.modifiable then
          lint.try_lint()
        end
      end,
    })
  end,
}
