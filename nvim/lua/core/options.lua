local function load_options()
  local options = {
    mouse = "a",
    backup = false,
    breakindent = true,
    confirm = true,
    completeopt = { "menuone", "noselect" },
    cursorline = true,
    cmdheight = 1,
    expandtab = true,
    fileencoding = "utf-8",
    foldenable = true,
    foldlevel = 99,
    foldlevelstart = 99,
    hlsearch = true,
    incsearch = true,
    inccommand = "split",
    ignorecase = true,
    list = true,
    listchars = {
      tab = "▸ ",
      trail = "·",
      extends = "▸",
      precedes = "◂",
    },
    number = true,
    numberwidth = 4,
    relativenumber = true,
    scrolloff = 5,
    signcolumn = "yes",
    shiftwidth = 2,
    showmode = false,
    smartcase = true,
    splitbelow = true,
    splitright = true,
    tabstop = 2,
    timeoutlen = 500,
    termguicolors = true,
    updatetime = 250,
    undofile = true,
    wrap = true,
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
