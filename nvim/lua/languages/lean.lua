-- Lean 4
-- ref: https://github.com/Julian/lean.nvim
--
-- The Lean toolchain is supplied per project by flake + direnv
-- (lean-toolchain / lakefile.toml).  Start Neovim from the project directory,
-- or use `direnv exec . nvim`, so that `lean` and `lake` are on PATH.

vim.g.lean_config = {
  -- <LocalLeader> mappings (\i, \r, \s, \x, ...).  maplocalleader is the
  -- default `\` so that the global `,` mappings are not shadowed in Lean
  -- buffers.
  mappings = true,

  infoview = {
    autoopen = true,
    width = 1 / 3,
  },

  abbreviations = {
    enable = true,
    leader = '\\',
  },

  lsp = {
    init_options = {
      editDelay = 10,
      hasWidgets = true,
    },
  },
}

-- Insert `import <module>` after the last existing import, if it is missing.
local function ensure_import(module)
  if not module or module == '' or not vim.bo.modifiable then
    return
  end

  local import_line = 'import ' .. module
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local last_import = 0

  for i, line in ipairs(lines) do
    if vim.trim(line) == import_line then
      return
    end
    if line:match('^%s*import%s') then
      last_import = i
    end
  end

  local new_lines = last_import == 0 and { import_line, '' } or { import_line }
  vim.api.nvim_buf_set_lines(0, last_import, last_import, false, new_lines)
end

local function insert_loogle_result(hit)
  if not hit then
    return
  end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { hit.name })
  vim.api.nvim_win_set_cursor(0, { row, col + #hit.name })
  ensure_import(hit.module)

  vim.notify(
    string.format('%s : %s', hit.name, (hit.type or ''):gsub('%s*\n%s*', ' ')),
    vim.log.levels.INFO,
    { title = 'Loogle' }
  )
end

-- :LeanLoogle (also <leader>L in Lean buffers)
local function loogle_search()
  local ok, loogle = pcall(require, 'lean.loogle')
  if not ok then
    vim.notify('lean.nvim is not loaded', vim.log.levels.WARN)
    return
  end

  vim.ui.input({ prompt = 'Loogle> ' }, function(query)
    if not query or query == '' then
      return
    end

    local searched, hits, err = pcall(loogle.search, query)
    if not searched then
      vim.notify('Loogle: ' .. tostring(hits), vim.log.levels.ERROR)
      return
    end
    if not hits then
      vim.notify('Loogle: ' .. tostring(err), vim.log.levels.WARN)
      return
    end
    if vim.tbl_isempty(hits) then
      vim.notify('Loogle: no result', vim.log.levels.INFO)
      return
    end

    local by_label = {}
    local labels = {}
    for _, hit in ipairs(hits) do
      local label = string.format(
        '%s : %s  [%s]',
        hit.name,
        (hit.type or ''):gsub('%s*\n%s*', ' '),
        hit.module
      )
      if not by_label[label] then
        by_label[label] = hit
        table.insert(labels, label)
      end
    end

    require('fzf-lua').fzf_exec(labels, {
      prompt = 'Loogle> ',
      actions = {
        ['default'] = function(selected)
          insert_loogle_result(selected and by_label[selected[1]])
        end,
      },
    })
  end)
end

vim.api.nvim_create_user_command('LeanLoogle', loogle_search, {
  desc = 'Search Loogle and insert the selected declaration',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lean',
  callback = function(args)
    vim.keymap.set('n', '<leader>L', loogle_search, {
      buffer = args.buf,
      desc = 'Loogle search',
    })
  end,
})
