-- config eskk
vim.cmd([[let g:eskk#directory = "~/.eskk"]])
vim.cmd([[let g:eskk#dictionary = { 'path': "~/.config/eskk/my_jisyo", 'sorted': 1, 'encoding': 'utf-8',}]])
vim.cmd([[let g:eskk#large_dictionary = {'path': "/usr/share/skk/SKK-JISYO.L", 'sorted': 1, 'encoding': 'euc-jp',} ]])
vim.cmd([[let g:eskk#enable_completion = 1]])
