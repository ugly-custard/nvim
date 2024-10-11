return {
  "kawre/neotab.nvim",
  event = "InsertEnter",
  opts = {
    tabkey = "<Tab>",
    act_as_tab = true,
    ---@diagnostic disable-next-line: undefined-doc-name, assign-type-mismatch
    behavior = "nested", ---@type ntab.behavior
    ---@diagnostic disable-next-line: undefined-doc-name, assign-type-mismatch
    pairs = { ---@type ntab.pair[]
      { open = "(", close = ")" },
      { open = "[", close = "]" },
      { open = "{", close = "}" },
      { open = "'", close = "'" },
      { open = '"', close = '"' },
      { open = "`", close = "`" },
      { open = "<", close = ">" },
    },
    exclude = {},
    smart_punctuators = {
      enabled = false,
      semicolon = {
        enabled = false,
        ft = { "cs", "c", "cpp", "java" },
      },
      escape = {
        enabled = false,
        ---@diagnostic disable-next-line: undefined-doc-name
        triggers = {}, ---@type table<string, ntab.trigger>
      },
    },
  },
}
