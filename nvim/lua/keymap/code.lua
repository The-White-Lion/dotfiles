local util = require("keymap.util")

return {
  gd = { mode = "n", rhs = vim.lsp.buf.definition, opts = { desc = "Go to definition" } },
  gD = { mode = "n", rhs = vim.lsp.buf.declaration, opts = { desc = "Go to declaration" } },
  gi = { mode = "n", rhs = vim.lsp.buf.implementation, opts = { desc = "Go to implementation" } },
  gr = { mode = "n", rhs = vim.lsp.buf.references, opts = { desc = "List references" } },
  ["[d"] = { mode = "n", rhs = util.diagnostic_jump(-1), opts = { desc = "Previous diagnostic" } },
  ["]d"] = { mode = "n", rhs = util.diagnostic_jump(1), opts = { desc = "Next diagnostic" } },
  ["<leader>lq"] = {
    mode = "n",
    rhs = function()
      vim.diagnostic.setloclist({ open = true })
    end,
    opts = { desc = "Open diagnostic location list" },
  },
  ["<leader>k"] = { mode = "n", rhs = vim.lsp.buf.hover, opts = { desc = "LSP hover" } },
  ["<leader>lr"] = { mode = "n", rhs = vim.lsp.buf.rename, opts = { desc = "Rename symbol" } },
  ["<leader>la"] = { mode = "n", rhs = vim.lsp.buf.code_action, opts = { desc = "Code action" } },
  ["<leader>lf"] = {
    mode = "n",
    rhs = function()
      vim.lsp.buf.format({
        filter = function(client)
          return client.name == "null-ls"
        end,
      })
    end,
    opts = { desc = "Format with none-ls only" },
  },
  ["<leader>le"] = { mode = "n", rhs = vim.diagnostic.open_float, opts = { desc = "Line diagnostics" } },
}
