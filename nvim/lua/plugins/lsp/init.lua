local icons = {
  ui = require("utils.icons").ui,
  diagnostics = require("utils.icons").diagnostics,
  misc = require("utils.icons").misc
}

return {
  {
    "neovim/nvim-lspconfig",
    -- lazy = true,
    -- event = "VeryLazy",
    dependencies = {
      { "mason-org/mason.nvim" },
      { "mason-org/mason-lspconfig.nvim" },
      { "folke/neoconf.nvim" },
      { "folke/snacks.nvim" },
      -- {
      --   "Jint-lzxy/lsp_signature.nvim",
      --   config = require("completion.lsp-signature"),
      -- },
    },
    opts = {
      diagnostics = {
        underline = true,
        virtual_text = {
          spacing = 4,
          prefix = icons.diagnostics.Prefix,
          source = "if_many"
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.BoldHint,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
          },
        },
      },
      inlay_hints = {
        enabled = true,
        exclude = {},
      },
      -- Todo: need to config codelens
      codelens = { enabled = true },
      folds = { enabled = true },
    },
    config = function(_, opts)
      local snacks = require("snacks")

      -- inlay hints
      if opts.inlay_hints.enabled then
        snacks.util.lsp.on(
          { method = "textDocument/inlayhint" },
          function(buffer)
            if vim.api.nvim_buf_is_valid(buffer)
              and vim.bo[buffer].buftype == ""
              and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
            then
              vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
            end
          end
        )
      end

      -- folds
      if opts.folds.enabled then
        snacks.util.lsp.on(
          { method = "textDocument/foldingRange" },
          function()
            vim.api.nvim_set_option_value("foldexpr", "v:lua.vim.lsp.foldexpr()", { scope = "local" })
          end
        )
      end

      -- code lens
      if opts.codelens.enabled then
        snacks.util.lsp.on(
          { method = "textDocument/codeLens" },
          function(buffer)
            vim.lsp.codelens.enable(true, {
              bufnr = buffer
            })
          end
        )
      end

      -- lsp setup
      local lsp_configs = require("plugins.lsp.lsp_config")
      for lsp_server, lsp_config in pairs(lsp_configs) do
        vim.lsp.config(lsp_server, lsp_config)
        vim.lsp.enable(lsp_server)
      end
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
    end,
  },
  {
    "mason-org/mason.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {
      ui = {
        border = "single",
        icons = {
          package_pending = icons.ui.Modified_alt,
          package_installed = icons.ui.Check,
          package_uninstalled = icons.misc.Ghost,
        },
      },
      },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = true,
    opts = {
      ensure_installed = vim.tbl_keys(require("plugins.lsp.lsp_config")),
      automatic_enable = false,
    },
  },
  {
    "nvimdev/lspsaga.nvim",
    lazy = true,
    event = "LspAttach",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
}
