# ⚙️ Neovim Configuration

This repository contains my personal configuration files for **Neovim**.

## 🛠️ Configuration Management

| Component              | Method/Tool                   | Notes                                                                       |
|------------------------|-------------------------------|-----------------------------------------------------------------------------|
| **Neovim Core Config** | Managed by [Nix home-manager] | The main Nix configuration is located in the [aki-ph-chem/nix]  repository. |
| **Plugin Manager**     | [folke/lazy.nvim]             | Modern, fast, and feature-rich plugin manager.                              |

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

| Category              | Plugin            | Description                                                                  |
|-----------------------|-------------------|------------------------------------------------------------------------------|
| **LSP & Completion**  | [nvim-lspconfig]  | Common configurations for Neovim's built-in LSP.                             |
|                       | [nvim-cmp]        | Auto-completion plugin.                                                      |
|                       | [cmp-nvim-lsp]    | LSP source for `nvim-cmp`.                                                   |
|                       | [vim-vsnip]       | Snippet engine.                                                              |
| **Theming**           | [vim-code-dark]   | A dark color scheme inspired by Visual Studio Code.                          |
| **Buffer Management** | [barbar.nvim]     | VS Code-like tab interface for buffer management. **Requires [Nerd Fonts].** |
| **Terminal**          | [toggleterm.nvim] | Simple and efficient terminal toggling.                                      |
| **File Explorer**     | [nerdtree]        | A tree-style file system explorer.                                           |
| **Version Control**   | [vim-fugitive]    | The best Git wrapper of all time.                                            |
| **Status Line**       | [vim-airline]     | Lean & mean status/tabline for Vim and Neovim.                               |
| **Language Support**  | [vimtex]          | A modern LaTeX plugin.                                                       |
| **Rust**              | [rust.vim]        | Better support for the Rust programming language.                            |
| **Input**             | [lexima.vim]      | Enhances automatic bracket/quote closing.                                    |


[nvim-lspconfig]: https://github.com/neovim/nvim-lspconfig
[nvim-cmp]: https://github.com/hrsh7th/nvim-cmp
[cmp-nvim-lsp]: https://github.com/hrsh7th/cmp-nvim-lsp
[vim-vsnip]: https://github.com/hrsh7th/vim-vsnip
[vim-code-dark]: https://github.com/tomasiser/vim-code-dark
[barbar.nvim]: https://github.com/romgrk/barbar.nvim
[toggleterm.nvim]: https://github.com/akinsho/toggleterm.nvim
[nerdtree]: https://github.com/preservim/nerdtree
[vim-fugitive]: https://github.com/tpope/vim-fugitive
[vim-airline]: https://github.com/vim-airline/vim-airline
[vimtex]: https://github.com/lervag/vimtex
[rust.vim]: https://github.com/rust-lang/rust.vim
[lexima.vim]: https://github.com/cohama/lexima.vim
[Nerd Fonts]: https://www.nerdfonts.com/

## 🇯🇵 Japanese Input Setup

To enable Japanese input, the following steps are required:

1.  **Install the plugin** (via `lazy.nvim` as configured).
2.  **Download the dictionary** (e.g., using `sudo pacman -S skk-jisyo` on Arch-based systems).
3.  **Register the dictionary path** in the configuration.
