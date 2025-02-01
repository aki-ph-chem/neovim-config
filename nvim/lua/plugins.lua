-- plugins for lazy.nvim

-- for LSP
local lsp_plugins = {
  'williamboman/mason.nvim',
  'neovim/nvim-lspconfig',
  'SmiteshP/nvim-navic',
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
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
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
  'nvim-neotest/nvim-nio',
}

-- for fzf-lua
local fzf_lua = {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
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
  fmt_plugins,
  dap,
  fzf_lua,
  --oppter_nvim,
}
