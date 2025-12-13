 vim.g.mapleader = " "
 vim.g.maplocaleader = "\\"
 
 local wk = require('which-key')
 local fzf = require('fzf-lua')
 
 -- Fuzzy Finding
 wk.add({
   { "<leader>f",  group = "find" },
   { "<leader>ff", fzf.files,                desc = "Find files" },
   { "<leader>fg", fzf.live_grep,            desc = "Live grep" },
   { "<leader>fd", fzf.diagnostics_document, desc = "Diagnostics" },
   { "<leader>fb", fzf.buffers,              desc = "Buffers" },
 })
 
 wk.add({
   { "<leader>d", "<cmd>bd | bn<CR>", desc = "Delete buffer"},
 })
 
 -- Completion keymaps
 local cmp = require('cmp')
 
 cmp.setup({
   mapping = cmp.mapping.preset.insert({
     ["<C-b>"] = cmp.mapping.scroll_docs(-4),
     ["<C-f>"] = cmp.mapping.scroll_docs(4),
     ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
     ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
     ["<C-Space>"] = cmp.mapping.complete(),
     ["<Tab>"] = cmp.mapping.confirm({ select = true }),
     ["<CR>"] = cmp.mapping.confirm({ select = true })
   }),
 })
 
 -- LSP keymaps
 -- Global mappings for diagnostics
 vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
 vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
 vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
 vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
 
 -- Use LspAttach autocommand to only map the following keys
 -- after the language server attaches to the current buffer
 vim.api.nvim_create_autocmd('LspAttach', {
   group = vim.api.nvim_create_augroup('UserLspConfig', {}),
   callback = function(ev)
     -- Enable completion triggered by <c-x><c-o>
     vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
 
     -- Buffer local mappings
     local opts = { buffer = ev.buf }
     vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
     vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
     vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
     vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
     vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
     vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
     vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
     vim.keymap.set('n', '<space>wl', function()
       print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
     end, opts)
     vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
     vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
     vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
     vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
   end,
 })
 
 -- Help
 wk.add({
   { "<leader>?", "<cmd>WhichKey<cr>", desc = "Show all keymaps" },
 })
