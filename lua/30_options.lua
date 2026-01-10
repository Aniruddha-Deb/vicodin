vim.opt.encoding = "utf-8"
vim.opt.mouse = "a"
vim.opt.inccommand = "nosplit"
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.exrc = true
vim.opt.cc = "100"
vim.opt.wrap = false
vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.cinkeys:remove('0:')
vim.opt.incsearch = true
vim.opt.backspace = "indent,eol,start"
vim.opt.hlsearch = true
vim.opt.wildmenu = true
vim.opt.showmode = false
vim.opt.conceallevel = 2

vim.cmd.colorscheme "catppuccin"
