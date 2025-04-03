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

-- delete all buffers when buffer name match regex pattern
vim.api.nvim_create_user_command('Bx', function(opts)
  local pattern = vim.regex(opts.args)
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local buffer_name = vim.api.nvim_buf_get_name(bufnr)
    if
      vim.api.nvim_buf_is_loaded(bufnr)
      and not vim.api.nvim_buf_get_option(bufnr, 'modified')
      and pattern:match_str(buffer_name)
    then
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
  end
end, { nargs = 1 })

vim.cmd([[let $BASH_ENV = "~/.bash_aliases"]])
