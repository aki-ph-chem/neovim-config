local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'

local arch_logo = {
  '                  -`                  ',
  '                 .o+`                 ',
  '                `ooo/                 ',
  '               `+oooo:                ',
  '              `+oooooo:               ',
  '              -+oooooo+:              ',
  '            `/:-:++oooo+:             ',
  '           `/++++/+++++++:            ',
  '          `/++++++++++++++:           ',
  '         `/+++ooooooooooooo/`         ',
  '        ./ooosssso++osssssso+`        ',
  '       .oossssso-````/ossssss+`       ',
  '      -osssssso.      :ssssssso.      ',
  '     :osssssss/        osssso+++.     ',
  '    /ossssssss/        +ssssooo/-     ',
  '  `/ossssso+/:-        -:/+osssso+-   ',
  ' `+sso+:-`                 `.-/+oso:  ',
  '`++:.                           `-/+/ ',
  '.`                                 `  ',
}

local tody = os.date('%Y-%m-%d %H:%M')
local user_name = vim.env.USER

local cat_logo = {
  '        Hi! ' .. user_name,
  '',
  '       /\\_____/\\   ',
  '      /  o   o  \\   ',
  '     ( ==  ^  == )   ',
  '      )         (    ',
  '     (           )   ',
  '    ( (  )   (  ) )  ',
  '   (__(__)___(__)__) ',
  '',
  '',
  ' Now: ' .. tody,
}

-- header
dashboard.section.header.val = cat_logo
local day = os.date('%A')
-- menu
dashboard.section.buttons.val = {}
-- footer
dashboard.section.footer.val = { 'Have a productive day! (=^・^=)', "help by ':help mycfg'" }
-- layout
alpha.setup(dashboard.config)
