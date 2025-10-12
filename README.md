# ⚙️ Neovim Configuration

This repository contains my personal configuration files for **Neovim**.

## 🛠️ Configuration Management

| Component                              | Method/Tool                   | Notes                                                                       |
|----------------------------------------|-------------------------------|-----------------------------------------------------------------------------|
| **Some Language server & other tools** | Managed by [Nix home-manager] | The main Nix configuration is located in the [aki-ph-chem/nix]  repository. |
| **Plugin Manager**                     | [folke/lazy.nvim]             | Modern, fast, and feature-rich plugin manager.                              |

[Nix home-manager]: https://www.google.com/search?q=https://nixos.org/manual/home-manager/index.html
[folke/lazy.nvim]: https://github.com/folke/lazy.nvim
[aki-ph-chem/nix]: https://github.com/aki-ph-chem/nix

## 🚀 Key Features

### Language Server Protocol (LSP) & Formatting

LSP and formatters are primarily managed through the configuration, supporting various languages:

  * **Python:** `uv` (for `pyright`, `ruff`)
  * **TypeScript/JavaScript:** `npm` (`ts-server`)
  * **Others:** Configuration supports Nix home-manager or project-local setups.

### Directory Structure

The configuration files are organized as follows:

  * The main configuration is located in the `neovim-config/nvim` directory.
  * A symbolic link should be created from this directory to `~/.config/nvim`.

| File/Path         | Description                                            |
|-------------------|--------------------------------------------------------|
| `init.lua`        | The primary Neovim configuration file.                 |
| `lua/plugins.lua` | Configuration file for the `lazy.nvim` plugin manager. |

### Cheatsheet

A personalized cheatsheet is available within Neovim.

  * Access via `:help mycfg`.
  * The help files are written to the `nvim/doc` directory.
  * To make changes visible, run the command: `:helptags ~/.config/nvim/doc`

## 🔌 Plugin Highlights

| Category                  | Plugin                       | Description                                      |
|---------------------------|------------------------------|--------------------------------------------------|
| **LSP & Completion**      | [neovim/nvim-lspconfig]      | Common configurations for Neovim's built-in LSP. |
|                           | [hrsh7th/nvim-cmp]           | Auto-completion plugin.                          |
|                           | [hrsh7th/cmp-nvim-lsp]       | LSP source for `nvim-cmp`.                       |
|                           | [hrsh7th/vim-vsnip]          | Snippet engine.                                  |
|                           | [hrsh7th/cmp-path]           | path source for `nvim-cmp`                       |
|                           | [hrsh7th/cmp-buffer]         | Buffer source for `nvim-cmp`                     |
|                           | [rinx/cmp-skkeleton]         | Skkeleton source for `nvim-cmp`                  |
|                           | [f3fora/cmp-spell]           | Spell check source for `nvim-cmp`                |
| **Breadcrumb navigation** | [SmiteshP/nvim-navic]        | Breadcrumb navigation                            |
| **Git**                   | [vim-fugitive]               | show code diff in right side.                    |
| **Status Line**           | [nvim-lualine/lualine.nvim]  | Lean & mean status/tabline for Neovim.           |
| **code formatter**        | [mhartington/formatter.nvim] | code formatter support                           |
| **Support for LaTex**     | [vimtex]                     | A modern LaTeX plugin.                           |


[neovim/nvim-lspconfig]: https://github.com/neovim/nvim-lspconfig
[hrsh7th/nvim-cmp]: https://github.com/hrsh7th/nvim-cmp
[hrsh7th/cmp-nvim-lsp]: https://github.com/hrsh7th/cmp-nvim-lsp
[hrsh7th/vim-vsnip]: https://github.com/hrsh7th/vim-vsnip
[hrsh7th/cmp-path]: https://github.com/hrsh7th/cmp-path
[hrsh7th/cmp-buffer]: https://github.com/hrsh7th/cmp-buffer

[rinx/cmp-skkeleton]: https://github.com/rinx/cmp-skkeleton
[SmiteshP/nvim-navic]: https://github.com/SmiteshP/nvim-navic
[f3fora/cmp-spell]: https://github.com/f3fora/cmp-spell
[nvim-lualine/lualine.nvim]: https://github.com/nvim-lualine/lualine.nvim

[vim-code-dark]: https://github.com/tomasiser/vim-code-dark
[barbar.nvim]: https://github.com/romgrk/barbar.nvim
[toggleterm.nvim]: https://github.com/akinsho/toggleterm.nvim
[nerdtree]: https://github.com/preservim/nerdtree
[vim-fugitive]: https://github.com/tpope/vim-fugitive

[vimtex]: https://github.com/lervag/vimtex
[rust.vim]: https://github.com/rust-lang/rust.vim
[lexima.vim]: https://github.com/cohama/lexima.vim
[Nerd Fonts]: https://www.nerdfonts.com/

[mhartington/formatter.nvim]: https://github.com/mhartington/formatter.nvim

## 🇯🇵 Japanese Input Setup

To enable Japanese input, the following steps are required:

1.  **Install the plugin** (via `lazy.nvim` as configured).
2.  **Download the dictionary** (e.g., using `sudo pacman -S skk-jisyo` on Arch-based systems).
3.  **Register the dictionary path** in the configuration.
