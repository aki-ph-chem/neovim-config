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

--- for key map
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('i', 'jj', '<Esc>')
--map('v','vv','<C-v>')

-- load lazy for plugins
require('lazy').setup('plugins')
-- my cmd for window size
require('my_cmd')

-- theme
-- vim.cmd[[colorscheme desert]]
-- vim.cmd[[colorscheme default]]
vim.cmd([[colorscheme codedark]])
vim.cmd([[set notermguicolors]])
-- 行番号の色を設定
vim.cmd([[highlight LineNr ctermbg=NONE ctermfg=magenta guibg=NONE guifg=magenta]])

-- hightlight
vim.cmd([[highlight Normal ctermbg=none]])
vim.cmd([[highlight NonText ctermbg=none]])
vim.cmd([[highlight LineNr ctermbg=none]])
vim.cmd([[highlight Folded ctermbg=none]])
vim.cmd([[highlight EndOfBuffer ctermbg=none]])

-- latex syntax
vim.cmd([[let g:tex_conceal = '']])
vim.cmd([[syntax enable]])
--opt.syntax = true

-- About Fern
-- j,k : cursor Up/Down
-- l/h: open directory/ clse directory
-- Ctrl + m: open file
-- Ctrl + h: move to parent direcotry
-- Enter or e: open file
-- E: open file by split verticaly
-- toggle Fern by :Nt
vim.api.nvim_create_user_command('Nt', function()
  vim.cmd(':Fern . -reveal=% -drawer -toggle -width=25<CR>')
end, { nargs = 0 })

-- open directory <dir> by :Ntt <dir>
vim.api.nvim_create_user_command('Ntt', function(opts)
  local dir = opts.args
  vim.cmd(':Fern ' .. dir .. ' -reveal=% -drawer -toggle -width=25<CR>')
end, { nargs = 1 })

-- Fern config
-- set font as nerdfont
-- vim.cmd[[let g:fern#renderer = 'nerdfont']]
-- show hidden file
vim.cmd([[let g:fern#default_hidden=1]])

-- config for barbar
-- Move to previous/next
map('n', '<C-p>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<C-n>', '<Cmd>BufferNext<CR>', opts)
-- Close buffer
map('n', '<leader>e', '<Cmd>BufferClose<CR>', opts)

vim.cmd([[let $BASH_ENV = "~/.bash_aliases"]])

-- config diffview.nvim
-- require("diffview.actions").setup({})
vim.api.nvim_create_user_command('Dfo', function()
  vim.cmd(': DiffviewOpen')
end, { nargs = 0 })

vim.api.nvim_create_user_command('Dfc', function()
  vim.cmd(': DiffviewClose')
end, { nargs = 0 })

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
-- nvim-lualine
require('lualine').setup({
  options = { theme = 'dracula' },
})
