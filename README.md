- [X] fzf
- [ ] mini
  - [ ] Configuration
- [X] LuaSnip
- [X] TreeSitter
- [ ] Autoformatter
- [ ] LSP 
  - [ ] Snippet Engine Integration
- [X] LuaLine

- sourcetree plugins


```
plugins = 

git remote add conform.nvim https://github.com/stevearc/conform.nvim
git remote add fzf.lua https://github.com/ibhagwan/fzf.lua
git remote add gitsigns.nvim https://github.com/lewis6991/gitsigns.nvim
git remote add lualine.nvim https://github.com/nvim-lualine/lualine.nvim
git remote add LuaSnip https://github.com/L3MON4D3/LuaSnip
git remote add mini.nvim https://github.com/echasnovski/mini.nvim
git remote add nvim-lspconfig https://github.com/neovim/nvim-lspconfig
git remote add nvim-treesitter https://github.com/nvim-treesitter/nvim-treesitter
git remote add vim-sleuth https://github.com/tpope/vim-sleuth
git remote add which-key.nvim https://github.com/folke/which-key.nvim

git fetch conform.nvim
git fetch fzf.lua
git fetch gitsigns.nvim
git fetch lualine.nvim
git fetch LuaSnip
git fetch mini.nvim
git fetch nvim-lspconfig
git fetch nvim-treesitter
git fetch vim-sleuth
git fetch which-key.nvim

git subtree add --prefix=externals/conform.nvim conform.nvim main --squash
git subtree add --prefix=externals/fzf.lua fzf.lua main --squash
git subtree add --prefix=externals/gitsigns.nvim gitsigns.nvim main --squash
git subtree add --prefix=externals/lualine.nvim lualine.nvim main --squash
git subtree add --prefix=externals/LuaSnip LuaSnip main --squash
git subtree add --prefix=externals/mini.nvim mini.nvim main --squash
git subtree add --prefix=externals/nvim-lspconfig nvim-lspconfig main --squash
git subtree add --prefix=externals/nvim-treesitter nvim-treesitter main --squash
git subtree add --prefix=externals/vim-sleuth vim-sleuth main --squash
git subtree add --prefix=externals/which-key.nvim which-key.nvim main --squash
```
