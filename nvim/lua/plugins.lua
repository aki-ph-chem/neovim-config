-- plugins for lazy.nvim

-- for LSP
local lsp_plugins = {
  'williamboman/mason.nvim',
  'neovim/nvim-lspconfig',
}

-- for cmp
local cmp_plugins = {
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/vim-vsnip',
}

-- formatter
local fmt_plugins = {
  'mhartington/formatter.nvim',
}

-- for git
local git_plugins = {
  'tpope/vim-fugitive',
}

-- fzf
local fuzzy = {
  'junegunn/fzf.vim',
}

-- barbar.nvim
local barbar = {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
}

-- filer
local filer = {
  'lambdalisue/fern.vim',
}

-- for DAP
local dap = {
  'mfussenegger/nvim-dap',
  'rcarriga/nvim-dap-ui',
}

-- otter.nvim
local oppter_nvim = {
  'jmbuhr/otter.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {},
}

return {
  'cohama/lexima.vim',
  'lervag/vimtex',
  'tomasiser/vim-code-dark',
  'rust-lang/rust.vim',
  'cespare/vim-toml',
  'akinsho/toggleterm.nvim',
  'vim-airline/vim-airline',
  'sindrets/diffview.nvim',
  'vim-skk/eskk.vim',
  filer,
  barbar,
  lsp_plugins,
  cmp_plugins,
  git_plugins,
  fuzzy,
  fmt_plugins,
  dap,
  --oppter_nvim,
}
