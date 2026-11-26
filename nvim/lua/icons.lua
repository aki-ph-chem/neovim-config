-- File icons for filetypes that nvim-web-devicons does not know about.
--
-- Lean 4's VS Code extension ships a forall (∀) file icon, so use the same
-- glyph here.  nvim-tree/barbar look icons up by filename and extension, while
-- other plugins may look them up by filetype.
local ok, devicons = pcall(require, 'nvim-web-devicons')
if not ok then
  return
end

-- `set_icon` also works after devicons has already been set up by a plugin.
devicons.set_icon({
  lean = {
    icon = '∀',
    color = '#cccccc',
    cterm_color = '252',
    name = 'Lean',
  },
})

-- Also cover plugins that look icons up by filetype.
devicons.set_icon_by_filetype({ lean = 'lean' })
