function fmt_buf()
  -- Check if buffer has a filename
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname == '' then
    vim.notify('Cannot save: no file name', vim.log.levels.ERROR)
    return
  end

  -- Check if buffer is modifiable
  if not vim.bo.modifiable then
    vim.notify('Cannot save: buffer not modifiable', vim.log.levels.ERROR)
    return
  end

  local ok, err = pcall(function()
    require('conform').format({
      async = false,
      timeout_ms = 3000,
    })
  end)

  if not ok then
    vim.notify('Format failed: ' .. tostring(err), vim.log.levels.ERROR)
    return
  end

  -- Try to save
  local save_ok, save_err = pcall(vim.cmd, 'write')
  if not save_ok then
    vim.notify('Save failed: ' .. tostring(save_err), vim.log.levels.ERROR)
  end
end
 
vim.api.nvim_create_user_command('Fmt', fmt_buf, {})

vim.api.nvim_create_user_command('FmtEnable', function()
  vim.g.fmt_enabled = true
  vim.notify('Formatting enabled', vim.log.levels.INFO)
end, {})

vim.api.nvim_create_user_command('FmtDisable', function()
  vim.g.fmt_enabled = false
  vim.notify('Formatting disabled', vim.log.levels.INFO)
end, {})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"cpp", "cuda"},
  callback = function()
    -- prevent text from jumping back when I type :: 
    vim.opt_local.cinkeys:remove(":")
  end,
})
