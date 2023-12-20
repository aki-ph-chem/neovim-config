-- plugins for lazy.nvim

-- for LSP
lsp_plugins = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
}

-- for cmp
cmp_plugins = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/vim-vsnip"
} 

-- formatter
fmt_plugins = {
    "mhartington/formatter.nvim"
}

-- for git
git_plugins = {
    "tpope/vim-fugitive"
}

-- fzf
fuzzy = {
    "junegunn/fzf.vim",
}

-- barbar.nvim
barbar = {
    "romgrk/barbar.nvim",
    dependencies = {
        'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    }
}

return {
    "cohama/lexima.vim",
    "lervag/vimtex",
    'tomasiser/vim-code-dark',
    'rust-lang/rust.vim',
    'cespare/vim-toml',
    'preservim/nerdtree',
    'akinsho/toggleterm.nvim',
    'vim-airline/vim-airline',
    barbar,
    lsp_plugins,
    cmp_plugins,
    git_plugins,
    fuzzy,
    fmt_plugins,
}
