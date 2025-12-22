-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here


-- vim.g.lazyvim_check_order = false

vim.keymap.set('n', '<Tab>', ':tabnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', ':tabprevious<CR>', { noremap = true, silent = true })

-- Buffer history navigation
local bufhist = require("config.commands").buffer_history

vim.api.nvim_create_autocmd("BufEnter", {
  callback = bufhist.record_buffer,
})

vim.api.nvim_create_autocmd("BufDelete", {
  callback = bufhist.cleanup_closed_buffers,
})

vim.keymap.set('n', '<leader>bp', bufhist.goto_prev_buffer, { desc = "Previous buffer in history" })
vim.keymap.set('n', '<leader>bn', bufhist.goto_next_buffer, { desc = "Next buffer in history" })
vim.keymap.set('n', '<leader>bh', bufhist.show_history, { desc = "Search buffer history" })
