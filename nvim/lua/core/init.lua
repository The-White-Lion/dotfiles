local M = {}

-- local function apply_transparency()
--   -- Colorschemes often overwrite highlight groups, so keep this logic centralized
--   -- and reusable for both startup and later ColorScheme events.
--   local groups = { "Normal", "NonText", "LineNr", "Folded", "EndOfBuffer" }

--   for _, group in ipairs(groups) do
--     vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
--   end
-- end

function M:init()
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  require("core.options")
  require("core.diagnostics"):setup()
  require("core.lsp"):setup()
  require("keymap"):init()
  require("core.autocmds")
  require("core.lazy")
  -- apply_transparency()

  -- vim.api.nvim_create_autocmd("ColorScheme", {
  --   group = vim.api.nvim_create_augroup("core_transparency", { clear = true }),
  --   callback = apply_transparency,
  --   desc = "Reapply transparent backgrounds after colorscheme changes",
  -- })
end

return M
