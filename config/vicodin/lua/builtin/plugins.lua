-- nvim-web-devicons
require('nvim-web-devicons').setup()

-- which-key
require('which-key').setup({
  delay = 1000
})

-- sleuth is autoloaded, nothing to do

-- conform.nvim
require('conform').setup({
  formatters_by_ft = {
    python = { "isort", "black" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    cpp = { "clang-format" },
    c = { "clang-format" }
  },
  default_format_opts = {
    lsp_format = "fallback",
  }
  -- keystroke/autofmt config in keymaps.lua/autocmds.lua
})

-- fzf-lua
require('fzf-lua').setup()

-- gitsigns
require('gitsigns').setup()

-- monokai-pro.nvim
require('monokai-pro').setup({
  transparent_background = true,
  filter = "machine",
})
vim.cmd([[colorscheme monokai-pro]])

-- lualine.nvim
require('lualine').setup {
  sections = {
    lualine_b = {
      {
        'branch',
        fmt = function(branch_name)
          local max_length = 7
          if #branch_name > max_length then
            return branch_name:sub(1, max_length) .. '_'
          end
          return branch_name
        end
      },
      'diagnostics',
      'diff'
    },
    lualine_c = {
      function()
        local symbols = {}
        if vim.bo.modified then
          table.insert(symbols, '[+]')
        end
        if vim.bo.modifiable == false or vim.bo.readonly == true then
          table.insert(symbols, '[-]')
        end

        local filename = vim.fn.expand('%')
        if filename == '' and vim.bo.buftype == '' and vim.fn.filereadable(filename) == 0 then
          table.insert(symbols, '[New]')
        end

        return vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.') ..
            (#symbols > 0 and ' ' .. table.concat(symbols, '') or '')
      end
    },
    lualine_x = { { 'filetype', fmt = function() return " " end, right_padding = 0 } }
  }
}

-- LSP
vim.lsp.enable({
  'lua_ls', 'clangd', 'pyright', 'ocamllsp', 'rust-analyzer', 'zls'
})

-- TreeSitter
require('nvim-treesitter').setup()

-- LuaSnip
require("luasnip").setup()

-- blink.cmp
require('blink.cmp').setup({
  fuzzy = {
    implementation = "lua"
  },
  keymap = {
    preset = "default",
    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<Tab>"] = { "accept", "fallback" },
  },
  sources = {
    default = { "lsp", "path" }, -- "buffer" is annoying
  },
  completion = {
    accept = { auto_brackets = { enabled = false } },
  },
})

-- mini.starter
require('mini.starter').setup({
  header = table.concat({
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣰⡪⡯⠺⠺⠵⠳⢯⣻⡲⡤⡀⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣔⠗⢃⣡⢤⣖⣖⡮⣖⣖⣞⢎⡸⡽⣝⣖⡀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⣔⡮⢞⢤⢞⣽⡺⣳⡳⣕⡯⣞⢮⣞⢽⡺⣝⣞⢮⢯⡂⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢤⢮⢯⢞⣞⡽⣝⢽⡺⣪⢷⢝⡮⡯⣞⢗⣗⢯⣫⢞⡮⡯⣳⣫⠄⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠪⢯⣫⢗⡯⡯⣺⢮⢗⡯⣞⡽⡵⣫⢯⣫⣞⢽⣪⢷⢽⢝⣞⡽⡵⣳⡃⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠐⠈⡀⠄⠑⢯⢞⡽⣵⡫⣗⢯⣞⢽⢝⡵⡯⣞⢮⢯⣺⢵⣫⢯⡺⡮⡯⣗⡇⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠂⠠⢈⠠⢀⠐⠠⠀⡙⢝⣞⣞⢽⢵⣳⡫⡯⣞⡽⡮⡯⣳⣳⣫⢾⢵⢯⢯⢯⣳⠃⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠠⠈⡀⠂⢁⠐⠀⠄⡀⠂⠄⢁⠠⠈⢺⣪⢯⣳⡳⡽⣝⣞⢮⢯⢞⣗⣵⡳⡯⡯⡯⡯⡯⠎⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⢂⠠⠐⢀⠐⠈⡀⠄⠁⠄⠐⠠⠈⡀⠄⢈⠀⠱⣫⣞⢞⡽⣺⣪⢯⢯⣳⣳⣳⢽⢽⢽⢽⠽⠁⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⢀⠐⢀⠐⡀⠄⠂⡀⠂⢁⠠⠀⡁⡈⠄⠁⠄⡀⠂⡀⠂⢁⠘⡮⣻⡺⣵⡳⡯⣗⣗⢷⢽⢽⢽⠝⠁⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠐⢀⠐⠀⠄⠠⠐⢀⠐⠈⡀⠄⠂⠠⠀⡐⠈⡀⠄⠂⠐⠈⡀⠄⠘⣗⡽⡮⣯⣻⣺⣺⢽⠝⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠠⠁⠀⠄⠂⢀⠁⡐⠀⠄⢁⠠⠀⠌⢀⠂⡀⠂⠠⠐⠈⡀⢁⢀⠂⠅⢜⡽⣽⣺⣺⠺⠊⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠂⡀⢁⠀⠂⡀⠄⠠⠈⡀⠂⡀⠂⡈⠀⠄⠐⠈⡀⠂⡁⡐⡐⠄⢅⠑⠄⣟⠞⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⡁⠀⠠⠐⠀⡀⠄⠐⢀⠐⠠⠐⠀⠄⠁⠄⠁⡂⠄⠅⡂⡂⡂⠅⡂⠅⠁⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠠⠈⠀⠄⠂⢀⠀⠂⡀⠂⡐⠈⠠⠈⡐⠨⠐⠄⠅⠅⡂⡂⡂⠅⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠐⠈⠀⠄⠂⢀⠐⠀⡐⢀⠐⡈⡐⠨⠠⠡⠡⠡⠡⡁⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠁⠄⠐⢀⠀⡂⠠⡐⢐⢐⠠⠡⠡⠡⠡⠁⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠁⠢⠨⠠⡁⡂⠅⡂⠌⠌⠌⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀Vicodin - nvim without the pain⠀⠀⠀⠀⠀⠀⠀  ',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  }, '\n'),
})

-- mini.comment
require('mini.comment').setup()
