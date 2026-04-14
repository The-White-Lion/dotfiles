return {
  n = {
    ["<F6>"] = {
      function()
        require("dap").continue()
      end,
      { desc = "debug: Run/Continue" },
    },
    ["<F7>"] = {
      function()
        require("dap").terminate()
      end,
      { desc = "debug: Stop" },
    },
    ["<F8>"] = {
      function()
        require("dap").toggle_breakpoint()
      end,
      { desc = "debug: Toggle breakpoint" },
    },
    ["<F9>"] = {
      function()
        require("dap").step_into()
      end,
      { desc = "debug: Step into" },
    },
    ["<F10>"] = {
      function()
        require("dap").step_out()
      end,
      { desc = "debug: Step out" },
    },
    ["<F11>"] = {
      function()
        require("dap").step_over()
      end,
      { desc = "debug: Step over" },
    },
    ["<leader>db"] = {
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      { desc = "debug: Set breakpoint with condition" },
    },
    ["<leader>dC"] = {
      function()
        require("dapui").close()
      end,
      { desc = "debug: close debug UI" },
    },
  },
}
