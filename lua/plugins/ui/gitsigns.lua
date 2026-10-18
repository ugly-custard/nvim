return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    current_line_blame = true,
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, "Next git hunk")
      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, "Previous git hunk")

      map("n", "<leader>hs", gitsigns.stage_hunk, "Stage/unstage hunk")
      map("n", "<leader>hr", gitsigns.reset_hunk, "Reset hunk")
      map("x", "<leader>hs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Stage/unstage selection")
      map("x", "<leader>hr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Reset selection")
      map("n", "<leader>hS", gitsigns.stage_buffer, "Stage buffer")
      map("n", "<leader>hR", gitsigns.reset_buffer, "Reset buffer")
      map("n", "<leader>hp", gitsigns.preview_hunk, "Preview hunk")
      map("n", "<leader>hi", gitsigns.preview_hunk_inline, "Preview hunk inline")
      map("n", "<leader>hb", function()
        gitsigns.blame_line({ full = true })
      end, "Blame line")
      map("n", "<leader>hd", gitsigns.diffthis, "Diff against index")
      map("n", "<leader>hD", function()
        gitsigns.diffthis("@")
      end, "Diff against HEAD")
      map("n", "<leader>hq", gitsigns.setqflist, "Buffer hunks to quickfix")
      map("n", "<leader>hQ", function()
        gitsigns.setqflist("all")
      end, "Repo hunks to quickfix")

      map("n", "<leader>tb", gitsigns.toggle_current_line_blame, "Toggle line blame")
      map("n", "<leader>tw", gitsigns.toggle_word_diff, "Toggle word diff")

      map({ "o", "x" }, "ih", gitsigns.select_hunk, "Inside hunk")
    end,
  },
}
