
vim.g.mapleader = " "
vim.g.maplocaleader = "\\"

local wk = require('which-key')
local fzf = require('fzf-lua')

-- fuzzy finding - <leader>f
-- <leader>ff - files
-- <leader>fg - grep
-- <leader>fd - diagnostics
-- <leader>fb - buffers

-- autofmt - <leader>t / <localleader>t
-- <leader>tt - autofmt all buffers
-- <leader>te - format on save toggle across all buffers
-- <localleader>tt - autofmt this buffers
-- <localleader>te - format on save toggle for this buffer 

-- autocompletion - <leader>c
-- <leader>ce - toggle autocompletion on all buffers
-- <leader>cc - show autocompletion suggestions
-- <leader>cr - rename symbol under cursor
-- <leader>ca - code action

-- diagnostics - <leader>d
-- <leader>de - toggle diagnostics on current buffer
-- <leader>do - enable diagnostics overlay
-- <ledaer>dw - show diagnostics/errors window

-- syntax highlighting - <leader>h
-- <leader>he - enable/disable syntax highlighting

-- help - <leader>?

-- Fuzzy Finding
wk.add({
  { "<leader>f", group = "find" },
  { "<leader>ff", fzf.files, desc = "Find files" },
  { "<leader>fg", fzf.live_grep, desc = "Live grep" },
  { "<leader>fd", fzf.diagnostics_document, desc = "Diagnostics" },
  { "<leader>fb", fzf.buffers, desc = "Buffers" },
})

-- Auto-formatting
local format_on_save_enabled = true
local format_on_save_buffer = {}

local function toggle_format_on_save_all()
  format_on_save_enabled = not format_on_save_enabled
  print("Format on save " .. (format_on_save_enabled and "enabled" or "disabled") .. " globally")
end

local function toggle_format_on_save_buffer()
  local buf = vim.api.nvim_get_current_buf()
  format_on_save_buffer[buf] = not (format_on_save_buffer[buf] or false)
  print("Format on save " .. (format_on_save_buffer[buf] and "enabled" or "disabled") .. " for buffer " .. buf)
end

local function format_enabled_for_buffer(buf)
  if format_on_save_buffer[buf] ~= nil then
    return format_on_save_buffer[buf]
  end
  return format_on_save_enabled
end

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    if format_enabled_for_buffer(args.buf) then
      require("conform").format({ bufnr = args.buf })
    end
  end,
})

wk.add({
  { "<leader>t", group = "format (all)" },
  { "<leader>tt", "<cmd>lua require('conform').format({ async = false })<cr>", desc = "Format current buffer" },
  { "<leader>te", toggle_format_on_save_all, desc = "Toggle format on save (all)" },
})

wk.add({
  { "<localleader>t", group = "format (buffer)" },
  { "<localleader>tt", "<cmd>lua require('conform').format({ async = false })<cr>", desc = "Format this buffer" },
  { "<localleader>te", toggle_format_on_save_buffer, desc = "Toggle format on save (buffer)" },
})

-- Autocompletion and LSP
local completion_enabled = true

local function toggle_completion()
  completion_enabled = not completion_enabled
  if completion_enabled then
    vim.lsp.completion.enable(true)
    print("Autocompletion enabled")
  else
    vim.lsp.completion.enable(false)
    print("Autocompletion disabled")
  end
end

wk.add({
  { "<leader>c", group = "code" },
  { "<leader>ce", toggle_completion, desc = "Toggle autocompletion" },
  { "<leader>cc", vim.lsp.completion.trigger, desc = "Show completions" },
  { "<leader>cr", vim.lsp.buf.rename, desc = "Rename symbol" },
  { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action" },
})

-- Diagnostics
local diagnostics_enabled = {}

local function toggle_diagnostics()
  local buf = vim.api.nvim_get_current_buf()
  if diagnostics_enabled[buf] == nil then
    diagnostics_enabled[buf] = true
  end

  if diagnostics_enabled[buf] then
    vim.diagnostic.enable(false, { bufnr = buf })
    diagnostics_enabled[buf] = false
    print("Diagnostics disabled for buffer " .. buf)
  else
    vim.diagnostic.enable(true, { bufnr = buf })
    diagnostics_enabled[buf] = true
    print("Diagnostics enabled for buffer " .. buf)
  end
end

local function enable_diagnostics_overlay()
  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
  })
  print("Diagnostics overlay enabled")
end

wk.add({
  { "<leader>d", group = "diagnostics" },
  { "<leader>de", toggle_diagnostics, desc = "Toggle diagnostics" },
  { "<leader>do", enable_diagnostics_overlay, desc = "Enable diagnostics overlay" },
  { "<leader>dw", vim.diagnostic.setloclist, desc = "Show diagnostics window" },
})

-- Syntax Highlighting
local function toggle_syntax()
  if vim.g.syntax_on then
    vim.cmd("syntax off")
    print("Syntax highlighting disabled")
  else
    vim.cmd("syntax on")
    print("Syntax highlighting enabled")
  end
end

wk.add({
  { "<leader>h", group = "highlighting" },
  { "<leader>he", toggle_syntax, desc = "Toggle syntax highlighting" },
})

-- Help
wk.add({
  { "<leader>?", "<cmd>WhichKey<cr>", desc = "Show all keymaps" },
})
