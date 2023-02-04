
-- require().startup()の構文はLuaのものではなくてneovimの拡張??
require("packer").startup(function(use)

    use 'cohama/lexima.vim'
    -- indentLineがインストールされているとconcealの挙動がおかしくなるから一時的に消した
    -- use 'Yggdroot/indentLine'
    use 'lervag/vimtex'

    --- for GNU GLOBAL
    use 'vim-scripts/gtags.vim'

    -- vs-code風シンタックス
    use 'tomasiser/vim-code-dark'

    -- mason.nvim: LSP関係
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }

    -- コード補完
     use {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/vim-vsnip",
     } 

end)
