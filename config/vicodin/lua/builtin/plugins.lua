-- monokai-pro.nvim
require('monokai-pro').setup({
	transparent_background = true,
	filter = "machine",
})
vim.cmd([[colorscheme monokai-pro]])

-- lualine.nvim
require('lualine').setup {
  sections = {
    lualine_b = {
  	{
  	  'branch',
  	  fmt = function(branch_name)
  		local max_length = 7
  		if #branch_name > max_length then
  		  return branch_name:sub(1, max_length) .. '_'
  		end
  		return branch_name
  	  end
  	},
  	'diagnostics',
  	'diff'
    },
    lualine_c = {
  	function()
  	  local symbols = {}
  	  if vim.bo.modified then
  		table.insert(symbols, '[+]')
  	  end
  	  if vim.bo.modifiable == false or vim.bo.readonly == true then
  		table.insert(symbols, '[-]')
  	  end

  	  local filename = vim.fn.expand('%')
  	  if filename == '' and vim.bo.buftype == '' and vim.fn.filereadable(filename) == 0 then
  		table.insert(symbols, '[New]')
  	  end

  	  return vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.') .. (#symbols > 0 and ' ' .. table.concat(symbols, '') or '')
  	end
    },
    lualine_x = {{'filetype', fmt = function() return " " end, right_padding=0}}
  }
}

