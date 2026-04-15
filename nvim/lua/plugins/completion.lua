return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "fang2hou/blink-copilot",
    },
    lazy = true,
    event = "InsertEnter",
    version = "1.*",
    opts = {
      completion = { documentation = { auto_show = true } },
      keymap = { preset = "enter" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
      cmdline = {
        keymap = {
          preset = "cmdline",
          ["<Enter>"] = { "accept_and_enter", "fallback" },
          ["<Tab>"] = { "select_and_accept", "fallback" },
        },
        sources = function()
          local cmd_type = vim.fn.getcmdtype()
          if cmd_type == "/" then
            return { "buffer" }
          end

          if cmd_type == ":" then
            return { "cmdline" }
          end

          return {}
        end,
        completion = { menu = { auto_show = true } },
      },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        ["markdown"] = true,
        ["dap-repl"] = false,
        ["fugitive"] = false,
        ["fugitiveblame"] = false,
        ["git"] = false,
        ["gitcommit"] = false,
        ["log"] = false,
        ["toggleterm"] = false,
      },
    },
  },
}
