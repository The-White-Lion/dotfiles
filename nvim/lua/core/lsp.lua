local M = {}

local function has_executable(bin)
  return vim.fn.executable(bin) == 1
end

function M:setup()
  -- Start with Lua so the config can understand itself without extra plugins.
  vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
      ".luarc.json",
      ".luarc.jsonc",
      ".git",
    },
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true),
        },
        hint = {
          enable = true,
        },
      },
    },
  })

  if has_executable("lua-language-server") then
    vim.lsp.enable("lua_ls")
  end
end

return M
