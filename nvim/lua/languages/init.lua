-- inject path to language servers --
local home_dir = vim.env.HOME
-- teal-language-server
-- installed by below
--[[
$ luarocks install --tree ./.lua_modules teal-language-server
--]]
vim.env.PATH = home_dir .. '/neovim-config/.lua_modules/bin:' .. vim.env.PATH

require('languages.latex')
require('languages.markdown')
require('languages.typst')
require('languages.lua')
require('languages.haskell')
require('languages.rust')
require('languages.cpp')
require('languages.python')
require('languages.go')
require('languages.ts')
require('languages.others')
