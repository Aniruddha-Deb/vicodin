vim.api.nvim_create_autocmd("FileType", {
  pattern = {"cpp", "cuda"},
  callback = function()
    -- prevent text from jumping back when I type :: 
    vim.opt_local.cinkeys:remove(":")
  end,
})
