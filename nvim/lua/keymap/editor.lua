return {
  ["<Space>"] = { mode = "n", rhs = "<nop>", opts = { desc = "leader placeholder" } },

  -- Files and session
  ["<leader>w"] = { mode = "n", rhs = "<Cmd>w<CR>", opts = { desc = "Write file" } },
  ["<C-s>"] = { mode = "n", rhs = "<Cmd>w<CR>", opts = { desc = "Write file" } },
  ["<leader>q"] = { mode = "n", rhs = "<Cmd>q<CR>", opts = { desc = "Quit window" } },
  ["<leader>Q"] = { mode = "n", rhs = "<Cmd>qa!<CR>", opts = { desc = "Quit all forcefully" } },

  -- Search helpers
  ["<leader>h"] = { mode = "n", rhs = "<Cmd>nohlsearch<CR>", opts = { desc = "Clear search highlight" } },
  ["<leader><CR>"] = { mode = "n", rhs = "<Cmd>nohlsearch<CR>", opts = { desc = "Clear search highlight" } },
  ["jk"] = { mode = "i", rhs = "<Esc>", opts = { desc = "Exit insert mode" } },
  ["Wq<CR>"] = { mode = "c", rhs = "wq<CR>", opts = { desc = "Fix mixed-case write quit command" } },
  ["WQ<CR>"] = { mode = "c", rhs = "wq<CR>", opts = { desc = "Fix uppercase write quit command" } },
}
