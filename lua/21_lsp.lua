-- LSP Configuration
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP log rotation
vim.lsp.set_log_level("warn")  -- Reduce logging (options: "trace", "debug", "info", "warn", "error", "off")

-- Automatically rotate log files when they exceed size limit
local lsp_log_path = vim.lsp.get_log_path()
local log_dir = vim.fn.fnamemodify(lsp_log_path, ':h')
local max_log_size = 1024 * 1024  -- 1 MB in bytes
local max_old_logs = 3  -- Keep this many old log files

-- Function to rotate logs based on size (runs on startup)
local function rotate_lsp_logs()
  local current_log = lsp_log_path

  -- Check if current log exists and its size
  local size = vim.fn.getfsize(current_log)
  if size > max_log_size then
    -- Get all existing rotated logs
    local log_files = vim.fn.glob(log_dir .. '/lsp.log.*', false, true)

    -- Sort by modification time, newest first
    table.sort(log_files, function(a, b)
      return vim.fn.getftime(a) > vim.fn.getftime(b)
    end)

    -- Delete oldest logs if we're at the limit
    if #log_files >= max_old_logs then
      for i = max_old_logs, #log_files do
        vim.fn.delete(log_files[i])
      end
    end

    -- Rotate current log
    local timestamp = os.date("%Y%m%d_%H%M%S")
    local rotated_name = string.format("%s/lsp.log.%s", log_dir, timestamp)
    vim.fn.rename(current_log, rotated_name)
  end
end

-- Check and rotate logs on startup
rotate_lsp_logs()

-- LSP server configurations
vim.lsp.config['clangd'] = {
  capabilities = capabilities,
  cmd = { "clangd", "--completion-style=detailed" }
}
vim.lsp.enable('clangd')

vim.lsp.config['ocamllsp'] = {
  capabilities = capabilities
}
vim.lsp.enable('ocamllsp')

vim.lsp.config['rust_analyzer'] = {
  capabilities = capabilities
}
vim.lsp.enable('rust_analyzer')

vim.lsp.config['pylsp'] = {
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391'},
          maxLineLength = 120
        }
      }
    }
  }
}
vim.lsp.enable('pylsp')

vim.lsp.config['zls'] = {
  capabilities = capabilities
}
vim.lsp.enable('zls')

vim.lsp.config['ts_ls'] = {
  capabilities = capabilities
}
vim.lsp.enable('ts_ls')

vim.lsp.config['svelte'] = {
  capabilities = capabilities
}
vim.lsp.enable('svelte')

vim.lsp.config['texlab'] = {
  capabilities = capabilities
}
vim.lsp.enable('texlab')


-- Completion configuration
local cmp = require('cmp')

-- Configuration variable for buffer completion
local enable_buffer_completion = false

-- Build sources based on configuration
local function build_cmp_sources()
  local sources = {
    { name = "nvim_lsp", max_item_count = 10 },
    { name = "path" },
  }

  if enable_buffer_completion then
    table.insert(sources, { name = "buffer" })
  end

  return sources
end

cmp.setup({
  completion = {
    autocomplete = false,
    completeopt = "menu,menuone,noinsert",
  },
  sources = build_cmp_sources(),
  sorting = require("cmp.config.default")().sorting,
})

-- Commands to toggle buffer completion
vim.api.nvim_create_user_command('CmpBufferEnable', function()
  enable_buffer_completion = true
  cmp.setup({ sources = build_cmp_sources() })
  vim.notify('Buffer completion enabled', vim.log.levels.INFO)
end, {})

vim.api.nvim_create_user_command('CmpBufferDisable', function()
  enable_buffer_completion = false
  cmp.setup({ sources = build_cmp_sources() })
  vim.notify('Buffer completion disabled', vim.log.levels.INFO)
end, {})
