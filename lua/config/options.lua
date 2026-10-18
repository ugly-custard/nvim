local opt = vim.opt

opt.title = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.breakindent = true

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.cursorlineopt = "number"
opt.colorcolumn = "100"

opt.showmode = false
opt.synmaxcol = 500
opt.winblend = 10
opt.pumblend = 10
opt.pumheight = 15
opt.winborder = "rounded"

opt.undofile = true
opt.confirm = true

opt.ignorecase = true
opt.smartcase = true
opt.infercase = true

opt.updatetime = 200
opt.timeoutlen = 400

opt.splitbelow = true
opt.splitright = true

opt.scrolloff = 10
opt.sidescrolloff = 10
opt.linebreak = true
opt.whichwrap = "bs<>[]hl"

opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- foldmethod/foldexpr are set per window by nvim-origami (LSP, then treesitter, then indent).
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldcolumn = "auto:1"
opt.fillchars = { foldopen = "", foldclose = "", foldsep = " ", fold = " ", foldinner = " " }

opt.wildignore:append({ ".git", "*/node_modules/*" })
opt.shortmess:append("mr")

-- Over SSH there's no local clipboard tool; OSC 52 goes through the terminal.
-- Auto-detection is skipped once 'clipboard' is set, so it has to be explicit.
if vim.env.SSH_CONNECTION then
  vim.g.clipboard = "osc52"
end
-- Deferred: setting 'clipboard' runs provider detection, which costs ~4ms at startup.
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)
