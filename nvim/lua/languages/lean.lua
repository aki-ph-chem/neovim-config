-- Lean 4
-- ref: https://github.com/Julian/lean.nvim
--
-- The Lean toolchain is supplied per project by flake + direnv
-- (lean-toolchain / lakefile.toml).  Start Neovim from the project directory,
-- or use `direnv exec . nvim`, so that `lean` and `lake` are on PATH.

vim.g.lean_config = {
  -- <LocalLeader> mappings (\i, \r, \s, \x, ...).  maplocalleader is the
  -- default `\` so that the global `,` mappings are not shadowed in Lean
  -- buffers.
  mappings = true,

  infoview = {
    autoopen = true,
    width = 1 / 3,
  },

  abbreviations = {
    enable = true,
    leader = '\\',
  },

  lsp = {
    init_options = {
      editDelay = 10,
      hasWidgets = true,
    },
  },
}
