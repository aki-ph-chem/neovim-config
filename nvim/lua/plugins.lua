-- plugins for lazy.nvim

-- for LSP
local lsp_plugins = {
  'neovim/nvim-lspconfig',
  'SmiteshP/nvim-navic',
}

-- for cmp
local cmp_plugins = {
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/vim-vsnip',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-buffer',
  'f3fora/cmp-spell',
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
  {
    'FabijanZulj/blame.nvim',
    lazy = false,
    config = function()
      require('blame').setup {}
    end,
    opts = {
      blame_options = { '-w' },
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

local filer = {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
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

-- nvim-lualine
local nvim_lualine = {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}

--[[
llama:
start server in other shell:
$ ./build_cmake/bin/llama-server\
    -m models/qwen2.5-coder-3b-q8_0.gguf\
    --port 8012 -ngl 99 -fa -ub 1024 -b 1024\
    --ctx-size 0 --cache-reuse 256
--]]
local llama = {
  'ggml-org/llama.vim',
  lazy = true,
  keys = {
    '<leader>llm',
  },
}

local alpha_nvim = {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require 'alpha'.setup(require 'alpha.themes.startify'.config)
  end,
}

local ressesion = {
  'stevearc/resession.nvim',
  opts = {},
}

local hlchunk = {
  'shellRaining/hlchunk.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
}

local markdown_preview = {
  'OXY2DEV/markview.nvim',
  lazy = false,
}

local teal_lang = {
  'teal-language/vim-teal',
}

local overseer = {
  'stevearc/overseer.nvim',
  opts = {},
}

local codecompanion = {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {},
  lazy = true,
  keys = {
    '<leader>lc',
  },
}

return {
  'cohama/lexima.vim',
  'tomasiser/vim-code-dark',
  'rust-lang/rust.vim',
  'cespare/vim-toml',
  'akinsho/toggleterm.nvim',
  'sindrets/diffview.nvim',
  'vim-skk/eskk.vim',
  'neovimhaskell/haskell-vim',
  filer,
  barbar,
  lsp_plugins,
  cmp_plugins,
  git_plugins,
  fmt_plugins,
  dap,
  fzf_lua,
  nvim_lualine,
  llama,
  alpha_nvim,
  ressesion,
  hlchunk,
  markdown_preview,
  teal_lang,
  overseer,
  codecompanion,
}
