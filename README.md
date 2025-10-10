# Neovim config 

This repository contains configuration files and for neovim.

## config

- LSP & formatter
    - uv: pyright, ruff, 
    - npm: ts-server 
    - others: Nix home-manager or  project local

- Neovim itself
    - by Nix home-manager
    - nix is in [aki-ph-chem/nix](https://github.com/aki-ph-chem/nix)

- plugin manager
    - by [lazy.nvim](https://github.com/folke/lazy.nvim)

- my cheat seat
    - by `:help mycfg`
    - write to `nvim/doc`
    - 反映: `:helptags ~/.config/nvim/doc`

- LSP関連のプラグイン
    - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

- 補完関連のプラグイン
    - [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
    - [nvim-cmp-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
    - [vim-vsnip](https://github.com/hrsh7th/vim-vsnip)

- theme
    - [vim-code-dark](https://github.com/tomasiser/vim-code-dark):Visual Studio Code風のテーマ

- buffer 
    - [barbar.nvim](https://github.com/romgrk/barbar.nvim): vs-codeのタブのようにバッファを管理できる(要 nerd-fonts)

`nerd-fonts`: by download from

- others 
    - [lexima.vim](https://github.com/cohama/lexima.vim)
    - [vimtex](https://github.com/lervag/vimtex)
    - [rust.vim](https://github.com/rust-lang/rust.vim)
    - [nerdtree](https://github.com/preservim/nerdtree)
    - [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
    - [vim-fugitive](https://github.com/tpope/vim-fugitive)
    - [vim-airline](https://github.com/vim-airline/vim-airline)

- japanese input 
    - 必要なこと:
        1. プラグインのインストール
        2. 辞書のダウンロード(sudo pacman -S skk-jisyo)
        3. 辞書のpathを登録

### 現在のディレクトリ構成

`neovim-config/nvim`に設定ファイルを置いていて、`nvim`を~/.configにシンボリックリンクを貼っている

- init.lua
	- neovimの設定ファイル
- lua/plugins.lua
	- pluginマネージャの設定ファイル

