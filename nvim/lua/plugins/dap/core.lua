local M = {}

local registry = require("plugins.dap.registry")

local function normalize_adapter_key(lang, spec)
  return spec.adapter_key or spec.mason or lang
end
function M.register_configurations_and_adapters()
  local dap = require("dap")
  for lang, spec in pairs(registry) do
    -- register adpater
    local adapter_key = normalize_adapter_key(lang, spec)
    dap.adapters[adapter_key] = spec.adapter

    -- register one configurations for different filetype
    local filetypes = spec.filetypes or { lang }
    for _, ft in ipairs(filetypes) do
      local items = {}
      for _, config in ipairs(spec.configurations or {}) do
        items[#items + 1] = vim.tbl_extend("force", { type = adapter_key }, config)
      end
      dap.configurations[ft] = items
    end
  end
end

function M.ensure_installed()
  local items = {}
  for _, spec in pairs(registry) do
    if spec.mason then
      table.insert(items, spec.mason)
    end
  end

  return items
end

return M
