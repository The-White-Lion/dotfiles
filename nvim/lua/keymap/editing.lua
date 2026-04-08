return {
  n = {
    ["<Space>"] = { "<nop>", { desc = "Leader placeholder" } },

    -- Files and session
    ["<leader>w"] = { "<Cmd>w<CR>", { desc = "Write file" } },
    ["<C-s>"] = { "<Cmd>w<CR>", { desc = "Write file" } },
    ["<leader>q"] = { "<Cmd>q<CR>", { desc = "Quit window" } },
    ["<leader>Q"] = { "<Cmd>qa!<CR>", { desc = "Quit all forcefully" } },

    -- Search helpers
    ["<leader>h"] = { "<Cmd>nohlsearch<CR>", { desc = "Clear search highlight" } },
    ["<leader><CR>"] = { "<Cmd>nohlsearch<CR>", { desc = "Clear search highlight" } },
  },
  i = {
    ["jk"] = { "<Esc>", { desc = "Exit insert mode" } },
  },
  c = {
    ["Wq<CR>"] = { "wq<CR>", { desc = "Fix mixed-case write quit command" } },
    ["WQ<CR>"] = { "wq<CR>", { desc = "Fix uppercase write quit command" } },
  },
}
