-- config eskk
vim.cmd([[let g:eskk#directory = "~/.eskk"]])
vim.cmd([[let g:eskk#dictionary = { 'path': "~/.config/eskk/my_jisyo", 'sorted': 1, 'encoding': 'utf-8',}]])

local skk_jisyo_l_path = os.getenv('SKK_JISYO_L_PATH') or '/usr/share/skk/SKK-JISYO.L'
local large_dictionary_table = {
  path = skk_jisyo_l_path,
  sorted = 1,
  encoding = 'euc-jp',
}
vim.api.nvim_set_var('eskk#large_dictionary', large_dictionary_table)

vim.cmd([[let g:eskk#enable_completion = 1]])
