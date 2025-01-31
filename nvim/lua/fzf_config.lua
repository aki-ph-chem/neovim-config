require('fzf-lua').setup({
  winopts = {
    height = 0.85, -- window height
    width = 0.80, -- window width
    row = 0.35, -- window row position (0=top, 1=bottom)
    col = 0.50, -- window col position (0=left, 1=right)
    border = 'rounded', -- 'none', 'single', 'double', 'thicc' or 'rounded'
    fullscreen = false, -- start fullscreen?
  },
})

-- search file from cwd
vim.keymap.set('n', '<leader>f', function()
  require('fzf-lua').files()
end)

-- search file from not ignored by .gitignore
vim.keymap.set('n', '<leader>g', function()
  require('fzf-lua').git_files()
end)

vim.keymap.set('n', '<leader>o', function()
  require('fzf-lua').oldfiles()
end)

-- search file from buffers
vim.keymap.set('n', '<leader>b', function()
  require('fzf-lua').buffers()
end)
