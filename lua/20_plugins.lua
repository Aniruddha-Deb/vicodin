local spec = {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      delay = 2000,
    }
  },
  {
    'tpope/vim-sleuth',
  },
  {
    'mcchrish/zenbones.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        python = { "isort", "black" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        cpp = { "clang-format" },
        c = { "clang-format" }
      },
      default_format_opts = {
        lsp_format = "fallback",
      }
    }
  },
  {
    'ibhagwan/fzf-lua',
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {},
  },
  {
    'nvim-lualine/lualine.nvim',
  },
  {
    'echasnovski/mini.nvim',
    config = function(_, opts)
      require('mini.comment').setup()
      require('mini.pairs').setup()
      require('mini.ai').setup()
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = false,
        },
        autotag = {
          enable = true,
        },
      })
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'master'
  },
  {
    'neovim/nvim-lspconfig'
  },
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
  },
}

require("lazy").setup({
  spec = spec,
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
})
