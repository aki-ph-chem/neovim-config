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

## lazy.nvimに移行する

### 作業flow

1. まずMasonで管理しているLSPを削除する
2. packer.nvimで管理しているプラグインに依存するコードをinit.luaから削除する
3. packer.nvimで管理しているプラグインを削除する
4. packer.nvimを削除する
5. lazy.nvimをインストールする
6. lazy.nvim用に`init.lua`, `lua/plugins.lua`を書き換える

### Lazyを導入する 

[公式](https://github.com/folke/lazy.nvim)のやり方に習ってインストールする。

`init.lua`に以下を書き込む

```Lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
```

プラグインは`lua/plugins.lua`に以下のように書き込む

```Lua
return {
    "<plugin_name>"
}
```

これを読み込むために`init.lua`側に

```Lua
require("lazy").setup("plugins")
```

と書き込む。
