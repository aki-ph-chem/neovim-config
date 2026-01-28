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
  'rinx/cmp-skkeleton',
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
  { 'mfussenegger/nvim-dap', dependencies = {
    'jbyuki/one-small-step-for-vimkind',
  }, lazy = false },
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

local tree_sitter = {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'OXY2DEV/markview.nvim',
  },
  branch = 'master',
  lazy = false,
  build = ':TSUpdate',
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

  -- PIN version to v17.33.0(commit: e7762c68daf24c3e356401f5223eeb5217047754)
  commit = 'e7762c68daf24c3e356401f5223eeb5217047754',
  pin = true,
}

local plugins_depended_on_denops = {
  'vim-denops/denops.vim',
  'vim-skk/skkeleton',
}

local direnv = {
  'actionshrimp/direnv.nvim',
  opts = {
    -- Disabling `async` is necessary because environment initialization and subsequent events compete.
    async = false,
    type = os.getenv('BUF') and 'buffer' or 'dir',
    on_direnv_finished = function()
      print('direnv: ok!')
    end,
  },
}

local docker = {
  'crnvl96/lazydocker.nvim',
}

local rustowl = {
  'cordx56/rustowl',
  version = '*', -- Latest stable version
  lazy = false, -- This plugin is already lazy
  opts = {},
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
  'rcarriga/nvim-notify',
  'Kicamon/markdown-table-mode.nvim',
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
  tree_sitter,
  teal_lang,
  overseer,
  codecompanion,
  plugins_depended_on_denops,
  direnv,
  docker,
  rustowl,
}
