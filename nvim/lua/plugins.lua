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
    "TimUntersberger/neogit",
}

-- fzf
fuzzy = {
    "junegunn/fzf.vim",
}


return {
    "cohama/lexima.vim",
    "lervag/vimtex",
    'tomasiser/vim-code-dark',
    'rust-lang/rust.vim',
    'cespare/vim-toml',
    lsp_plugins,
    cmp_plugins,
    git_plugins,
    fuzzy,
    fmt_plugins,
}
