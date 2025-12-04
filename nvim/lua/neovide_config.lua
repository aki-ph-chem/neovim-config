-- Ref: https://neovide.dev/configuration.html
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
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
    local rgba_string =
      string.format('#%x%x%x%x', rgba.r, rgba.g, rgba.b, math.floor(255 * (vim.g.transparency or 0.5)))
    vim.g.neovide_background_color = rgba_string

    -- animation length
    vim.g.neovide_cursor_animation_length = 0.02
  end,
})
