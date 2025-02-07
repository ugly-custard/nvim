local keymap = vim.keymap.set
-- Clear highlight on pressing <Esc> in normal mode
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Quality of Life keymaps
keymap("i", "jk", "<ESC>", { desc = "Exit insert mode" })
keymap("i", "kj", "<ESC>", { desc = "Exit insert mode" })
keymap("n", "<C-a>", "ggVG", { desc = "Select all" })
keymap("n", "+", "<C-a>", { desc = "Increment number under cursor" })
keymap("n", "-", "<C-x>", { desc = "Decrement number under cursor" })
keymap("n", "<leader>w", ":update<CR>", { desc = "Save current file" })

-- Diagnostic keymaps
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Split navigation with ctrl-[h,j,k,l]
keymap("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize horizontal split by -2" })
keymap("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize horizontal split by +2" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize vertical split by -2" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize vertical split by +2" })

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", { desc = "Switch to next buffer" })
keymap("n", "<S-h>", ":bprevious<CR>", { desc = "Switch to previous buffer" })

-- Navigate tabs
keymap("n", "<C-t>", ":tabnew<CR>", { desc = "Create a new tab" })
keymap("n", "<Tab>", ":tabn<CR>", { desc = "Switch to next tab" })
keymap("n", "<S-Tab>", ":tabp<CR>", { desc = "Switch to previous tab" })
keymap("n", "<A-1>", ":tabmove -<CR>", { desc = "Move tab to the left" })
keymap("n", "<A-2>", ":tabmove +<CR>", { desc = "Move tab to the right" })

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "move line up" })
keymap("v", "<A-j>", ":m .+1<CR>==", { desc = "Move block down" })
keymap("v", "<A-k>", ":m .-2<CR>==", { desc = "Move block up" })

keymap("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move selected text down" })
keymap("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move selected text up" })
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", { desc = "Move selected text block down" })
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", { desc = "Move selected text block up" })

-- Stay in indent mode
keymap("v", "<", "<gv", { desc = "Indent selected text" })
keymap("v", ">", ">gv", { desc = "Unindent selected text" })

-- [[ Autocommands ]]

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   desc = 'Highlight when yanking (copying) text',
--   group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
--   callback = function()
--     vim.highlight.on_yank()
--   end,
-- })
