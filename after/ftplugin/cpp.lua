local keymap = vim.keymap.set

keymap(
  "n",
  " <F5>",
  ":w<CR>:!g++ -fsanitize=address -std=c++17 -Wall -Wextra -Wshadow -DONPC -O2 -o %< %<CR>:!./%< < ./in > ./out <CR>",
  { desc = "Run CPP code" }
)
