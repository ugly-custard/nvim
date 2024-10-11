return {
  "brenoprata10/nvim-highlight-colors",
  opts = {
    ---@usage 'background'|'foreground'|'virtual'
    render = "virtual",
    virtual_symbol = "■",
    virtual_symbol_prefix = "",
    virtual_symbol_suffix = " ",
    ---@usage 'inline'|'eol'|'eow'
    virtual_symbol_position = "inline",

    -- Highlight hex colors, e.g. '#FFFFFF'
    enable_hex = true,
    -- Highlight short hex colors e.g. '#fff'
    enable_short_hex = true,
    -- Highlight rgb colors, e.g. 'rgb(0 0 0)'
    enable_rgb = true,
    -- Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
    enable_hsl = true,
    -- Highlight CSS variables, e.g. 'var(--testing-color)'
    enable_var_usage = true,
    -- Highlight named colors, e.g. 'green'
    enable_named_colors = true,
    -- Highlight tailwind colors, e.g. 'bg-blue-500'
    enable_tailwind = false,

    -- exclude_filetypes = {},
    -- exclude_buftypes = {},
  },
}
