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

-- hlchunk
-- ??
require('hlchunk').setup({
  chunk = {
    enable = true,
    style = '#00ffff',
  },
  indent = {
    enable = true,
  },
})

-- nvim-lualine
require('lualine').setup({
  options = { theme = 'dracula' },
})

-- markview
vim.keymap.set('n', '<leader>mkd', function()
  vim.cmd('Markview toggle <CR>')
end)

-- virtual line (need Neovim latest! (>= 0.11.0) )
vim.diagnostic.config({
  virtual_lines = true,
})
