return {
  "nvim-mini/mini.nvim",
  event = "VeryLazy",
  config = function()
    require("mini.ai").setup({ n_lines = 500 })
    require("mini.surround").setup()
    require("mini.pairs").setup()
    require("mini.tabline").setup()
    local sl = require("mini.statusline")
    sl.setup()
    -- The default layout looks these up on the module at draw time, so overriding them is enough.
    ---@diagnostic disable-next-line: duplicate-set-field
    sl.section_location = function()
      return "%2l:%-2v"
    end
    -- noice skips msg_showmode, so Neovim's "recording @q" would otherwise show nowhere.
    local host = vim.env.SSH_CONNECTION and vim.uv.os_gethostname() or ""
    local fileinfo = sl.section_fileinfo
    ---@diagnostic disable-next-line: duplicate-set-field
    sl.section_fileinfo = function(args)
      local reg = vim.fn.reg_recording()
      local parts = { reg ~= "" and ("recording @" .. reg) or "", host, fileinfo(args) }
      return table.concat(
        vim.tbl_filter(function(p)
          return p ~= ""
        end, parts),
        " "
      )
    end
    -- The statusline isn't redrawn when recording starts/stops.
    vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
      callback = function()
        vim.schedule(vim.cmd.redrawstatus)
      end,
    })
  end,
}
