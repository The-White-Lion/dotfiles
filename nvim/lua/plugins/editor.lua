local icons = {
  diagnostics = require("utils.icons").diagnostics,
  documents = require("utils.icons").documents,
  git = require("utils.icons").git,
  ui = require("utils.icons").ui,
}

return {
  {
    "nvim-mini/mini.cursorword",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = function()
      vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "FileType", "TermOpen" }, {
        group = vim.api.nvim_create_augroup("mini_cursorword_normal_buffers", { clear = true }),
        callback = function(args)
          vim.b[args.buf].minicursorword_disable = vim.bo[args.buf].buftype ~= ""
        end,
      })
      require("mini.cursorword").setup({
        delay = 100,
      })
    end,
  },
  {
    -- todo: need to config
    "smoka7/hop.nvim",
    lazy = true,
    version = "*",
    event = { "CursorHold", "CursorHoldI" },
    opts = {
      keys = 'etovxqpdygfblzhckisuran'
    }
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      renderer = {
        full_name = false,
        group_empty = true,
        add_trailing = false,
        symlink_destination = true,
        highlight_git = "all",
        root_folder_label = ":.:s?.*?..?",
        -- root_folder_label = false,
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "CMakeLists.txt" },
        indent_markers = {
          enable = true,
          inline_arrows = true,
        },
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          padding = " ",
          symlink_arrow = " 󰁔 ",
          git_placement = "after",
          glyphs = {
            default = icons.documents.Default,
            symlink = icons.documents.Symlink,
            bookmark = icons.ui.Bookmark,
            git = {
              unstaged = icons.git.Mod_alt,
              staged = icons.git.Add,
              unmerged = icons.git.Unmerged,
              renamed = icons.git.Rename,
              untracked = icons.git.Untracked,  
              deleted = icons.git.Remove,
              ignored = icons.git.Ignore,
            },
            folder = {
              arrow_open = icons.ui.ArrowOpen,
              arrow_closed = icons.ui.ArrowClosed,
              default = icons.ui.Folder,
              open = icons.ui.FolderOpen,
              empty = icons.ui.EmptyFolder,
              empty_open = icons.ui.EmptyFolderOpen,
              symlink = icons.ui.SymlinkFolder,
              symlink_open = icons.ui.FolderOpen,
            },
          },
        },
      },
      filters = {
        enable = true,
        dotfiles = false,
        no_buffer = false,
        git_clean = false,
        git_ignored = true,
        no_bookmark = false,
        custom = { ".DS_Store", ".git" },
      },
    },
  },
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    opts = {
      animate = { enabled = false },
      exit_when_last = true,
      keys = {
        ["q"] = false,
        ["Q"] = false,
        ["<C-q>"] = false,
        ["<M-j>"] = function(win)
          win:resize("height", -2)
        end,
        ["<M-k>"] = function(win)
          win:resize("height", 2)
        end,
        ["<M-h>"] = function(win)
          win:resize("width", -2)
        end,
        ["<M-l>"] = function(win)
          win:resize("width", 2)
        end,
      },
      wo = {
        winbar = false,
        winfixwidth = true,
        winfixheight = false,
        winhighlight = "Normal:Normal,NormalNC:Normal,EndOfBuffer:EndOfBuffer",
        spell = false,
        signcolumn = "no",
      },
      left = {
        {
          ft = "NvimTree",
          size = { height = 0.6, width = 0.15 },
          pinned = true,
          open = "NvimTreeOpen",
        },
        {
          ft = "trouble",
          pinned = true,
          collapsed = false,
          size = { height = 0.4, width = 0.15 },
          open = function()
            return vim.b.buftype == "" and "Trouble symbols toggle win.position=right"
          end,
          filter = function (_, win)
            local tw = vim.w[win].trouble
            return tw
              and tw.position == "right"
              and tw.type == "split"
              and tw.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        },
      },
      bottom = {
        {
          ft = "toggleterm",
          size = { height = 0.3 },
          filter = function(_, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        {
          ft = "qf",
          title = "QuickFix",
          size = { height = 0.3 },
        },
        {
          ft = "help",
          title = "Help",
          size = { height = 0.3 },
        },
      },
      right = {
        {
          ft = "codecompanion",
          pinned = true,
          collapsed = false,
          size = { width = 0.25 },
          open = "CodeCompanionChat Toggle",
        },
      },
    },
  }
}
