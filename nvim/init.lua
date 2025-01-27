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

-- config eskk
vim.cmd([[let g:eskk#directory = "~/.eskk"]])
vim.cmd([[let g:eskk#dictionary = { 'path': "~/.config/eskk/my_jisyo", 'sorted': 1, 'encoding': 'utf-8',}]])
vim.cmd([[let g:eskk#large_dictionary = {'path': "/usr/share/skk/SKK-JISYO.L", 'sorted': 1, 'encoding': 'euc-jp',} ]])
vim.cmd([[let g:eskk#enable_completion = 1]])

-- config gitsigns.nvim
require('gitsigns').setup({
  signs = {
    add = { text = '┃' },
    change = { text = '┃' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
    untracked = { text = '┆' },
  },
  signs_staged = {
    add = { text = '┃' },
    change = { text = '┃' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
    untracked = { text = '┆' },
  },
  signs_staged_enable = true,
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true,
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1,
  },
})

-- lsp for log
local use_lsp_log_debug = false
if use_lsp_log_debug then
  vim.lsp.set_log_level('debug')
end
--- jump to definition by 'gd'
vim.keymap.set('n', 'gd', '<cmd>:lua vim.lsp.buf.definition()<CR>')

-- setting of lsp
require('lsp')
require('formatter_config')

-- config of DAP
require('dap_config')
require('dap_ui_config')
