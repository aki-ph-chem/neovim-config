# ⚙️ Neovim Configuration

This repository contains my personal configuration files for **Neovim**.

## 🛠️ Configuration Management

| Component                              | Method/Tool                   | Notes                                                                       |
|----------------------------------------|-------------------------------|-----------------------------------------------------------------------------|
| **Some Language server & other tools** | Managed by [Nix home-manager] | The main Nix configuration is located in the [aki-ph-chem/nix]  repository. |
| **Plugin Manager**                     | [folke/lazy.nvim]             | Modern, fast, and feature-rich plugin manager.                              |

[Nix home-manager]: https://github.com/nix-community/home-manager
[folke/lazy.nvim]: https://github.com/folke/lazy.nvim
[aki-ph-chem/nix]: https://github.com/aki-ph-chem/nix

## 🚀 Key Features

### Language Server Protocol (LSP) & Formatting

LSP and formatters are primarily managed through the configuration, supporting various languages:

  * **Python:** `uv` (for `pyright`, `ruff`)
  * **TypeScript/JavaScript:** `npm` (`ts-server`)
  * **Others:** Configuration supports Nix home-manager or project-local setups.

### 🌳 Directory Structure 🌳

The configuration files are organized as follows:

  * The main configuration is located in the `neovim-config/nvim` directory.
  * A symbolic link should be created from this directory to `~/.config/nvim`.

| File/Path                      | Description                                                                        |
|--------------------------------|------------------------------------------------------------------------------------|
| `init.lua`                     | The primary Neovim configuration file.                                             |
| `lua/plugins.lua`              | config for the [folke/lazy.nvim]  plugin manager.                                  |
| `lua/base.lua`                 | basic setup                                                                        |
| `lua/languages/*.lua`          | setup for each languages                                                           |
| `lua/codecompanion_config.lua` | config for [olimorris/codecompanion.nvim]                                          |
| `lua/dap_config.lua`           | config for [mfussenegger/nvim-dap]                                                 |
| `lua/dap_ui.lua`               | config for [rcarriga/nvim-dap-ui]                                                  |
| `lua/dashboard.lua`            | config for dashboard                                                               |
| `lua/filer.lua`                | config for [nvim-tree/nvim-tree.lua]                                               |
| `lua/formatter_config.lua`     | config for [mhartington/formatter.nvim]                                            |
| `lua/fzf_config.lua`           | config for [ibhagwan/fzf-lua]                                                      |
| `lua/git_config.lua`           | config for [tpope/vim-fugitive], [kdheepak/lazygit.nvim], [FabijanZulj/blame.nvim] |
| `lua/lsp.lua`                  | config for LSP & Completion                                                        |
| `lua/my_cmd.lua`               | Simple command I created myself                                                    |
| `lua/session.lua`              | config for [stevearc/resession.nvim]                                               |
| `lua/skkeleton.lua`            | config for [vim-skk/skkeleton]                                                     |
| `lua/appearance.lua`           | colnfig for [OXY2DEV/markview.nvim] and others related to visual                   |
| `lua/skk.lua`                  | config for `eskk`: not used now                                                    |
| `lua/neovide_config.lua`       | config for `neovide`: not used now                                                 |
| `lua/vimscript_ls.lua`         | config for Language Server for VimScript: not used now                             |


### Cheatsheet

A personalized cheatsheet is available within Neovim.

  * Access via `:help mycfg`.
  * The help files are written to the `nvim/doc` directory.
  * To make changes visible, run the command: `:helptags ~/.config/nvim/doc`

## ⭐ 🔌 Plugin Highlights ⭐

