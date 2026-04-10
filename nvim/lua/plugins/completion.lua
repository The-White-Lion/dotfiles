return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    lazy = true,
    event = "InsertEnter",
    version = "1.*",
    opts = {
      completion = { documentation = { auto_show = true } },
      keymap = { preset = "enter" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
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
}
