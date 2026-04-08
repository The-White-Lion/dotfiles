local function load_options()
  local options = {
    mouse = "a",
    backup = false,
    fileencoding = "utf-8",
    cmdheight = 1,
    completeopt = { "menuone", "noselect" },
    breakindent = true,
    confirm = true,
    number = true,
    numberwidth = 4,
    signcolumn = "yes",
    relativenumber = true,
    wrap = true,
    cursorline = true,
    showmode = false,
    splitbelow = true,
    splitright = true,
    expandtab = true,
    shiftwidth = 2,
    tabstop = 2,
    undofile = true,
    updatetime = 250,
    timeoutlen = 500,
    ignorecase = true,
    smartcase = true,
    incsearch = true,
    inccommand = "split",
    hlsearch = true,
    scrolloff = 5,
    termguicolors = true,
    list = true,
    listchars = {
      tab = "▸ ",
      trail = "·",
      extends = "▸",
      precedes = "◂",
    },
  }

  for k, v in pairs(options) do
    vim.opt[k] = v
  end

  -- Only enable system clipboard integration when the current Neovim build supports it.
  if vim.fn.has("clipboard") == 1 then
    vim.opt.clipboard = "unnamedplus"
  end
end

-- disable netrw at the very start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

load_options()