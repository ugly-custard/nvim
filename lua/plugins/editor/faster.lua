return {
  "pteroctopus/faster.nvim",
  -- Must be loaded before the first file is read to catch `nvim bigfile`.
  lazy = false,
  opts = {
    behaviours = {
      -- Only pauses lualine/mini.clue (neither used here) and would remap @.
      fastmacro = { on = false },
    },
  },
}
