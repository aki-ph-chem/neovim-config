-- ref
-- https://nvim-orgmode.github.io/

local home = vim.env.HOME
require('orgmode').setup({
  org_agenda_files = string.format('%s/orgfiles/**/*', home),
  org_default_note_files = string.format('%s/orgfiles/refile.', home),
})

vim.lsp.enable('org')

require('org-bullets').setup()
