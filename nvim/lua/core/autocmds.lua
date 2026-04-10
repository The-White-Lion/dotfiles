-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  desc = "Briefly highlight yanked text",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("last_loc", { clear = true }),
  desc = "Restore the cursor to the last known location in normal file buffers",
  callback = function()
    -- Skip special-purpose buffers where restoring the last file cursor location is noisy.
    if vim.bo.buftype ~= "" then
      return
    end

    local ignored_filetypes = {
      gitcommit = true,
      gitrebase = true,
      help = true,
    }

    if ignored_filetypes[vim.bo.filetype] then
      return
    end

    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)

    -- The built-in '"' mark tracks the last known cursor position for this file.
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- vim.api.nvim_create_autocmd("ColorScheme", {
--   group = vim.api.nvim_create_augroup("nvimtree_theme_sync", { clear = true }),
--   callback = function()
--     vim.api.nvim_set_hl(0, "NvimTreeNormal", { link = "Normal" })
--     vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { link = "NormalNC" })
--     vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { link = "EndOfBuffer" })
--   end,
-- })
