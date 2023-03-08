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


return {
    "cohama/lexima.vim",
    "lervag/vimtex",
    'tomasiser/vim-code-dark',
    lsp_plugins,
    cmp_plugins
}
