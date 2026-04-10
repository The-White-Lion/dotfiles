local M = {}
local default_opts = { silent = true }
local keymap_files = {
  require("keymap.editing"),
  require("keymap.navigation"),
  require("keymap.code"),
}

local function apply_keymap(mode, lhs, mapping)
  if type(mapping) ~= "table" or mapping[1] == nil then
    vim.keymap.set(mode, lhs, mapping, default_opts)
    return
  end

  local rhs = mapping[1]
  local opts = vim.tbl_extend("force", vim.deepcopy(default_opts), mapping[2] or {})

  vim.keymap.set(mode, lhs, rhs, opts)
end

function M:init()
  for _, keymaps in ipairs(keymap_files) do
    for mode, mappings in pairs(keymaps) do
      for lhs, mapping in pairs(mappings) do
        apply_keymap(mode, lhs, mapping)
      end
    end
  end
end

return M
