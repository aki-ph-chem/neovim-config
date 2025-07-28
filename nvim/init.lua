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

-- base
require('base')

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
--require('skkeleton')

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
-- codecompanions
require('codecompanion_config')
