-- Use nordbones-appropriate colors
local colors = {
  bg = '#2e3440',        -- Nord dark background
  fg = '#d8dee9',        -- Nord light foreground
  normal_mode = '#88c0d0',   -- Nord frost blue
  insert_mode = '#a3be8c',   -- Nord green
  visual_mode = '#b48ead',   -- Nord purple
  replace_mode = '#bf616a',  -- Nord red
  command_mode = '#ebcb8b',  -- Nord yellow
  inactive_bg = '#1f1f1f',
  inactive_fg = '#6c7086',
}

local custom_theme = {
  normal = {
    a = { bg = colors.normal_mode, fg = '#2e3440', gui = 'bold' },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  insert = {
    a = { bg = colors.insert_mode, fg = '#2e3440', gui = 'bold' },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  visual = {
    a = { bg = colors.visual_mode, fg = '#2e3440', gui = 'bold' },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  replace = {
    a = { bg = colors.replace_mode, fg = '#2e3440', gui = 'bold' },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  command = {
    a = { bg = colors.command_mode, fg = '#2e3440', gui = 'bold' },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  inactive = {
    a = { bg = colors.inactive_bg, fg = colors.inactive_fg },
    b = { bg = colors.inactive_bg, fg = colors.inactive_fg },
    c = { bg = colors.inactive_bg, fg = colors.inactive_fg },
  },
}

require('lualine').setup({
  options = {
    icons_enabled = false,
    theme = custom_theme,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {},
    lualine_z = {'location', 'branch'}
  },
  inactive_sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {},
    lualine_z = {'location', 'branch'}
  },
})
