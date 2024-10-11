local options = {
  mouse = "a",
  clipboard = "unnamedplus",

  -- Indentation
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  smartindent = true,
  breakindent = true,

  -- Status column
  number = true,
  relativenumber = true,
  -- numberwidth = 2,
  signcolumn = "auto",

  -- Bars
  showmode = false,
  showcmd = true,
  cmdheight = 1,
  showtabline = 1,
  synmaxcol = 500,
  -- conceallevel = 2,
  termguicolors = true,
  winblend = 10, -- floating window transparency, 0->opaque

  -- Pop up menu
  pumblend = 10,
  pumheight = 15,

  -- Files
  backup = false,
  undofile = true,
  swapfile = false,
  writebackup = false,
  fileencoding = "utf-8",

  -- Searching
  inccommand = "split", -- nosplit default
  hlsearch = true,
  ignorecase = true,
  infercase = true,
  smartcase = true,
  showmatch = true,
  matchtime = 1,

  -- Ticks
  updatetime = 200,
  timeoutlen = 400,

  -- Window
  splitkeep = "screen",
  splitbelow = true,
  splitright = true,

  -- Cursorline
  cursorline = true,
  cursorlineopt = "number",

  -- Scrolling
  scrolloff = 10,
  sidescrolloff = 10,

  -- Wrap & textwidth
  wrap = true,
  linebreak = true,
  whichwrap = "bs<>[]hl",
  colorcolumn = "80", -- set colorcolumn at 80

  -- list = true, -- sets how display certain whitespace characters in editor
  -- listchars = {
  -- 	tab = "» ",
  -- 	trail = "·",
  -- 	nbsp = "␣",
  -- },
  completeopt = { -- mostly just for cmp
    "menu",
    "menuone",
    "noselect",
    "noinsert",
  },
}

vim.g.loaded_netrw = 1 -- disable NETRW file explorer for nvim-tree
vim.g.loaded_netrwPlugin = 1 -- same as above

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- vim.cmd[[highlight clear SignColumn]]

vim.opt.shortmess:append("mr") -- flags to shorten vim messages, see :help 'shortmess'
vim.opt.iskeyword:append("-") -- hyphenated words recognized by searches
