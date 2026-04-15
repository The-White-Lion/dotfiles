return {
  n = {
    -- Move by display line so wrapped text navigation stays intuitive.
    ["J"] = { "5gj", { desc = "Move down 5 display lines" } },
    ["K"] = { "5gk", { desc = "Move up 5 display lines" } },
    ["j"] = { "v:count == 0 ? 'gj' : 'j'", { desc = "Move down by display line", expr = true } },
    ["k"] = { "v:count == 0 ? 'gk' : 'k'", { desc = "Move up by display line", expr = true } },
    ["0"] = { "g0", { desc = "Jump to the start of the display line" } },
    ["$"] = { "g$", { desc = "Jump to the end of the display line" } },

    -- windows navigation
    ["<C-h>"] = { "<C-w><C-h>", { desc = "Focus left window" } },
    ["<C-j>"] = { "<C-w><C-j>", { desc = "Focus lower window" } },
    ["<C-k>"] = { "<C-w><C-k>", { desc = "Focus upper window" } },
    ["<C-l>"] = { "<C-w><C-l>", { desc = "Focus right window" } },

    ["<leader>ws"] = { "<Cmd>split<CR>", { desc = "Horizontal split" } },
    ["<leader>wv"] = { "<Cmd>vsplit<CR>", { desc = "Vertical split" } },
    ["<leader>wq"] = { "<Cmd>close<CR>", { desc = "Close window" } },
    ["<leader>w="] = { "<C-w>=", { desc = "Balance windows" } },
    ["<leader>wH"] = { "<C-w>H", { desc = "Move window far left" } },
    ["<leader>wJ"] = { "<C-w>J", { desc = "Move window to bottom" } },
    ["<leader>wK"] = { "<C-w>K", { desc = "Move window to top" } },
    ["<leader>wL"] = { "<C-w>L", { desc = "Move window far right" } },

    -- resize windows
    ["<M-k>"] = { "<Cmd>resize -2<CR>", { desc = "Decrease window height" } },
    ["<M-j>"] = { "<Cmd>resize +2<CR>", { desc = "Increase window height" } },
    ["<M-l>"] = { "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" } },
    ["<M-h>"] = { "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" } },

    -- buffers navigation
    ["<leader>bp"] = { "<Cmd>bprev<CR>", { desc = "Previous buffer" } },
    ["<leader>bn"] = { "<Cmd>bnext<CR>", { desc = "Next buffer" } },
    ["<leader>bd"] = { "<Cmd>bdelete<CR>", { desc = "Delete buffer" } },

    -- tabs navigation
    ["<leader>tt"] = { "<Cmd>tabnew<CR>", { desc = "New tab" } },
    ["<leader>tp"] = { "<Cmd>tabprev<CR>", { desc = "Previous tab" } },
    ["<leader>tn"] = { "<Cmd>tabnext<CR>", { desc = "Next tab" } },

    -- nvim tree

    -- telescope
    ["<leader>ff"] = { "<Cmd>Telescope find_files<CR>", { desc = "Find files" } },
    ["<leader>fg"] = { "<Cmd>Telescope live_grep<CR>", { desc = "Live grep" } },
    ["<leader>fb"] = { "<Cmd>Telescope buffers<CR>", { desc = "Find buffers" } },
    ["<leader>fh"] = { "<Cmd>Telescope help_tags<CR>", { desc = "Find help tags" } },

    -- toggleterm
    ["<C-\\>"] = { "<Cmd>ToggleTerm<CR>", { desc = "terminal: Toggle" } },
  },
  i = {
    ["<C-\\>"] = { "<Esc><Cmd>ToggleTerm<CR>", { desc = "terminal: Toggle" } },
  },
  v = {
    ["j"] = { "gj", { desc = "Move down by display line" } },
    ["k"] = { "gk", { desc = "Move up by display line" } },
  },

  t = {
    ["<Esc><Esc>"] = { "<C-\\><C-n>", { desc = "Exit terminal mode" } },
    ["<C-\\>"] = { "<Cmd>ToggleTerm<CR>", { desc = "terminal: Toggle" } },
  },
}
