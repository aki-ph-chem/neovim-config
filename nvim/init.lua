-- install(bootstrap) lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- for plugins
require("lazy").setup("plugins")

-- basic config
local opt = vim.opt
opt.mouse = 'a' 
opt.title = true
opt.number = true
opt.clipboard = "unnamedplus" 
opt.smartindent = true
opt.shiftwidth = 4
opt.expandtab = true

-- theme
-- vim.cmd[[colorscheme desert]]
-- vim.cmd[[colorscheme default]]
vim.cmd[[colorscheme codedark]]
-- 行番号の色を設定
vim.cmd[[highlight LineNr ctermbg=NONE ctermfg=magenta guibg=NONE guifg=magenta]]

-- hightlight
vim.cmd[[highlight Normal ctermbg=none]] 
vim.cmd[[highlight NonText ctermbg=none]]   
vim.cmd[[highlight LineNr ctermbg=none]]
vim.cmd[[highlight Folded ctermbg=none]]
vim.cmd[[highlight EndOfBuffer ctermbg=none]]

-- latex syntax
vim.cmd[[let g:tex_conceal = '']]
vim.cmd[[syntax enable]]
--opt.syntax = true

--- for key map
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('i','jj','<Esc>')
--map('v','vv','<C-v>')

vim.cmd[[let $BASH_ENV = "~/.bash_aliases"]]

-- for cargo
vim.cmd[[command Car !cargo run]]
vim.cmd[[command Cab !cargo build]]
vim.cmd[[command Cat !cargo test]]

----- for `cargo run --bin ` ------ 
vim.api.nvim_create_user_command(
'Carbin',
function (opts)
    local args = opts.args
    local cmd = "cargo run --bin " .. args
    local res_of_cmd = vim.fn.system(cmd)
    print(res_of_cmd)
end,
{nargs = 1}
)

----- for `cargo build --bin` -----
vim.api.nvim_create_user_command(
'Cabbin',
function (opts)
    local args = opts.args
    local cmd = "cargo build --bin " .. args
    local res_of_cmd = vim.fn.system(cmd)
    print(res_of_cmd)
end,
{nargs = 1}
)

vim.api.nvim_create_user_command(
'Carbinl',
function (opts)
    local args = opts.args
    local cmd = "cargo run --bin " .. args
    local res_of_cmd = vim.fn.systemlist(cmd)

    -- open new window & print result
    vim.cmd("vnew")
    for index,line in ipairs(res_of_cmd) do
        vim.fn.append(index, line)
    end
    vim.cmd('setlocal readonly') 
end,
{nargs = 1}
)

--- for make -- 
vim.api.nvim_create_user_command(
'Makel',
function (opts)
    local args = opts.args
    local cmd = "make " .. args
    local res_of_cmd = vim.fn.systemlist(cmd)

    -- open new window & print result
    vim.cmd("vnew")
    for index,line in ipairs(res_of_cmd) do
        vim.fn.append(index, line)
    end
    vim.cmd('setlocal readonly') 
end,
{nargs = 1}
)

----- say hello: example ------
say_hello = function ()
    print("Hello!")
end
vim.api.nvim_command("command! Hi lua say_hello()")

-- LSP config
-- mason: LSP manager
require("mason").setup()
require("mason-lspconfig").setup()

-- LSP for each programing language
-- python
require("lspconfig").pyright.setup {}
-- cpp
require("lspconfig").clangd.setup {
    cmd = {"clangd", "--background-index", "--clang-tidy", 
    "--completion-style=detailed", "--header-insertion=iwyu", 
    "--suggest-missing-includes", "--cross-file-rename"},
    filetypes = {"c", "cpp"},
    --on_attach = require'lsp'.on_attach,
    --on_attach = require('lsp').on_attach {},
    --[[
    settings = {
        clangd = {
            extraArgs = {
                "-I/path/to/include/directory"
            }
        }
    }
    --]]
}

-- Rust
require("lspconfig").rust_analyzer.setup {}
-- go lang
require("lspconfig").gopls.setup {}
-- Lua
require("lspconfig").lua_ls.setup({
    settings = {
        Lua = {
            globals = {'vim'}
        }
    }
})
-- latex
require("lspconfig").texlab.setup {}

-- cmp config
local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
