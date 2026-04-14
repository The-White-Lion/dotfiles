local icons = {
  ui = require("utils.icons").ui,
  dap = require("utils.icons").dap,
}

return {
  {
    -- TODO:  config this
    "mfussenegger/nvim-dap",
    lazy = true,
    cmd = {
      "DapSetLogLevel",
      "DapShowLog",
      "DapContinue",
      "DapToggleBreakpoint",
      "DapToggleRepl",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapTerminate",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Initialize debug hooks
      _G._debugging = false
      local function debug_init_cb()
        _G._debugging = true
        dapui.open({ reset = true })
      end
      local function debug_terminate_cb()
        if _debugging then
          _G._debugging = false
        end
      end
      local function debug_disconnect_cb()
        if _debugging then
          _G._debugging = false
          dapui.close()
        end
      end
      dap.listeners.after.event_initialized["dapui_config"] = debug_init_cb
      dap.listeners.before.event_terminated["dapui_config"] = debug_terminate_cb
      dap.listeners.before.event_exited["dapui_config"] = debug_terminate_cb
      dap.listeners.before.disconnect["dapui_config"] = debug_disconnect_cb

      -- after set colorscheme, need to override nvim-dap's default highlight groups
      vim.api.nvim_set_hl(0, "DapStopped", { fg = "#AFD700" })

      vim.fn.sign_define(
        "DapBreakpoint",
        { text = icons.dap.Breakpoint, texthl = "DapBreakpoint", linehl = "", numhl = "" }
      )
      vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = icons.dap.BreakpointCondition, texthl = "DapBreakpoint", linehl = "", numhl = "" }
      )
      vim.fn.sign_define("DapStopped", { text = icons.dap.Stopped, texthl = "DapStopped", linehl = "", numhl = "" })
      vim.fn.sign_define(
        "DapBreakpointRejected",
        { text = icons.dap.BreakpointRejected, texthl = "DapBreakpoint", linehl = "", numhl = "" }
      )
      vim.fn.sign_define("DapLogPoint", { text = icons.dap.LogPoint, texthl = "DapLogPoint", linehl = "", numhl = "" })

      require("plugins.dap.core"):register_configurations_and_adapters()
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function()
      return {
        ensure_installed = require("plugins.dap.core"):ensure_installed(),
        automatic_installation = false,
        handlers = {},
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    opts = {
      force_buffers = true,
      icons = {
        expanded = icons.ui.TriangleShortArrowDown,
        collapsed = icons.ui.TriangleShortArrowRight,
        current_frame = icons.ui.Indicator,
      },
      mappings = {
        -- Use a table to apply multiple mappings
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t",
      },
      layouts = {
        {
          elements = {
            -- Provide as ID strings or tables with "id" and "size" keys
            {
              id = "scopes",
              size = 0.3,
            },
            { id = "watches", size = 0.3 },
            { id = "stacks", size = 0.2 },
            { id = "breakpoints", size = 0.2 },
          },
          size = 0.3,
          position = "right",
        },
        {
          elements = {
            { id = "console", size = 0.55 },
            { id = "repl", size = 0.45 },
          },
          position = "bottom",
          size = 0.25,
        },
      },
      controls = {
        enabled = true,
        -- Display controls in this session
        element = "repl",
        icons = {
          pause = icons.dap.Pause,
          play = icons.dap.Play,
          step_into = icons.dap.StepInto,
          step_over = icons.dap.StepOver,
          step_out = icons.dap.StepOut,
          step_back = icons.dap.StepBack,
          run_last = icons.dap.RunLast,
          terminate = icons.dap.Terminate,
        },
      },
      floating = {
        border = "single",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      render = { indent = 1, max_value_lines = 85 },
    },
    config = function(_, opts)
      require("dapui").setup(opts)
    end,
  },
}
