-- ----------------------------------------------------
-- file:     $HOME/dotfiles/config/awesome/themes/miro/theme.lua
-- author    jls - http://sjorssparreboom.nl
-- vim:nu:ai:si:et:ts=4:sw=4:fdm=indent:fdn=1:ft=lua:
-- ----------------------------------------------------
local awful = require("awful")

-- Set
theme = {}

theme.confdir       = awful.util.getdir("config")
theme.name          = "miro"
theme.path          = theme.confdir .. "/themes/" .. theme.name

-- Fonts
theme.font          = "Dejavu Sans Mono 10.5"
theme.iconFont      = "Ionicons 10"

-- Miro colours
theme.miro_base01   = "#696969"
theme.miro_base02   = "#121212"
theme.miro_base03   = "#E0E0E0"
theme.miro_base04   = "#CF4F88"
theme.miro_base05   = "#53A6A6"
theme.miro_base06   = "#914E89"
theme.miro_base07   = "#47959E"
theme.miro_base08   = "#7E62B3"
theme.miro_base09   = "#C0C0C0"
theme.miro_base0A   = "#212121"
theme.miro_base0B   = "#FFFFFF"

theme.fg_normal                     = theme.miro_base01
theme.fg_focus                      = theme.miro_base09
theme.bg_normal                     = theme.miro_base02
theme.bg_focus                      = theme.miro_base02
theme.border_width                  = 1
theme.border_normal                 = theme.miro_base02
theme.border_focus                  = theme.miro_base01
theme.taglist_fg_focus              = theme.miro_base0B

-- Display the taglist squares
theme.taglist_squares_sel   = theme.path .. "/icons/taglist/sel.png"
theme.taglist_squares_unsel = theme.path .. "/icons/taglist/unsel.png"

-- Variables set for theming the menu:
theme.menu_height = 15
theme.menu_width  = 100

-- You can use your own command to set your wallpaper
theme.wallpaper = theme.confdir .. "/themes/miro/wallpaper.jpg"

theme.wallpaper_cmd = { "awsetbg -t " .. theme.confdir .. "/themes/miro/wallpaper.jpg" }

theme.vol_bg            = theme.path .. "/icons/vol_bg.png"
theme.awesome_icon = theme.path .. "/icons/arch.png"

theme.ocol                          = "<span color='" .. theme.fg_normal .. "'>"
theme.ccol                          = "</span>"
theme.tasklist_sticky               = theme.ocol .. "[S]" .. theme.ccol
theme.tasklist_ontop                = theme.ocol .. "[T]" .. theme.ccol
theme.tasklist_floating             = theme.ocol .. "[F]" .. theme.ccol
theme.tasklist_maximized_horizontal = theme.ocol .. "[M] " .. theme.ccol
theme.tasklist_maximized_vertical   = ""

-- theme.tasklist_disable_icon         = true

theme.layout_txt_tile               = "[t]"
theme.layout_txt_tileleft           = "[l]"
theme.layout_txt_tilebottom         = "[b]"
theme.layout_txt_tiletop            = "[tt]"
theme.layout_txt_fairv              = "[fv]"
theme.layout_txt_fairh              = "[fh]"
theme.layout_txt_spiral             = "[s]"
theme.layout_txt_dwindle            = "[d]"
theme.layout_txt_max                = "[m]"
theme.layout_txt_fullscreen         = "[F]"
theme.layout_txt_magnifier          = "[M]"
theme.layout_txt_floating           = "[*]"

-- lain related
theme.useless_gap_width             = 10
theme.layout_txt_cascade            = "[cascade]"
theme.layout_txt_cascadetile        = "[cascadetile]"
theme.layout_txt_centerwork         = "[centerwork]"
theme.layout_txt_termfair           = "[termfair]"
theme.layout_txt_centerfair         = "[centerfair]"
theme.layout_txt_uselessfair        = "[uf]"
theme.layout_txt_uselessfairh       = "[ufh]"
theme.layout_txt_uselesspiral       = "[us]"
theme.layout_txt_uselessdwindle     = "[ud]"
theme.layout_txt_uselesstile        = "[ut]"
theme.layout_txt_uselesstileleft    = "[utl]"
theme.layout_txt_uselesstiletop     = "[utt]"
theme.layout_txt_uselesstilebottom  = "[utb]"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = elementary

return theme
