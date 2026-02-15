-- base
require('base')

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

-- skkeleton & eskk
local skkeleton_off = os.getenv('SKL_OFF')
if not skkeleton_off then
  require('skkeleton')
else
  require('skk')
end

-- setting of lsp
require('lsp')
-- setting of formatter
require('formatter_config')
require('languages')

-- config of DAP
require('dap_config')
require('dap_ui_config')
-- config of fzf-lua
require('fzf_config')
require('dashboard')
require('session')
require('neovide_config')
-- docker
require('docker')
-- codeCompanion.nvim
vim.keymap.set('n', '<leader>cc', function()
  require('codecompanion_config')
end, { desc = 'load codecompanion config' })
-- org-mode
require('org_mode')
