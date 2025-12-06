vim.o.termguicolors = true
vim.cmd.colorscheme("nordbones")

local function apply_minimal()
  local set = vim.api.nvim_set_hl

  -- palette
  local grey    = "#A0A0A0"   -- comment grey
  local cyan    = "#88C0D0"   -- soft cyan for strings
  local green   = "#A6D189"   -- light green for constants
  local normal  = "#E0E0E0"
  local blue    = "#3d5166"   -- dimmer blue for colorcolumn

  ---------------------------------------------------------------------------
  -- ColorColumn -> blue
  ---------------------------------------------------------------------------
  set(0, "ColorColumn", { bg = blue })

  ---------------------------------------------------------------------------
  -- Base
  ---------------------------------------------------------------------------
  set(0, "Normal", { fg = normal, bg = "NONE" })

  ---------------------------------------------------------------------------
  -- Comments & docstrings -> grey
  ---------------------------------------------------------------------------
  set(0, "Comment", { fg = grey })

  -- Treesitter comment groups
  set(0, "@comment", { fg = grey })
  set(0, "@comment.documentation", { fg = grey })

  -- Many languages classify docstrings as strings -> force them grey
  set(0, "@string.documentation", { fg = grey })
  set(0, "@documentation", { fg = grey })

  -- LSP semantic tokens sometimes tag docs separately
  set(0, "@lsp.type.comment", { fg = grey })
  set(0, "@lsp.typemod.string.documentation", { fg = grey })

  ---------------------------------------------------------------------------
  -- Keywords -> bold white
  ---------------------------------------------------------------------------
  set(0, "Keyword", { fg = normal, bold = true })
  for _, grp in ipairs({
    "@keyword", "@keyword.operator", "@keyword.return",
    "@keyword.repeat", "@conditional",
  }) do
    set(0, grp, { link = "Keyword" })
  end

  ---------------------------------------------------------------------------
  -- Strings -> soft cyan
  ---------------------------------------------------------------------------
  set(0, "String", { fg = cyan })
  for _, grp in ipairs({
    "@string", "@string.escape", "@string.regex", "@string.special",
  }) do
    set(0, grp, { link = "String" })
  end

  ---------------------------------------------------------------------------
  -- Constants -> light green
  ---------------------------------------------------------------------------
  set(0, "Constant", { fg = green })
  set(0, "Number",   { fg = green })
  set(0, "Boolean",  { fg = green })
  set(0, "Float",    { fg = green })

  for _, grp in ipairs({
    "@constant", "@constant.builtin", "@number", "@boolean", "@float",
  }) do
    set(0, grp, { link = "Constant" })
  end

  ---------------------------------------------------------------------------
  -- Reset identifiers / functions / types -> default grey
  ---------------------------------------------------------------------------
  local neutral = {
    -- classic groups
    "Identifier", "Function", "Type", "Structure", "Typedef",

    -- treesitter types / variables / functions
    "@type", "@type.builtin", "@type.definition", "@type.qualifier",
    "@variable", "@variable.builtin",
    "@function", "@function.call", "@function.method", "@constructor",
    "@field", "@attribute",

    -- treesitter builtins
    "@function.builtin",
    "@type.builtin",
    "@constant.builtin",

    -- LSP semantic tokens (builtins / library stuff)
    "@lsp.type.function",
    "@lsp.type.method",
    "@lsp.type.class",
    "@lsp.type.struct",
    "@lsp.type.namespace",
    "@lsp.type.variable",
    "@lsp.typemod.function.defaultLibrary",
    "@lsp.typemod.variable.defaultLibrary",
    "@lsp.typemod.class.defaultLibrary",
  }

  for _, grp in ipairs(neutral) do
    set(0, grp, { fg = normal, bold = false, italic = false })
  end
end

apply_minimal()

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = apply_minimal,
})