| Category                  | Plugin                         | Description                                      |
|---------------------------|--------------------------------|--------------------------------------------------|
| **LSP & Completion**      | [neovim/nvim-lspconfig]        | Common configurations for Neovim's built-in LSP. |
|                           | [hrsh7th/nvim-cmp]             | Auto-completion plugin.                          |
|                           | [hrsh7th/cmp-nvim-lsp]         | LSP source for `nvim-cmp`.                       |
|                           | [hrsh7th/vim-vsnip]            | Snippet engine.                                  |
|                           | [hrsh7th/cmp-path]             | path source for `nvim-cmp`                       |
|                           | [hrsh7th/cmp-buffer]           | Buffer source for `nvim-cmp`                     |
| **SKK**                   | [vim-skk/skkeleton]            | SKK implmented by `denops.vim`                   |
|                           | [rinx/cmp-skkeleton]           | Skkeleton source for `nvim-cmp`                  |
| **Spell check**           | [f3fora/cmp-spell]             | Spell check source for `nvim-cmp`                |
| **Breadcrumb navigation** | [SmiteshP/nvim-navic]          | Breadcrumb navigation                            |
| **Git**                   | [tpope/vim-fugitive]           | show code diff in right side.                    |
|                           | [kdheepak/lazygit.nvim]        | integration with LazyGit                         |
|                           | [FabijanZulj/blame.nvim]       | show `git blame`                                 |
| **Status Line**           | [nvim-lualine/lualine.nvim]    | Lean & mean status/tabline for Neovim.           |
| **Code Formatter**        | [mhartington/formatter.nvim]   | code formatter support                           |
| **theme**                 | [tomasiser/vim-code-dark]      | VSCode like theme                                |
| **Buffer Contorol**       | [romgrk/barbar.nvim]           | contorol buffer like tab                         |
| **Filer**                 | [nvim-tree/nvim-tree.lua]      | filer                                            |
| **Debug**                 | [mfussenegger/nvim-dap]        | DAP client                                       |
|                           | [rcarriga/nvim-dap-ui]         | UI for debugger                                  |
| **Fuzzy Finder**          | [ibhagwan/fzf-lua]             | fzf integration                                  |
| **Session Manager**       | [stevearc/resession.nvim]      | save & load neovim session                       |
| **Direnv**                | [actionshrimp/direnv.nvim]     | direnv integration                               |
| **Markdown preview**      | [OXY2DEV/markview.nvim]        | preview markview on Neovim                       |
| **LLM integuration**      | [olimorris/codecompanion.nvim] | LLM integuration on Neovim                       |


<!-- for LSP & cmp -->
[neovim/nvim-lspconfig]: https://github.com/neovim/nvim-lspconfig
[hrsh7th/nvim-cmp]: https://github.com/hrsh7th/nvim-cmp
[hrsh7th/cmp-nvim-lsp]: https://github.com/hrsh7th/cmp-nvim-lsp
[hrsh7th/vim-vsnip]: https://github.com/hrsh7th/vim-vsnip
[hrsh7th/cmp-path]: https://github.com/hrsh7th/cmp-path
[hrsh7th/cmp-buffer]: https://github.com/hrsh7th/cmp-buffer

<!-- cmp for SKK -->
[vim-skk/skkeleton]: https://github.com/vim-skk/skkeleton
[rinx/cmp-skkeleton]: https://github.com/rinx/cmp-skkeleton
<!-- spell check -->
[f3fora/cmp-spell]: https://github.com/f3fora/cmp-spell
<!-- Breadcrumb navigation -->
[SmiteshP/nvim-navic]: https://github.com/SmiteshP/nvim-navic
<!-- Git -->
[tpope/vim-fugitive]: https://github.com/tpope/vim-fugitive
[kdheepak/lazygit.nvim]: https://github.com/kdheepak/lazygit.nvim
[FabijanZulj/blame.nvim]: https://github.com/FabijanZulj/blame.nvim

<!-- status line -->
[nvim-lualine/lualine.nvim]: https://github.com/nvim-lualine/lualine.nvim
<!-- Terminal -->
[akinsho/toggleterm.nvim]: https://github.com/akinsho/toggleterm.nvim
<!-- formatter -->
[mhartington/formatter.nvim]: https://github.com/mhartington/formatter.nvim
<!-- theme -->
[tomasiser/vim-code-dark]: https://github.com/tomasiser/vim-code-dark
<!-- buffer control -->
[romgrk/barbar.nvim]: https://github.com/romgrk/barbar.nvim
<!-- filer -->
[nvim-tree/nvim-tree.lua]: https://github.com/nvim-tree/nvim-tree.lua

<!-- Debug -->
[mfussenegger/nvim-dap]: https://github.com/mfussenegger/nvim-dap
[rcarriga/nvim-dap-ui]: https://github.com/rcarriga/nvim-dap-ui
<!-- fuzzy finder -->
[ibhagwan/fzf-lua]: https://github.com/ibhagwan/fzf-lua
<!-- session manager -->
[stevearc/resession.nvim]: https://github.com/stevearc/resession.nvim
<!-- direnv -->
[actionshrimp/direnv.nvim]: https://github.com/actionshrimp/direnv.nvim
<!-- Markdown preview -->
[OXY2DEV/markview.nvim]: https://github.com/OXY2DEV/markview.nvim
<!-- codecompanion -->
[olimorris/codecompanion.nvim]: https://github.com/olimorris/codecompanion.nvim


<!-- font -->
[Nerd Fonts]: https://www.nerdfonts.com/


## 🇯🇵 Japanese Input Setup

To enable Japanese input, the following steps are required:

1.  **Install the plugin (eskk or skkeleton)** (via `lazy.nvim` as configured in `lua/plugins.lua`).
2.  **Download the dictionary** (e.g., using `sudo pacman -S skk-jisyo` on Arch-based systems).
3.  **Register the dictionary path** in the configuration.
