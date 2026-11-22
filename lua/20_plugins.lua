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
    'catppuccin/nvim',
    name = "catppuccin",
    priority = 1000,
    opts = {
      auto_integrations = true
    }
  },
  {
    'esmuellert/codediff.nvim',
    cmd = 'CodeDiff',
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        python = { "isort", "black" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        cpp = { "clang-format" },
        c = { "clang-format" },
        rust = { "rustfmt" }
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
    opts = {
      options = {
        icons_enabled = false,
        theme = custom_theme,
        component_separators = '',
        section_separators = ''
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'filetype'},
        lualine_y = {'location'},
        lualine_z = {'branch'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'filetype'},
        lualine_y = {'location'},
        lualine_z = {'branch'}
      }
    }
  },
  {
    'echasnovski/mini.nvim',
    config = function(_, opts)
      require('mini.comment').setup()
      require('mini.pairs').setup()
      require('mini.ai').setup()
      require('mini.surround').setup()
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install({
        'cpp', 'c', 'html', 'javascript', 'java', 'json', 'lua', 'markdown',
        'markdown_inline', 'ocaml', 'python', 'rust', 'scss', 'svelte',
        'typescript', 'xml', 'yaml',
      })
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          -- no-op if there's no parser for this filetype
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main'
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
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require('nvim-tree').setup()
    end
  }
}

require("lazy").setup({
  spec = spec,
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
})
