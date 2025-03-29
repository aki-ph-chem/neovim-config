-- install(bootstrap) lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

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

-- load lazy for plugins
require('lazy').setup('plugins')
-- my cmd for window size
require('my_cmd')
-- appearance
require('appearance')

-- filer
require('filer')

-- git
require('git_config')

-- eskk
require('skk')

-- setting of lsp
require('lsp')
require('formatter_config')

-- config of DAP
require('dap_config')
require('dap_ui_config')
-- config of fzf-lua
require('fzf_config')
require('dashboard')
require('session')
require('neovide_config')
