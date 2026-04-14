local ui = require("utils.icons").ui

return {
  -- TODO: only show in buftype == ""
  { "Bekaboo/dropbar.nvim", opts = {} },
  {
    {
      "akinsho/toggleterm.nvim",
      lazy = true,
      cmd = {
        "ToggleTerm",
        "ToggleTermSetName",
        "ToggleTermToggleAll",
        "ToggleTermSendVisualLines",
        "ToggleTermSendCurrentLine",
        "ToggleTermSendVisualSelection",
      },
      opts = {
        shade_terminals = false,
      },
    },
  },
  {
    "folke/trouble.nvim",
    init = function()
      local function apply_trouble_highlights()
        vim.api.nvim_set_hl(0, "TroubleNormal", { link = "Normal" })
        vim.api.nvim_set_hl(0, "TroubleNormalNC", { link = "NormalNC" })
      end

      apply_trouble_highlights()

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("trouble_highlights", { clear = true }),
        callback = apply_trouble_highlights,
        desc = "Keep Trouble window background aligned with regular splits",
      })
    end,
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "mikavilpas/yazi.nvim",
    version = "*", -- use the latest stable version
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      highlight_hovered_buffers_in_same_directory = false,
    },
    keys = {
      {
        "<leader>ya",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>ra",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        "<leader>yr",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = { "CursorHold", "CursorHoldI" },
    opts = {
      -- TODO: on_attach
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
      },
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    layz = true,
    cmd = "GrugFar",
    opts = {
      engine = "ripgrep",
      engines = {
        ripgrep = {
          path = "rg",
          showReplaceDiff = true,
          placeholders = {
            enabled = true,
          },
        },
      },
      transient = true,
      icons = { enabled = true },
      disableBufferLineNumbers = true,
    },
  },
  ---------------------------------------------------------
  --                      Telescope                      --
  ---------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    cmd = "Telescope",
    versions = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      defaults = {
        selection_caret = ui.ChevronRight .. " ",
        prompt_prefix = " " .. ui.Telescope .. " ",
        scroll_strategy = "limit",
        path_display = { "absolute" },
        color_devicons = true,
        vimgrep_arguments = {
          "rg",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        file_ignore_patterns = {
          ".git/",
          "__pycache__/",
          ".cache/",
          "build/",
          "%.class",
          "%.pdf",
          "%.mkv",
          "%.mp4",
          "%.zip",
        },
      },
    },
  },
  ---------------------------------------------------------
  --                  Markdown preview                   --
  ---------------------------------------------------------
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
      "3rd/image.nvim",
    },
    lazy = true,
    ft = { "markdown", "codecompanion" },
    opts = {},
  },
  {
    "3rd/image.nvim",
    build = false,
    lazy = true,
    opts = {
      processor = "magick_cli",
      window_overlap_clear_enabled = true,
    },
  },
}
