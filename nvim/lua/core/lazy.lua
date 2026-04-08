local M = {}

function M:setup()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local result = vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=stable",
      lazyrepo,
      lazypath,
    })

    if vim.v.shell_error ~= 0 then
      error("Failed to clone lazy.nvim:\n" .. result)
    end
  end

  local function require_dir(dir)
    local path = vim.fn.stdpath("config") .. "/lua/plugins" .. dir:gsub("%.", "/")

    for file, type in vim.fs.dir(path) do
      if type == "file" and file:match("%.lua$") then
        local module = dir .. "." .. file:gsub("%.lua$", "")
        require(module)
      end
    end
  end

require_dir("plugins")
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup({require("plugins")})
end

return M
