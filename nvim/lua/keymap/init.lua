local M = {}
local default_opts = { silent = true }
local keymap_files = {
  require("keymap.editor"),
  require("keymap.navigation"),
  require("keymap.code"),
  require("keymap.tool"),
}

local function set_keymap(lhs, map)
  local mode = map["mode"]
  local rhs = map["rhs"]
  local opts = vim.tbl_extend("force", vim.deepcopy(default_opts), map["opts"] or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M:init()
  for _, keymaps in ipairs(keymap_files) do
    for lhs, map in pairs(keymaps) do
      set_keymap(lhs, map)
    end
  end
end

return M
