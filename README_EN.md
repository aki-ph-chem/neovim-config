# About this repository

This repository contains configuration files and memos for neovim.

While neovim allows configuration files to be written in both Vimscript and Lua, I prefer to write them in Lua.

[Learn Lua](https://github.com/aki-ph-chem/Learn-Lua) contains my notes on Lua.

<!-- drft -->
## In present

I migrate from packer.nvim to lazzy.nvim

- plugin manager
    - [lazy.nvim](https://github.com/folke/lazy.nvim)
- plugins for LSP
    - [mason.nvim](https://github.com/williamboman/mason.nvim]) 
    - [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) 
    - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- plugins for cmp 
    - [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
    - [nvim-cmp-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
    - [vim-vsnip](https://github.com/hrsh7th/vim-vsnip)

- theme 
    - [vim-code-dark](https://github.com/tomasiser/vim-code-dark):Visual Studio Code like theme
- others 
    - [lexima.vim](https://github.com/cohama/lexima.vim)
    - [vimtex](https://github.com/lervag/vimtex)
    - [rust.vim](https://github.com/rust-lang/rust.vim)
    - [nerdtree](https://github.com/preservim/nerdtree)
    - [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
    - [vim-fugitive](https://github.com/tpope/vim-fugitive)
    - [vim-airline](https://github.com/vim-airline/vim-airline)

### present directory structure 

I have a configuration file in `neovim-config/nvim` and a symbolic link to `nvim` in ~/.config

- init.lua
	- config file of neovim
- lua/plugins.lua
	- config file of plugin 

## configuration in previous 

As a plugin manager, I use [packer.nvim](https://github.com/wbthomason/packer.nvim) as the plugin manager.

Since I use Arch Linux, I install it as `nvim-packer-git` from AUR.

### directory structure 

This directory contains the neovim configuration files.

A symbolic link is created in `~/.config` to point to this directory.

- init.lua
  - Neovim configuration file.

- lua/plugins.lua
  - Plugin manager configuration file.

- plugins/packer_compiled.lua
  - Intermediate code compiled by Packer.

### now (2023 01.26)

- Having trouble setting up LSP...

- LSP-related plugins:
  - [mason.nvim](https://github.com/williamboman/mason.nvim)
  - [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
  - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

I tried installing the Python LSP using Mason, but I don't see any noticeable changes.

### now (2023 02.4)

For now, things are looking like this. I might consider splitting the files if I feel like it.

- LSP and code completion are set up.
  - Adding the following to `init.lua` made LSP work:

  ```Lua
  -- mason: LSP manager
  require("mason").setup()
  require("mason-lspconfig").setup()
  ```

- Code completion:
  - I'm using [nvim-cmp](https://github.com/hrsh7th/nvim-cmp), [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp), and [vim-vsnip](https://github.com/hrsh7th/vim-vsnip).
  - Configuration: I'm using the settings provided on the nvim-cmp GitHub page.

- Setting up language-specific LSP:
  - After installing the desired servers using Mason, I add the following settings to `init.lua` (Python, C++, Rust, Lua):

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

## Transition to lazy.nvim

### Workflow

1. Remove the LSP managed by Mason.
2. Remove code dependent on plugins managed by packer.nvim from `init.lua`.
3. Remove plugins managed by packer.nvim.
4. Remove packer.nvim.
5. Install lazy.nvim.
6. Modify `init.lua` and `lua/plugins.lua` for lazy.nvim.

### Installing Lazy

Follow the instructions provided in the [official repository](https://github.com/folke/lazy.nvim) to install it.

Add the following to `init.lua`:

```Lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
```

For plugins, write setting in `lua/plugins.lua` as follows 

```Lua
return {
    "<plugin_name>"
}
```

to read this configuration wirte in `init.lua` as follows

```Lua
require("lazy").setup("plugins")
```
