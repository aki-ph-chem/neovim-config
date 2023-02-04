# About this repository

neovim での設定ファイルとその備忘録を書いておく。

neovimの設定はvimscriptとLuaの両方で書くことが可能であるが、私はLuaで設定ファイルを書く。

[Luaのメモ](https://github.com/aki-ph-chem/Learn-Lua)

# プラグインマネージャ 

プラグインマネージャとしては
[packer.nvim](https://github.com/wbthomason/packer.nvim)を使う


私の環境はArch Linuxであるので、AURからnvim-packer-gitとしてインストールする

## nvim

neovimの設定ファイルが置かれている。


~/.configにシンボリックリンクを貼ってある

- init.lua
	- neovimの設定ファイル

- lua/plugins.lua
	- pluginマネージャの設定ファイル

- plugins/packer_compiled.lua
    - Packerによってコンパイルされた中間コード 

## now(2023 01.26)

- LSPの導入がうまくいかない.....

- LSP関連のプラグイン
    - [mason.nvim](https://github.com/williamboman/mason.nvim]) 
    - [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) 
    - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

masonでとりあえずpythonのlspを入れてみたが得になにかが変わった感じではないのだが?

## now(2023 02.4)

とりあえず、現在は以下のような感じ。気が向いたらファイルの分割化をするかも。

- LSP、コード補完の設定までok
    - 以下のようにinit.luaに追加したらLSPが動いた    

```Lua
-- mason: LSPマネージャー
require("mason").setup()
require("mason-lspconfig").setup()
```
- コード補完
    - [nvim-cmp](https://github.com/hrsh7th/nvim-cmp),[cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp),[vim-vsnip](https://github.com/hrsh7th/vim-vsnip)を使っている  
   - 設定: nvim-cmpのGitHubにあった設定を利用。   

- 言語ごとのLSPの導入
    - Masonを用いて欲しいサーバーをインストールした後で以下のように設定をinit.luaに書き込む(以下ではPython,C++,Rust,Lua)

```Lua
-- python
require("lspconfig").pyright.setup {}
-- cpp
require("lspconfig").clangd.setup {}
-- Rust
require("lspconfig").rust_analyzer.setup {}
-- Lua
require("lspconfig").sumneko_lua.setup {}
```
