-- Ref: https://neovide.dev/configuration.html
local config_neovide = function()
  -- refresh rate
  vim.g.neovide_refresh_rate = 60

  -- background transparent
  vim.g.neovide_opacity = 0.85
  vim.g.neovide_normal_opacity = 0.85

  -- animation time for cursor position
  vim.g.neovide_position_animation_length = 0.3

  -- RGB(50%,50%,50%)
  local rgba = {
    r = math.floor(255 * 0.5),
    g = math.floor(255 * 0.5),
    b = math.floor(255 * 0.5),
  }
  local rgba_string = string.format('#%x%x%x%x', rgba.r, rgba.g, rgba.b, math.floor(255 * (vim.g.transparency or 0.5)))
  vim.g.neovide_background_color = rgba_string

  -- animation length
  vim.g.neovide_cursor_animation_length = 0.02
end

vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    if vim.g.neovide then
      config_neovide()
    end
  end,
})
