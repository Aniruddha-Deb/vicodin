vim.api.nvim_create_user_command('TSEnable', function()
  if not vim.g.ts_enabled then
    vim.treesitter.start()
    vim.g.ts_enabled = true
    print('Enabled TreeSitter')
  else
    print('TreeSitter already enabled')
  end
end, {})

vim.api.nvim_create_user_command('TSDisable', function()
  if vim.g.ts_enabled then
    vim.treesitter.stop()
    vim.g.ts_enabled = false
    print('Disabled TreeSitter')
  else
    print('TreeSitter already disabled')
  end
end, {})
