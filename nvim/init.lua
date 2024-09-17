-- install(bootstrap) lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- stylua: ignore
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

-- basic config
local opt = vim.opt
opt.mouse = "a"
opt.title = true
opt.number = true
opt.clipboard = "unnamedplus"
opt.smartindent = true
opt.shiftwidth = 4
opt.expandtab = true
vim.g.mapleader = ","

--- for key map
-- stylua: ignore
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("i", "jj", "<Esc>")
--map('v','vv','<C-v>')

-- load lazy for plugins
require("lazy").setup("plugins")
-- my cmd for window size
require("my_cmd")

-- theme
-- vim.cmd[[colorscheme desert]]
-- vim.cmd[[colorscheme default]]
vim.cmd([[colorscheme codedark]])
vim.cmd([[set notermguicolors]])
-- 行番号の色を設定
vim.cmd([[highlight LineNr ctermbg=NONE ctermfg=magenta guibg=NONE guifg=magenta]])

-- hightlight
vim.cmd([[highlight Normal ctermbg=none]])
vim.cmd([[highlight NonText ctermbg=none]])
vim.cmd([[highlight LineNr ctermbg=none]])
vim.cmd([[highlight Folded ctermbg=none]])
vim.cmd([[highlight EndOfBuffer ctermbg=none]])

-- latex syntax
vim.cmd([[let g:tex_conceal = '']])
vim.cmd([[syntax enable]])
--opt.syntax = true

-- config of toggleterm
require("toggleterm").setup({})
-- stylua: ignore
vim.api.nvim_create_user_command("Tt", function()
    vim.cmd("ToggleTerm")
end, { nargs = 0 })

-- About Fern
-- j,k : cursor Up/Down
-- l/h: open directory/ clse directory
-- Ctrl + m: open file
-- Ctrl + h: move to parent direcotry
-- Enter or e: open file
-- E: open file by split verticaly
-- toggle Fern by :Nt
-- stylua: ignore
vim.api.nvim_create_user_command("Nt", function()
    vim.cmd(":Fern . -reveal=% -drawer -toggle -width=25<CR>")
end, { nargs = 0 })

-- open directory <dir> by :Ntt <dir>
-- stylua: ignore
vim.api.nvim_create_user_command("Ntt", function(opts)
    local dir = opts.args
    vim.cmd(":Fern " .. dir .. " -reveal=% -drawer -toggle -width=25<CR>")
end, { nargs = 1 })

-- Fern config
-- set font as nerdfont
-- vim.cmd[[let g:fern#renderer = 'nerdfont']]
-- show hidden file
vim.cmd([[let g:fern#default_hidden=1]])

-- config for barbar
-- Move to previous/next
map("n", "<C-p>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<C-n>", "<Cmd>BufferNext<CR>", opts)
-- Close buffer
map("n", "<leader>e", "<Cmd>BufferClose<CR>", opts)

vim.cmd([[let $BASH_ENV = "~/.bash_aliases"]])

-- config diffview.nvim
-- require("diffview.actions").setup({})
vim.api.nvim_create_user_command("Dfo", function()
	vim.cmd(": DiffviewOpen")
end, { nargs = 0 })

vim.api.nvim_create_user_command("Dfc", function()
	vim.cmd(": DiffviewClose")
end, { nargs = 0 })

-- config eskk
vim.cmd([[let g:eskk#directory = "~/.eskk"]])
vim.cmd([[let g:eskk#dictionary = { 'path': "~/.config/eskk/my_jisyo", 'sorted': 1, 'encoding': 'utf-8',}]])
vim.cmd([[let g:eskk#large_dictionary = {'path': "/usr/share/skk/SKK-JISYO.L", 'sorted': 1, 'encoding': 'euc-jp',} ]])
vim.cmd([[let g:eskk#enable_completion = 1]])

-- LSP config
-- mason: LSP manager
require("mason").setup()

-- LSP for each programing language
-- python
-- stylua: ignore
require("lspconfig").pyright.setup {
    settings = {
        python = {
            pythonPath = "./.venv/bin/python"
        }
    }
}

-- cpp
-- stylua: ignore
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

-- CMake
require("lspconfig").cmake.setup({})
-- for rustfmt
vim.g.rustfmt_autosave = 1
-- stylua: ignore
require("lspconfig").rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
})

-- Lua
-- stylua: ignore
require("lspconfig").lua_ls.setup({
    settings = {
        Lua = {
            globals = {'vim'}
        }
    }
})

-- go lang
-- stylua: ignore
require("lspconfig").gopls.setup {
 settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}
-- JavaScript
require("lspconfig").ts_ls.setup({})
--  HTML
--require('html').html.setup {}
-- latex
require("lspconfig").texlab.setup({})

-- cmp config
local cmp = require("cmp")
-- stylua: ignore
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
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        -- move to next candicate by Ctrl + n
        ["<C-n>"] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    vim.api.nvim_feedkeys(t("<Down>"), "n", true)
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end,
        }),
        -- move to previous candicate by Ctrl + p
        ["<C-p>"] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else
                    vim.api.nvim_feedkeys(t("<Up>"), "n", true)
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end,
        }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "vsnip" }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = "buffer" },
    }),
})

  -- Set configuration for specific filetype.
  -- stylua: ignore
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  -- stylua: ignore
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  -- stylua: ignore
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
  -- stylua: ignore
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
  -- stylua: ignore
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  -- stylua: ignore
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  -- stylua: ignore
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

-- Utilities for creating configurations
local util = require("formatter.util")
-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
-- stylua: ignore
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    lua = {
      -- "formatter.filetypes.lua" defines default configurations for the
      -- "lua" filetype
      require("formatter.filetypes.lua").stylua,

      -- You can also define your own configuration
      function()
        -- Supports conditional formatting
        if util.get_current_buffer_file_name() == "special.lua" then
          return nil
        end

        -- Full specification of configurations is down below and in Vim help
        -- files
        return {
          exe = "stylua",
          args = {
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
          },
          stdin = true,
        }
      end
    },

    go = {
      -- Go filetype
      require("formatter.filetypes.go").goimports,

      function()
        -- Supports conditional formatting
        if util.get_current_buffer_file_name() == "special.lua" then
          return nil
        end

        -- Full specification of configurations is down below and in Vim help
        -- files
        return {
          exe = "goimports",
          args = {
            "-w",
            util.escape_path(util.get_current_buffer_file_path()),
          },
          stdin = true,
        }
      end
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}

-- format by save file
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- format by save *.go file
-- stylua: ignore
autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})

-- format by save other file
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})
