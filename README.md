# About this repository

neovim での設定ファイルとその備忘録を書いておく。

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
