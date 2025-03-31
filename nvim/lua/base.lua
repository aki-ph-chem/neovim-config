-- basic config
local opt = vim.opt
opt.mouse = 'a'
opt.title = true
opt.number = true
opt.clipboard = 'unnamedplus'
opt.smartindent = true
opt.shiftwidth = 4
opt.expandtab = true
vim.g.mapleader = ','
-- <Esc> -> 'jj'
vim.keymap.set('i', 'jj', '<Esc>')

-- config for barbar(buffer)
-- Move to previous/next
vim.keymap.set('n', '<C-p>', function()
  vim.cmd('BufferPrevious')
end)
vim.keymap.set('n', '<C-n>', function()
  vim.cmd('BufferNext')
end)
-- Close buffer
vim.keymap.set('n', '<leader>e', function()
  vim.cmd('BufferClose')
end)

-- delete all buffer
vim.keymap.set('n', '<leader>x', function()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    -- Delete only if buffer is loaded and unchanged
    if vim.api.nvim_buf_is_loaded(bufnr) and not vim.api.nvim_buf_get_option(bufnr, 'modified') then
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
  end
end)

vim.cmd([[let $BASH_ENV = "~/.bash_aliases"]])
