--[[
- ref
    - Configuring Adapters: https://codecompanion.olimorris.dev/configuration/adapters
    - eiji.page NeovimのAIプラグインcodecompanion.nvimの使い方: https://eiji.page/blog/neovim-codecompanion-intro/
    - https://codecompanion.olimorris.dev/configuration/adapters-http
    - https://codecompanion.olimorris.dev/configuration/adapters-acp#setup-gemini-cli
--]]

-- ToDo: switch of adapters
local my_adapter = { name = 'gemini', model = 'gemini-2.5-flash' }
require('codecompanion').setup({
  adapters = {
    http = {
      gemini = function()
        return require('codecompanion.adapters').extend('gemini', {
          env = { api_key = vim.env.GEMINI_API_KEY },
        })
      end,
      azure_openai = function()
        return require('codecompanion.adapters').extend('azure_openai', {
          env = {
            api_key = vim.env.AZURE_OPENAI_API_KEY,
            endpoint = vim.env.AZURE_OPENAI_END_POINT,
          },
        })
      end,
    },
    acp = {
      gemini_cli = function()
        return require('codecompanion.adapters').extend('gemini_cli', {
          defaults = {
            auth_method = 'gemini-api-key', -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
          },
          env = { GEMINI_API_KEY = vim.env.GEMINI_API_KEY },
        })
      end,
    },
  },

  opts = {
    language = 'Japanese',
    opts = {
      log_level = 'DEBUG',
    },
  },
  interactions = {
    chat = {
      adapter = my_adapter,
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
      adapter = my_adapter,
    },
    agent = {
      adapter = my_adapter,
    },
  },
})

-- Toggle chat
vim.api.nvim_create_user_command('Cct', function()
  vim.cmd(':CodeCompanionChat Toggle')
end, { nargs = 0 })

-- expand 'CodeCompanion'  by ':cc<space>'
vim.cmd([[cab cc CodeCompanion]])

--[[
- ref
     -https://gist.github.com/itsfrank/942780f88472a14c9cbb3169012a3328
--]]

local Path = require('plenary.path')
local data_path = vim.fn.stdpath('data')
local save_folder = Path:new(data_path, 'cc_saves')
if not save_folder:exists() then
  save_folder:mkdir({ parents = true })
end

-- save current chat, `Ccs foo bar baz` will save as 'foo-bar-baz.md'
-- file is saved to ~/.local/share/nvim/cc_saves/
vim.api.nvim_create_user_command('Ccs', function(opts)
  local codecompanion = require('codecompanion')
  local success, chat = pcall(function()
    return codecompanion.buf_get_chat(0)
  end)
  if not success or chat == nil then
    vim.notify('CodeCompanionSave should only be called from CodeCompanion chat buffers', vim.log.levels.ERROR)
    return
  end
  if #opts.fargs == 0 then
    vim.notify('CodeCompanionSave requires at least 1 arg to make a file name', vim.log.levels.ERROR)
  end
  local save_name = table.concat(opts.fargs, '-') .. '.md'
  local save_path = Path:new(save_folder, save_name)
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  save_path:write(table.concat(lines, '\n'), 'w')
end, { nargs = '*' })

-- set ~/.local/share/nvim/cc_saves/ as cc_save
local CC_SAVES = vim.env.HOME .. '/.local/share/nvim/cc_saves'
vim.env.cc_s = CC_SAVES

-- load saved chat
vim.api.nvim_create_user_command('Ccl', function(opts)
  require('fzf-lua').files({ cwd = CC_SAVES })
end, { nargs = 0 })
