-- About Fern
-- j,k : cursor Up/Down
-- l/h: open directory/ clse directory
-- Ctrl + m: open file
-- Ctrl + h: move to parent direcotry
-- Enter or e: open file
-- E: open file by split verticaly
-- toggle Fern by :Nt
vim.api.nvim_create_user_command('Mt', function()
  vim.cmd(':Fern . -reveal=% -drawer -toggle -width=25<CR>')
end, { nargs = 0 })

-- open directory <dir> by :Ntt <dir>
vim.api.nvim_create_user_command('Mtt', function(opts)
  local dir = opts.args
  vim.cmd(':Fern ' .. dir .. ' -reveal=% -drawer -toggle -width=25<CR>')
end, { nargs = 1 })

-- Fern config
-- set font as nerdfont
-- vim.cmd[[let g:fern#renderer = 'nerdfont']]
-- show hidden file
vim.cmd([[let g:fern#default_hidden=1]])

-- nvim-tree.lua
-- toggle nvim-tree.lua by :Nt
vim.api.nvim_create_user_command('Nt', function()
  vim.cmd(':NvimTreeToggle<CR>')
end, { nargs = 0 })
