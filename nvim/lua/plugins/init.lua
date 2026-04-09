local function concat_specs(...)
  local result = {}
  for _, specs in ipairs({ ... }) do
    vim.list_extend(result, specs)
  end
  return result
end

return concat_specs(
  require("plugins.ui"),
  require("plugins.tool"),
  require("plugins.editor"),
  require("plugins.lsp"),
  require("plugins.completion")
)
