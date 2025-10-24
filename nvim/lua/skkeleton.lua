--[[
- ref
    - https://github.com/vim-skk/skkeleton
    - https://zenn.dev/kuu/articles/vac2021-skkeleton
    - https://kankodori-blog.com/post/2024-06-30/
    - https://qiita.com/atakig/items/e187d067ff9e865f51f9
--]]

local skk_jisyo_l_path = os.getenv('SKK_JISYO_L_PATH') or '/usr/share/skk/SKK-JISYO.L'

-- Ctrl + j: enable skkeleton
-- Ctrl + l: disable skkeleton
vim.api.nvim_set_keymap('i', '<C-j>', '<Plug>(skkeleton-enable)', { noremap = true })
vim.api.nvim_set_keymap('c', '<C-j>', '<Plug>(skkeleton-enable)', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-l>', '<Plug>(skkeleton-disable)', { noremap = true })
vim.api.nvim_set_keymap('c', '<C-l>', '<Plug>(skkeleton-disable)', { noremap = true })

-- from: https://github.com/ymrl/SKK-JISYO.emoji-ja
local skk_emoji_jisyo_ja_path = os.getenv('SKK_JISYO_EMOJI_JA_PATH')

vim.fn['skkeleton#config']({
  globalDictionaries = {
    skk_jisyo_l_path,
    skk_emoji_jisyo_ja_path,
  },
  eggLikeNewline = true,
  keepState = true,
  showCandidatesCount = 2,
  registerConvertResult = true,
})
vim.fn['skkeleton#register_keymap']('input', '/', 'abbrev')
