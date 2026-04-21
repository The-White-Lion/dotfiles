return {
  -- nvim-tree
  ["<leader>e"] = {
    mode = "n",
    rhs = function()
      require("edgy").toggle("left")
    end,
    opts = { desc = "filetree: Toggle" },
  },
  ["<leader>nf"] = { mode = "n", rhs = "<Cmd>NvimTreeFindFileToggle<CR>", opts = { desc = "filetree: Find file" } },
  ["<leader>nr"] = { mode = "n", rhs = "<Cmd>NvimTreeRefresh<CR>", opts = { desc = "filetree: Refresh" } },

  -- Dap
  ["<F6>"] = {
    mode = "n",
    rhs = function()
      require("dap").continue()
    end,
    opts = { desc = "debug: Run/Continue" },
  },
  ["<F7>"] = {
    mode = "n",
    rhs = function()
      require("dap").terminate()
    end,
    opts = { desc = "debug: Stop" },
  },
  ["<F8>"] = {
    mode = "n",
    rhs = function()
      require("dap").toggle_breakpoint()
    end,
    opts = { desc = "debug: Toggle breakpoint" },
  },
  ["<F9>"] = {
    mode = "n",
    rhs = function()
      require("dap").step_into()
    end,
    opts = { desc = "debug: Step into" },
  },
  ["<F10>"] = {
    mode = "n",
    rhs = function()
      require("dap").step_out()
    end,
    opts = { desc = "debug: Step out" },
  },
  ["<F11>"] = {
    mode = "n",
    rhs = function()
      require("dap").step_over()
    end,
    opts = { desc = "debug: Step over" },
  },
  ["<leader>db"] = {
    mode = "n",
    rhs = function()
      require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end,
    opts = { desc = "debug: Set breakpoint with condition" },
  },
  ["<leader>dC"] = {
    mode = "n",
    rhs = function()
      require("dapui").close()
    end,
    opts = { desc = "debug: close debug UI" },
  },
  -- CodeCompanion
  ["<leader>cc"] = {
    mode = "n",
    rhs = function()
      require("edgy").toggle("right")
    end,
    opts = { desc = "codecompanion: Toggle" },
  },
  ["<leader>ck"] = { mode = "n", rhs = "<Cmd>CodeCompanionActions<CR>", opts = { desc = "codecompanion: Actions" } },
  ["<leader>ca"] = {
    mode = "v",
    rhs = "<Cmd>CodeCompanionChat Add<CR><Esc>",
    opts = { desc = "codecompanion: Add selection to chat" },
  },
}
