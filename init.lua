--- @param dir string i.e. "plugins"
local require_dir = function(dir)
  -- ~/.config/nvim/lua/
  local base_lua_path = vim.fs.joinpath(vim.fn.stdpath "config", "lua")

  -- i.e. ~/.config/nvim/lua/plugins/*.lua
  local glob_path = vim.fs.joinpath(base_lua_path, dir, "*.lua")

  local paths_str = vim.fn.glob(glob_path)
  local paths_tbl = vim.split(paths_str, "\n")

  for _, path in pairs(paths_tbl) do
    -- convert absolute filename to relative
    -- ~/.config/nvim/lua/plugins/config_file.lua -> plugins/config_file
    local relfilename = vim.fs.relpath(base_lua_path, path):gsub(".lua", "")
    require(relfilename)
  end
end

require_dir("")
