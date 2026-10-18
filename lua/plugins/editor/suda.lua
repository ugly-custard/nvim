return {
  -- :SudaWrite / :SudaRead for root-owned files (`:w !sudo tee %` doesn't work in nvim).
  "lambdalisue/vim-suda",
  cmd = { "SudaRead", "SudaWrite" },
}
