local icons = {
  ui = require("utils.icons").ui,
  diagnostics = require("utils.icons").diagnostics,
  misc = require("utils.icons").misc,
}

local formatting_group = vim.api.nvim_create_augroup("NullLsFormatting", {})

return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      { "mason-org/mason.nvim" },
      { "mason-org/mason-lspconfig.nvim" },
      { "folke/neoconf.nvim" },
      { "folke/snacks.nvim" },
      { "Jint-lzxy/lsp_signature.nvim" },
    },
    opts = {
      diagnostics = {
        underline = true,
        virtual_text = {
          spacing = 4,
          prefix = icons.diagnostics.Prefix,
          source = "if_many",
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
      -- TODO: need to config codelens
      codelens = { enabled = true },
      folds = { enabled = true },
    },
    config = function(_, opts)
      local snacks = require("snacks")

      -- inlay hints
      if opts.inlay_hints.enabled then
        snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
          if
            vim.api.nvim_buf_is_valid(buffer)
            and vim.bo[buffer].buftype == ""
            and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
          then
            vim.defer_fn(function()
              if vim.api.nvim_buf_is_valid(buffer) then
                vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
                vim.cmd("redraw")
              end
            end, 100)
          end
        end)
      end

      -- folds
      if opts.folds.enabled then
        snacks.util.lsp.on({ method = "textDocument/foldingRange" }, function()
          vim.api.nvim_set_option_value("foldexpr", "v:lua.vim.lsp.foldexpr()", { scope = "local" })
        end)
      end

      -- code lens
      if opts.codelens.enabled then
        snacks.util.lsp.on({ method = "textDocument/codeLens" }, function(buffer)
          vim.lsp.codelens.enable(true, {
            bufnr = buffer,
          })
        end)
      end

      -- diagnostic config
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      -- lsp setup
      local lsp_configs = require("plugins.lsp.lsp_config")
      for lsp_server, lsp_config in pairs(lsp_configs) do
        -- use blink.cmp capabilities to make lsp better
        lsp_config["capabilities"] = require("blink.cmp").get_lsp_capabilities()
        vim.lsp.config(lsp_server, lsp_config)
        vim.lsp.enable(lsp_server)
      end
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
    -- TODO:config
    "nvimdev/lspsaga.nvim",
    lazy = true,
    event = "LspAttach",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = true,
    event = "VeryLazy",
    main = "null-ls",
    opts = {
      -- debug = true,
      on_attach = function(_, bufnr)
        vim.api.nvim_clear_autocmds({ group = formatting_group, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = formatting_group,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              bufnr = bufnr,
              async = false,
              filter = function(format_client)
                return format_client.name == "null-ls"
              end,
            })
          end,
        })
      end,
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    lazy = true,
    event = "LspAttach",
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    opts = {
      ensure_installed = vim.tbl_keys(require("plugins.lsp.null_ls_config")),
      automatic_installation = false,
      automatic_setup = true,
      handlers = {},
    },
  },
  -- {
  --   "Jint-lzxy/lsp_signature.nvim",
  --   lazy = true,
  --   event = "LspAttach",
  --   opts = {
  --     bind = true,
  --     floating_window = true,
  --     floating_window_above_cur_line = true,
  --     hi_parameter = "Search",
  --     hint_enable = true,
  --     transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  --     wrap = true,
  --     handler_opts = { border = "rounded" }, -- double, rounded, single, shadow, none, or a table of borders
  --   },
  -- }
}
