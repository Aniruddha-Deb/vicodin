vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.exists("*netrw_gitignore#Hide") == 1 then
      local hide = vim.fn["netrw_gitignore#Hide"]()
      vim.g.netrw_list_hide = ',\\(^\\|\\s\\s\\)\\zs\\.\\S\\+' .. hide
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  -- prevents backindentation when typing :: for namespaces in c++, eg std::.
  -- has to be called on FileType because broad-spectrum disabling cindent
  -- doesn't work for some reason
  pattern = { "c", "cpp" },
  callback = function()
    vim.bo.cindent = false
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp', 'rust', 'javascript', 'markdown', 'html', 'css', 'ocaml', 'zig', 'java' },
  callback = function()
    if vim.g.ts_enabled then
      vim.treesitter.start()
    end
  end,
})
