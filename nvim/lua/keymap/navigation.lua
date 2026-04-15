return {
  -- Move by display line so wrapped text navigation stays intuitive.
  ["J"] = { mode = "n", rhs = "5gj", opts = { desc = "Move down 5 display lines" } },
  ["K"] = { mode = "n", rhs = "5gk", opts = { desc = "Move up 5 display lines" } },
  ["j"] = {
    mode = { "n", "v" },
    rhs = "v:count == 0 ? 'gj' : 'j'",
    opts = { desc = "Move down by display line", expr = true },
  },
  ["k"] = {
    mode = { "n", "v" },
    rhs = "v:count == 0 ? 'gk' : 'k'",
    opts = { desc = "Move up by display line", expr = true },
  },
  ["0"] = { mode = "n", rhs = "g0", opts = { desc = "Jump to the start of the display line" } },
  ["$"] = { mode = "n", rhs = "g$", opts = { desc = "Jump to the end of the display line" } },

  -- windows navigation
  ["<C-h>"] = { mode = "n", rhs = "<C-w><C-h>", opts = { desc = "Focus left window" } },
  ["<C-j>"] = { mode = "n", rhs = "<C-w><C-j>", opts = { desc = "Focus lower window" } },
  ["<C-k>"] = { mode = "n", rhs = "<C-w><C-k>", opts = { desc = "Focus upper window" } },
  ["<C-l>"] = { mode = "n", rhs = "<C-w><C-l>", opts = { desc = "Focus right window" } },

  ["<leader>ws"] = { mode = "n", rhs = "<Cmd>split<CR>", opts = { desc = "Horizontal split" } },
  ["<leader>wv"] = { mode = "n", rhs = "<Cmd>vsplit<CR>", opts = { desc = "Vertical split" } },
  ["<leader>wq"] = { mode = "n", rhs = "<Cmd>close<CR>", opts = { desc = "Close window" } },
  ["<leader>w="] = { mode = "n", rhs = "<C-w>=", opts = { desc = "Balance windows" } },
  ["<leader>wH"] = { mode = "n", rhs = "<C-w>H", opts = { desc = "Move window far left" } },
  ["<leader>wJ"] = { mode = "n", rhs = "<C-w>J", opts = { desc = "Move window to bottom" } },
  ["<leader>wK"] = { mode = "n", rhs = "<C-w>K", opts = { desc = "Move window to top" } },
  ["<leader>wL"] = { mode = "n", rhs = "<C-w>L", opts = { desc = "Move window far right" } },

  -- resize windows
  ["<M-k>"] = { mode = "n", rhs = "<Cmd>resize -2<CR>", opts = { desc = "Decrease window height" } },
  ["<M-j>"] = { mode = "n", rhs = "<Cmd>resize +2<CR>", opts = { desc = "Increase window height" } },
  ["<M-l>"] = { mode = "n", rhs = "<Cmd>vertical resize -2<CR>", opts = { desc = "Decrease window width" } },
  ["<M-h>"] = { mode = "n", rhs = "<Cmd>vertical resize +2<CR>", opts = { desc = "Increase window width" } },

  -- buffers navigation
  ["<leader>bp"] = { mode = "n", rhs = "<Cmd>bprev<CR>", opts = { desc = "Previous buffer" } },
  ["<leader>bn"] = { mode = "n", rhs = "<Cmd>bnext<CR>", opts = { desc = "Next buffer" } },
  ["<leader>bd"] = { mode = "n", rhs = "<Cmd>bdelete<CR>", opts = { desc = "Delete buffer" } },

  -- tabs navigation
  ["<leader>tt"] = { mode = "n", rhs = "<Cmd>tabnew<CR>", opts = { desc = "New tab" } },
  ["<leader>tp"] = { mode = "n", rhs = "<Cmd>tabprev<CR>", opts = { desc = "Previous tab" } },
  ["<leader>tn"] = { mode = "n", rhs = "<Cmd>tabnext<CR>", opts = { desc = "Next tab" } },

  -- nvim tree

  -- telescope
  ["<leader>ff"] = { mode = "n", rhs = "<Cmd>Telescope find_files<CR>", opts = { desc = "Find files" } },
  ["<leader>fg"] = { mode = "n", rhs = "<Cmd>Telescope live_grep<CR>", opts = { desc = "Live grep" } },
  ["<leader>fb"] = { mode = "n", rhs = "<Cmd>Telescope buffers<CR>", opts = { desc = "Find buffers" } },
  ["<leader>fh"] = { mode = "n", rhs = "<Cmd>Telescope help_tags<CR>", opts = { desc = "Find help tags" } },

  -- toggleterm
  ["<C-\\>"] = { mode = { "n", "i", "t" }, rhs = "<Esc><Cmd>ToggleTerm<CR>", opts = { desc = "terminal: Toggle" } },
  ["<Esc><Esc>"] = { mode = "n", rhs = "<C-\\><C-n>", opts = { desc = "Exit terminal mode" } },
}
