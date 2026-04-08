local M = {}

function M:setup()
  -- Favor readable diagnostics without making the buffer feel too noisy while typing.
  vim.diagnostic.config({
    update_in_insert = false,
    severity_sort = true,
    float = {
      border = "rounded",
      source = "if_many",
    },
    underline = {
      severity = {
        min = vim.diagnostic.severity.WARN,
      },
    },
    virtual_text = true,
    virtual_lines = false,
    jump = {
      float = true,
    },
  })
end

return M
