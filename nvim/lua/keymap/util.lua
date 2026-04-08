local M = {}

function M.diagnostic_jump(count)
  return function()
    local diagnostic = vim.diagnostic.jump({ count = count })

    if diagnostic then
      vim.diagnostic.open_float({
        scope = "cursor",
        focus = false,
      })
    end
  end
end

return M
