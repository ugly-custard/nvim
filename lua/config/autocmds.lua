local group = vim.api.nvim_create_augroup("config", { clear = true })
local autocmd = function(event, opts)
  vim.api.nvim_create_autocmd(event, vim.tbl_extend("force", { group = group }, opts))
end

autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  callback = function()
    vim.hl.on_yank()
  end,
})

-- nvim-treesitter's main branch only installs parsers; highlighting has to be started per buffer.
autocmd("FileType", {
  desc = "Start treesitter",
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})

-- man and checkhealth already map q themselves.
autocmd("FileType", {
  desc = "Close utility windows with q",
  pattern = { "help", "qf", "notify" },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = ev.buf, desc = "Close window" })
  end,
})

autocmd("BufReadPost", {
  desc = "Restore last cursor position",
  callback = function(ev)
    if vim.bo[ev.buf].filetype:match("^git") then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(ev.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Reload files changed outside nvim",
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd.checktime()
    end
  end,
})

autocmd("VimResized", {
  desc = "Equalize splits on resize",
  callback = function()
    local tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd.tabnext(tab)
  end,
})
