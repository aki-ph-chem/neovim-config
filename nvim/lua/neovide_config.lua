-- Ref: https://neovide.dev/configuration.html
if vim.g.neovide then
  -- refresh rate
  vim.g.neovide_refresh_rate = 60

  -- background transparent
  vim.g.neovide_transparency = 0.85
  vim.g.neovide_normal_opacity = 0.85

  -- animation time for cursor position
  vim.g.neovide_position_animation_length = 0.3

  -- animation length
  vim.g.neovide_cursor_animation_length = 0.02
end
