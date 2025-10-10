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
-- toggle by <leader>vln
vim.keymap.set('n', '<leader>vln', function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })

-- config for nvim-treesitter
-- update parser: `TSUpdate`
--
-- parser for some language may need tree-sitter-cli
-- then execute beloww:
-- $ cargo install --locked tree-sitter-cli # install tree-sitter-cli
-- or
-- install tree-sitter by home-manager
local use_tree_sitter_hightlight = os.getenv('TS_OFF')
if use_tree_sitter_hightlight then
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'c',
      'cpp',
      'python',
      'lua',
      'rust',
      'bash',
      'markdown',
      'markdown_inline',
      'gitignore',
      'yaml',
      'xml',
      'latex',
      'bibtex',
      'toml',
    },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    modules = {},
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  }
end
