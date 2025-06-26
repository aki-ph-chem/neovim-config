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
      slash_commands = {
        ['buffer'] = {
          opts = {
            provider = 'fzf_lua',
          },
        },
        ['file'] = {
          opts = {
            provider = 'fzf_lua',
          },
        },
        ['help'] = {
          opts = {
            provider = 'fzf_lua',
          },
        },
        ['symbols'] = {
          opts = {
            provider = 'fzf_lua',
          },
        },
        ['workspace'] = {
          opts = {
            provider = 'fzf_lua',
          },
        },
      },
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

-- expand 'CodeCompanion'  by ':cc<space>'
vim.cmd([[cab cc CodeCompanion]])
