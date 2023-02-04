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
    - 今の所よくわからない 

## now(2023 01.26)

- LSPの導入がうまくいかない.....

- install & settings
    - mason.nvim 
    - mason-lspconfig.nvim 
    - nvim-lspconfig

masonでとりあえずpythonのlspを入れてみたが得になにかが変わった感じではないのだが?

