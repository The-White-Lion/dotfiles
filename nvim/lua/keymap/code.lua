local util = require("keymap.util")

return {
  n = {
    ["[d"] = { util.diagnostic_jump(-1), { desc = "Previous diagnostic" } },
    ["]d"] = { util.diagnostic_jump(1), { desc = "Next diagnostic" } },
    ["<leader>lq"] = {
      function()
        vim.diagnostic.setloclist({ open = true })
      end,
      { desc = "Open diagnostic location list" },
    },
    ["<leader>k"] = { vim.lsp.buf.hover, { desc = "LSP hover" } },
    gd = { vim.lsp.buf.definition, { desc = "Go to definition" } },
    gD = { vim.lsp.buf.declaration, { desc = "Go to declaration" } },
    gi = { vim.lsp.buf.implementation, { desc = "Go to implementation" } },
    gr = { vim.lsp.buf.references, { desc = "List references" } },
    ["<leader>ln"] = { vim.lsp.buf.rename, { desc = "Rename symbol" } },
    ["<leader>la"] = { vim.lsp.buf.code_action, { desc = "Code action" } },
    ["<leader>lf"] = {
      function()
        vim.lsp.buf.format({ async = true })
      end,
      { desc = "Format buffer" },
    },
    ["<leader>le"] = { vim.diagnostic.open_float, { desc = "Line diagnostics" } },
  },
}
