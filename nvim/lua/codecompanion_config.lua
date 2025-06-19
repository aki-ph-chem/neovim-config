require('codecompanion').setup({
  adapters = {
    gemini = function()
      return require('codecompanion.adapters').extend('gemini', {
        env = { api_key = vim.env.GEMINI_API_KEY },
      })
    end,
  },
  opts = {
    language = 'Japanese',
  },
  strategies = {
    chat = {
      adapter = 'gemini',
    },
    inline = {
      adapter = 'gemini',
    },
    agent = {
      adapter = 'gemini',
    },
  },
})

-- Toggle chat
vim.api.nvim_create_user_command('Cct', function()
  vim.cmd(':CodeCompanionChat Toggle')
end, { nargs = 0 })
