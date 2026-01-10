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
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

    },
    opts = {
      workspaces = {
        {
          name = "Notes",
          path = "~/Notes/Vault",
        },
      },
      ui = {
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "󰄲", hl_group = "ObsidianDone" },
          -- [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          -- ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
          -- ["!"] = { char = "", hl_group = "ObsidianImportant" },
          -- Replace the above with this if you don't have a patched font:
          -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
          -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

          -- You can also add more custom ones...
        },
      }
    },
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
