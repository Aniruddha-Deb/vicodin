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
  { "<leader>t",  group = "format (all)" },
  { "<leader>tt", "<cmd>lua require('conform').format({ async = false })<cr>", desc = "Format current buffer" },
  { "<leader>te", toggle_format_on_save_all,                                   desc = "Toggle format on save (all)" },
})

wk.add({
  { "<localleader>t",  group = "format (buffer)" },
  { "<localleader>tt", "<cmd>lua require('conform').format({ async = false })<cr>", desc = "Format this buffer" },
  { "<localleader>te", toggle_format_on_save_buffer,                                desc = "Toggle format on save (buffer)" },
})

-- Autocompletion and LSP
local blink_config = require('blink.cmp.config')
local completion_enabled = true

local function toggle_completion()
  completion_enabled = not completion_enabled
  -- Modify blink.cmp's enabled function at runtime
  blink_config.enabled = function() return completion_enabled end

  if completion_enabled then
    print("Autocompletion enabled")
  else
    -- Hide any open completion menu
    require('blink.cmp').hide()
    print("Autocompletion disabled")
  end
end

local function diagnostic_jump(count)
  return function()
    vim.diagnostic.jump({ count = count, float = true })
  end
end

wk.add({
  { "<leader>c",  group = "code" },
  { "<leader>ce", toggle_completion,                          desc = "Toggle autocompletion" },
  { "<leader>cc", function() require('blink.cmp').show() end, desc = "Show completions" },
  { "<F2>",       vim.lsp.buf.rename,                         desc = "Rename symbol" },
  { "<leader>ca", vim.lsp.buf.code_action,                    desc = "Code action" },
  { "[d",         diagnostic_jump(-1),                        desc = "Previous diagnostic" },
  { "]d",         diagnostic_jump(1),                         desc = "Next diagnostic" },
  { "gi",         vim.lsp.buf.implementation,                 desc = "Go to implementation" },
  { "gd",         vim.lsp.buf.definition,                     desc = "Go to definition" },
  { "[q",         "<cmd>cprev<cr>",                           desc = "Previous quickfix" },
  { "]q",         "<cmd>cnext<cr>",                           desc = "Next quickfix" },
  -- gcc -> commenting handled by mini.comment
})

-- Diagnostics
local diagnostics_enabled = {}
local inline_diagnostics_enabled = true

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

local function toggle_inline_diagnostics()
  inline_diagnostics_enabled = not inline_diagnostics_enabled
  vim.diagnostic.config({
    virtual_text = inline_diagnostics_enabled,
  })
  print("Inline diagnostics " .. (inline_diagnostics_enabled and "enabled" or "disabled"))
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
  { "<leader>d",  group = "diagnostics" },
  { "<leader>de", toggle_diagnostics,         desc = "Toggle diagnostics" },
  { "<leader>di", toggle_inline_diagnostics,  desc = "Toggle inline diagnostics" },
  { "<leader>do", enable_diagnostics_overlay, desc = "Enable diagnostics overlay" },
  { "<leader>dw", vim.diagnostic.setloclist,  desc = "Show diagnostics window" },
})

-- Help
wk.add({
  { "<leader>?", "<cmd>WhichKey<cr>", desc = "Show all keymaps" },
})
