# About this repository

neovim での設定ファイルとその備忘録を書いておく。


Luaについては[ここ](https://github.com/aki-ph-chem/Learn-Lua)

# neovimのプラグインマネージャはどうするのか? 

packer.nvim[ここ](https://github.com/wbthomason/packer.nvim)を使う


自分はArch Linux環境なので、aurからnvim-packer-gitとしてインストールする

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

