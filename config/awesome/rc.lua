-- ----------------------------------------------------
-- file:     $HOME/dotfiles/vim/startup/settings.vim
-- author    jls - http://sjorssparreboom.nl
-- vim:nu:ai:si:et:ts=4:sw=4:fdm=indent:fdn=1:ft=lua:
-- ----------------------------------------------------

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- Lain library (extra layouts, utilities and widgets)
local lain = require("lain")

-- Scratch library
local drop = require("scratchdrop")

-- XDG library library (extra layouts, utilities and widgets)
xdg_menu = require("archmenu")

-- {{{ Used for keyring call
local function pass(path)
    file = io.popen(path)
    output = file:read('*a')
    file:close()
    return output
end
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
        title = "Oops, an error happened!",
        text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
local config = awful.util.getdir("config")

-- Themes define colours, icons, font and wallpapers.
beautiful.init(config .. "/themes/miro/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = os.getenv("TERMINAL") or "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.fair,
    awful.layout.suit.magnifier,
    awful.layout.suit.max,
    --lain.layout.termfair
    --lain.layout.centerwork
    lain.layout.uselessfair
}

-- gaps width
theme.useless_gap_width = 50
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.tiled(beautiful.wallpaper, s)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
    names = { "*", "www", "mail", "media", "chat", "8", "9", "dev" },
    layouts = { layouts[7], layouts[6], layouts[6], layouts[2], layouts[2], layouts[2], layouts[2] }
}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    -- tags[s] = awful.tag(tags.names, s, tags.layouts)
    tags[s] = awful.tag(tags.names, s, layouts[1])
end
-- }}}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Separators
spacer      = wibox.widget.textbox()
dot         = wibox.widget.textbox();

spacer:set_markup(" ")
dot:set_markup("•")

-- {{{ Wibox
markup = lain.util.markup

--[[ Mail IMAP check ]]
-- commented because it needs to be set before use
-- mailicon = wibox.widget.imagebox(beautiful.widget_mail)
-- mailicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(mail) end)))
mailwidget = lain.widgets.imap({
    timeout  = 60,
    server   = "imap.gmail.com",
    mail     = "jlssparreboom@gmail.com",
    port     = 993,
    is_plain = true,
    password = pass('python ~/scripts/keyring-gmail'),
    settings = function()
        count = ""
        if mailcount > 0 then
            count = mailcount .. ""
            mail = '<span font="' .. beautiful.iconFont .. '" color="' .. theme.miro_base09 .. '"></span> '
            widget:set_markup(mail .."<span color='" ..theme.miro_base08 .. "'>" .. count .. "</span>")
            elseif mailcount == 0 then
                mail = '<span font="' .. beautiful.iconFont .. '" color="' .. theme.miro_base09 .. '"></span> '
                widget:set_markup(mail .."<span color='" ..theme.miro_base09 .. "'>" .. mailcount .. "</span>")
            end
        end
    })

    mailwidget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. theme.miro_base09 .. '"></span> ' .. "<span color='" .. theme.miro_base09 .. "'>fetching...</span>")
    mailwidget:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(terminal .. " -e 'mutt -F ~/.config/mutt/muttrc'") end)))

    -- {{{ Main menu
    mymainmenu = awful.menu({
        items = {
            -- { "awesome", myawesomemenu, beautiful.awesome_icon },
            { "applications", xdgmenu },
            { "open terminal", terminal },
            { "suspend", 'dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.Suspend" boolean:true' },
            { "reboot", 'dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.Reboot" boolean:true' },
            { "shutdown",  'dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.PowerOff" boolean:true' }
        },
        theme = {
            height = 16, width = 130
        }
    })

    mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })

    -- {{{ MPD
    mpdicon = wibox.widget.imagebox(beautiful.widget_music)
    mpdicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn_with_shell(musicplr) end)))
    mpdwidget = lain.widgets.mpd({
        cover_size=150,
        music_dir="/home/jls/music/remote",
        default_art="/home/jls/pictures/covers/default_cover.jpg",
        settings = function()
            if mpd_now.state == "play" then
                artist = " " .. mpd_now.artist .. " - "
                title  = mpd_now.title  .. " "
                mpdicon:set_image(beautiful.widget_music_on)
                elseif mpd_now.state == "pause" then
                    artist = " mpd "
                    title  = "paused "
                else
                    artist = ""
                    title  = ""
                    mpdicon:set_image(beautiful.widget_music)
                end
                mpd_notification_preset = {
                    title   = "Now playing",
                    timeout = 10,
                    text    = string.format("%s - %s\n%s", mpd_now.artist,
                    mpd_now.album, mpd_now.title)
                }
                widget:set_markup(markup("#FFFFFF", artist) .. title)
            end
        })
        -- }}}

        -- {{{ MEM
        memicon = wibox.widget.imagebox(beautiful.widget_mem)
        memwidget = lain.widgets.mem({
            settings = function()
                widget:set_markup("MEM " .. '<span color="' .. theme.miro_base05 ..'">' .. mem_now.used .."MB</span>")
            end
        })

        -- {{{ CPU usage
        cpuwidget = lain.widgets.sysload({
            timeout = 5,
            settings = function()
                -- widget:set_markup('<span font="' .. beautiful.iconFont .. '"></span> <span>' .. load_1 .. '</span>')
                widget:set_markup('<span font="' .. beautiful.iconFont .. '">LAVG</span> <span color="' .. theme.miro_base08 .. '">' .. load_1 .. '</span>')
            end
        })

        cpuwidget:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(terminal .. " -e htop") end)))

        local cpunotification
        cpuwidget:connect_signal("mouse::enter", function()
            local cpuusage
            lain.widgets.cpu({
                settings = function()
                    cpuusage = cpu_now.usage
                end
            })

            local ramtotal
            local ramusage
            local swaptotal
            local swapusage
            lain.widgets.mem({
                settings = function()
                    ramusage = mem_now.used
                    ramtotal = mem_now.total
                    swapusage = mem_now.swapused
                    swaptotal = mem_now.swapf
                end
            })
            cpunotification = naughty.notify({
                text = "CPU: " .. cpuusage .. "%\nRAM: " .. ramusage .. "/" .. ramtotal .. " MB\nSWAP: " .. swapusage .. "/" .. swaptotal .. " MB",
                position = "top_right",
                timeout = 0
            })
        end)
        cpuwidget:connect_signal("mouse::leave", function()
            if (cpunotification ~= nil) then
                naughty.destroy(cpunotification)
                cpunotification = nil
            end
        end)
        -- }}}


        -- {{{ Battery state

        local remainingtime
        batwidget = lain.widgets.bat({
            timeout = 60,
            battery = "BAT0",
            notify = "on",
            settings = function()
                remainingtime = bat_now.time

                if bat_now.perc == "N/A" or bat_now.status == "Not present" then
                    widget:set_markup('<span font="' .. beautiful.iconFont .. '">AC</span> <span color="' .. theme.miro_base07 .. '">' .. "N/A" .. '</span>')
                    elseif bat_now.status == "Charging" or bat_now.status == "Full" then
                        widget:set_markup('<span font="' .. beautiful.iconFont .. '">AC</span> <span color="' .. theme.miro_base07 .. '">' .. bat_now.perc .. '% ' .. '</span>')
                        elseif tonumber(bat_now.perc) > 90 then
                            widget:set_markup('<span font="' .. beautiful.iconFont .. '">AC</span> <span color="' .. theme.miro_base07 .. '">' .. bat_now.perc .. '% ' .. '</span>')
                            elseif tonumber(bat_now.perc) > 70 then
                                widget:set_markup('<span font="' .. beautiful.iconFont .. '">AC</span> <span color="' .. theme.miro_base07 .. '">' .. bat_now.perc .. '% ' .. '</span>')
                                elseif tonumber(bat_now.perc) > 50 then
                                    widget:set_markup('<span font="' .. beautiful.iconFont .. '">AC</span> <span color="' .. theme.miro_base07 .. '">' .. bat_now.perc .. '% ' .. '</span>')
                                    elseif tonumber(bat_now.perc) > 20 then
                                        widget:set_markup('<span font="' .. beautiful.iconFont .. '">AC</span> <span color="' .. theme.miro_base07 .. '">' .. bat_now.perc .. '% ' .. '</span>')
                                    else
                                        widget:set_markup('<span font="' .. beautiful.iconFont .. '">AC</span> <span color="' .. theme.miro_base07 .. '">' .. bat_now.perc .. '% ' .. '</span>')
                                    end
                                end
                            })
                            local batnotification
                            batwidget:connect_signal("mouse::enter", function()
                                batnotification = naughty.notify({
                                    text = "Remaining time: " .. remainingtime,
                                    position = "top_right",
                                    timeout = 0
                                })
                            end)
                            batwidget:connect_signal("mouse::leave", function()
                                if (batnotification ~= nil) then
                                    naughty.destroy(batnotification)
                                    batnotification = nil
                                end
                            end)

                            -- {{{ ALSA volume bar
                            volume = lain.widgets.alsabar({ card = "0", ticks = true })
                            volmargin = wibox.layout.margin(volume.bar, 5, 8, 80)
                            volmargin:set_top(8)
                            volmargin:set_bottom(9)
                            volumewidget = wibox.widget.background(volmargin)
                            volumewidget:set_bgimage(beautiful.vol_bg)
                            -- }}}

                            -- {{{ Volume information
                            volwidget = lain.widgets.alsa({
                                timeout = 2,
                                channel = "Master",
                                settings = function()
                                    if volume_now.status == "off" or volume_now.level == "0" then
                                        widget:set_markup('<span font="' .. beautiful.iconFont .. '"></span> ')
                                        elseif tonumber(volume_now.level) > 80 then
                                            widget:set_markup('<span font="' .. beautiful.iconFont .. '"></span> ')
                                            elseif tonumber(volume_now.level) > 40 then
                                                widget:set_markup('<span font="' .. beautiful.iconFont .. '"></span> ')
                                            else
                                                widget:set_markup('<span font="' .. beautiful.iconFont .. '"></span> ')
                                            end
                                        end
                                    })

                                    volwidget:buttons(awful.util.table.join(
                                    awful.button({ }, 1,
                                    function() awful.util.spawn_with_shell("amixer -q set Master toggle") end),
                                    awful.button({ }, 4,
                                    function() awful.util.spawn_with_shell("amixer -q set Master 5%+ unmute") end),
                                    awful.button({ }, 5,
                                    function() awful.util.spawn_with_shell("amixer -q set Master 5%- unmute") end)
                                    ))
                                    -- }}}

                                    -- {{{ Wireless
                                    wifiwidget = lain.widgets.base({
                                        cmd = "iwgetid -r",
                                        settings = function()
                                            if output ~= nil and output ~= '' then
                                                connection = output
                                                -- widget:set_markup('<span font="' .. beautiful.iconFont .. '"></span> <span>' .. output .. '</span>')
                                                widget:set_markup('<span font="' .. beautiful.iconFont .. '">NET</span> <span color="' .. theme.miro_base07 ..'">' .. "ON" .. '</span>')
                                            else
                                                widget:set_markup('<span font="' .. beautiful.iconFont .. '">NET</span> <span color="' .. theme.miro_base07 ..'">' .. "OFF" .. '</span>')
                                                -- widget:set_markup('')
                                            end
                                        end
                                    })

                                    -- wifiwidget:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(terminal .. " -e ") end)))
                                    local wifinotification
                                    wifiwidget:connect_signal("mouse::enter", function()
                                        local f = assert(io.popen("iwgetid -ar"))
                                        local wifiaccesspoint = f:read()
                                        f:close()

                                        f = assert(io.popen("iwconfig wlp2s0 | grep 'Link Quality' | awk '{print $2}' | awk -F'=' '{print $2}'"))
                                        local wifiquality = f:read()
                                        f:close()

                                        -- Check for nil or empty values
                                        if wifiquality == nil or wifiquality == '' then
                                            wifiquality = "N/A"
                                        end

                                        if wifiaccesspoint == nil or wifiaccesspoint == '' then
                                            wifiaccesspoint = "N/A"
                                        end

                                        wifinotification = naughty.notify({
                                            text = "Access Point: " .. wifiaccesspoint .. "\nLink Quality: " .. wifiquality,
                                            position = "top_right",
                                            timeout = 0
                                        })
                                    end)
                                    wifiwidget:connect_signal("mouse::leave", function()
                                        if (wifinotification ~= nil) then
                                            naughty.destroy(wifinotification)
                                            wifinotification = nil
                                        end
                                    end)
                                    -- }}}

                                    -- {{{ Date and time
                                    dateicon = wibox.widget.textbox()
                                    -- dateicon:set_markup('<span font="' .. beautiful.iconFont .. '"></span> ')
                                    datewidget = awful.widget.textclock('<span color="' .. theme.miro_base09 .. '">'.. "%H:%M" .. '</span>')
                                    lain.widgets.calendar:attach(datewidget, { icons = '', font = beautiful.font, font_size = 10 })
                                    -- }}}

                                    -- Create a wibox for each screen and add it
                                    mywibox = {}
                                    mypromptbox = {}
                                    txtlayoutbox = {}
                                    mylayoutbox = {}
                                    mytaglist = {}
                                    mytaglist.buttons = awful.util.table.join(
                                    awful.button({ }, 1, awful.tag.viewonly),
                                    awful.button({ modkey }, 1, awful.client.movetotag),
                                    awful.button({ }, 3, awful.tag.viewtoggle),
                                    awful.button({ modkey }, 3, awful.client.toggletag),
                                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                                    )
                                    mytasklist = {}

                                    -- Writes a string representation of the current layout in a textbox widget
                                    function updatelayoutbox(layout, s)
                                        local screen = s or 1
                                        local txt_l = beautiful["layout_txt_" .. awful.layout.getname(awful.layout.get(screen))] or ""
                                        layout:set_text(txt_l)
                                    end

                                    for s = 1, screen.count() do
                                        -- Create a promptbox for each screen
                                        mypromptbox[s] = awful.widget.prompt()

                                        -- Create a textbox widget which will contains a short string representing the
                                        -- layout we're using.  We need one layoutbox per screen.
                                        txtlayoutbox[s] = wibox.widget.textbox(beautiful["layout_txt_" .. awful.layout.getname(awful.layout.get(s))])
                                        awful.tag.attached_connect_signal(s, "property::selected", function ()
                                            updatelayoutbox(txtlayoutbox[s], s)
                                        end)
                                        awful.tag.attached_connect_signal(s, "property::layout", function ()
                                            updatelayoutbox(txtlayoutbox[s], s)
                                        end)
                                        txtlayoutbox[s]:buttons(awful.util.table.join(
                                        awful.button({}, 1, function() awful.layout.inc(layouts, 1) end),
                                        awful.button({}, 3, function() awful.layout.inc(layouts, -1) end),
                                        awful.button({}, 4, function() awful.layout.inc(layouts, 1) end),
                                        awful.button({}, 5, function() awful.layout.inc(layouts, -1) end)))


                                        -- Create a taglist widget
                                        mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

                                        -- Create a tasklist widget
                                        mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.focused)
                                        theme.tasklist_disable_icon = true

                                        -- Create the wibox
                                        mywibox[s] = awful.wibox({ position = "top", height = "20", screen = s })

                                        -- Widgets that are aligned to the left
                                        local left_layout = wibox.layout.fixed.horizontal()
                                        left_layout:add(mylauncher)
                                        -- left_layout:add(mylayoutbox[s])
                                        left_layout:add(mytaglist[s])
                                        left_layout:add(spacer)
                                        left_layout:add(txtlayoutbox[s])
                                        left_layout:add(spacer)
                                        left_layout:add(mypromptbox[s])

                                        -- Widgets that are aligned to the right
                                        local right_layout = wibox.layout.fixed.horizontal()

                                        if s == 1 then
                                            right_layout:add(mpdicon, mpdwidget)
                                            right_layout:add(volwidget)
                                            right_layout:add(volumewidget)
                                            right_layout:add(spacer)
                                            right_layout:add(dot)
                                            right_layout:add(spacer)
                                            right_layout:add(batwidget)
                                            -- right_layout:add(spacer)
                                            right_layout:add(dot)
                                            right_layout:add(spacer)
                                            --        right_layout:add(chaticon)
                                            right_layout:add(cpuwidget)
                                            right_layout:add(spacer)
                                            -- right_layout:add(memicon)
                                            -- right_layout:add(memwidget)
                                            -- right_layout:add(spacer)
                                            right_layout:add(dot)
                                            right_layout:add(spacer)
                                            right_layout:add(wifiwidget)
                                            right_layout:add(spacer)
                                            right_layout:add(dot)
                                            right_layout:add(spacer)
                                            right_layout:add(mailwidget)
                                            right_layout:add(spacer)
                                            right_layout:add(dot)
                                            right_layout:add(wibox.widget.systray())
                                            right_layout:add(spacer)
                                        end
                                        right_layout:add(dateicon)
                                        right_layout:add(datewidget)
                                        right_layout:add(spacer)

                                        -- Now bring it all together (with the tasklist in the middle)
                                        local layout = wibox.layout.align.horizontal()
                                        layout:set_left(left_layout)
                                        layout:set_middle(mytasklist[s])
                                        layout:set_right(right_layout)

                                        mywibox[s]:set_widget(layout)
                                    end
                                    -- }}}

                                    -- {{{ Mouse bindings
                                    root.buttons(awful.util.table.join(
                                    awful.button({ }, 3, function () menu = awful.menu.clients({ theme = { width = 300 } }) end),
                                    awful.button({ }, 3, nil, function () menu:hide() end),
                                    awful.button({ }, 4, awful.tag.viewnext),
                                    awful.button({ }, 5, awful.tag.viewprev)
                                    ))
                                    -- }}}

                                    -- {{{ Key bindings
                                    globalkeys = awful.util.table.join(
                                    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
                                    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
                                    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

                                    awful.key({ "Mod1",           }, "Tab",
                                    function ()
                                        awful.client.focus.byidx( 1)
                                        if client.focus then client.focus:raise() end
                                    end),
                                    awful.key({ "Mod1", "Shift"   }, "Tab",
                                    function ()
                                        awful.client.focus.byidx(-1)
                                        if client.focus then client.focus:raise() end
                                    end),
                                    -- awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

                                    -- Layout manipulation
                                    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
                                    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
                                    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
                                    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
                                    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
                                    awful.key({ modkey,           }, "Tab",
                                    function ()
                                        awful.client.focus.history.previous()
                                        if client.focus then
                                            client.focus:raise()
                                        end
                                    end),

                                    -- Standard program
                                    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
                                    awful.key({ modkey, "Control" }, "r", awesome.restart),
                                    --    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

                                    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
                                    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
                                    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
                                    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
                                    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
                                    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
                                    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
                                    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

                                    awful.key({ "Control", "Mod1" }, "Escape", function () awful.util.spawn("xkill") end),

                                    awful.key({ modkey, "Control" }, "n", awful.client.restore),

                                    -- Dropdown terminal
                                    awful.key({ modkey, },  "z",       function () drop(terminal, "top", "right", 0.30, 0.10) end),

                                    awful.key({ modkey, },  "b",       function () awful.util.spawn_with_shell("`tabbed -d > /tmp/tabbed.xid`; vimb -e `cat /tmp/tabbed.xid`") end),

                                    -- Prompt
                                    awful.key({ modkey },   "r",       function () mypromptbox[mouse.screen]:run() end),

                                    -- Print screen
                                    awful.key({ modkey },   "p",       function() awful.util.spawn(terminal .. " -e 'scrot ~/pictures/screenshots/%Y-%m-%d-%T-screenshot.png'") end),

                                    -- MPD control
                                    awful.key({ Mod1, "Control" }, "Up",
                                    function ()
                                        awful.util.spawn_with_shell("mpc toggle || ncmpc toggle || pms toggle")
                                        mpdwidget.update()
                                    end),
                                    awful.key({ Mod1, "Control" }, "Down",
                                    function ()
                                        awful.util.spawn_with_shell("mpc stop || ncmpc stop || pms stop")
                                        mpdwidget.update()
                                    end),
                                    awful.key({ Mod1, "Control" }, "Left",
                                    function ()
                                        awful.util.spawn_with_shell("mpc prev || ncmpc prev || pms prev")
                                        mpdwidget.update()
                                    end),
                                    awful.key({ Mod1, "Control" }, "Right",
                                    function ()
                                        awful.util.spawn_with_shell("mpc next || ncmpc next || pms next")
                                        mpdwidget.update()
                                    end))

                                    clientkeys = awful.util.table.join(
                                    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
                                    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
                                    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
                                    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
                                    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
                                    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
                                    awful.key({ modkey,           }, "n",
                                    function (c)
                                        -- The client currently has the input focus, so it cannot be
                                        -- minimized, since minimized clients can't have the focus.
                                        c.minimized = true
                                    end),
                                    awful.key({ modkey,           }, "m",
                                    function (c)
                                        c.maximized_horizontal = not c.maximized_horizontal
                                        c.maximized_vertical   = not c.maximized_vertical
                                    end)
                                    )

                                    -- Compute the maximum number of digit we need, limited to 10
                                    --keynumber = 0
                                    --for s = 1, screen.count() do
                                    --   keynumber = math.min(10, math.max(#tags[s], keynumber));
                                    --end
                                    keynumber = {1, 2, 3, 4, 5, 8, 9, 10}

                                    -- Bind all key numbers to tags.
                                    -- Be careful: we use keycodes to make it works on any keyboard layout.
                                    -- This should map on the top row of your keyboard, usually 1 to 9.
                                    for i, k in next, keynumber do
                                        globalkeys = awful.util.table.join(globalkeys,
                                        -- View tag only.
                                        awful.key({ modkey }, "#" .. k + 9,
                                        function ()
                                            local screen = mouse.screen
                                            local tag = awful.tag.gettags(screen)[i]
                                            if tag then
                                                awful.tag.viewonly(tag)
                                            end
                                        end),
                                        -- Toggle tag.
                                        awful.key({ modkey, "Control" }, "#" .. k + 9,
                                        function ()
                                            local screen = mouse.screen
                                            local tag = awful.tag.gettags(screen)[i]
                                            if tag then
                                                awful.tag.viewtoggle(tag)
                                            end
                                        end),
                                        -- Move client to tag.
                                        awful.key({ modkey, "Shift" }, "#" .. k + 9,
                                        function ()
                                            if client.focus then
                                                local tag = awful.tag.gettags(client.focus.screen)[i]
                                                if tag then
                                                    awful.client.movetotag(tag)
                                                end
                                            end
                                        end),
                                        -- Toggle tag.
                                        awful.key({ modkey, "Control", "Shift" }, "#" .. k + 9,
                                        function ()
                                            if client.focus then
                                                local tag = awful.tag.gettags(client.focus.screen)[i]
                                                if tag then
                                                    awful.client.toggletag(tag)
                                                end
                                            end
                                        end))
                                    end

                                    clientbuttons = awful.util.table.join(
                                    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
                                    awful.button({ modkey }, 1, awful.mouse.client.move),
                                    awful.button({ modkey }, 3, awful.mouse.client.resize))

                                    -- Set keys
                                    root.keys(globalkeys)
                                    -- }}}

                                    -- {{{ Rules
                                    -- Rules to apply to new clients (through the "manage" signal).
                                    awful.rules.rules = {
                                        -- All clients will match this rule.
                                        { rule = { },
                                        properties = { border_width = beautiful.border_width,
                                        border_color = beautiful.border_normal,
                                        focus = awful.client.focus.filter,
                                        raise = true,
                                        keys = clientkeys,
                                        buttons = clientbuttons,
                                        floating = false,
                                        maximized = false } },
                                        { rule = { type = "dialog" },
                                        properties = { floating = true } },
                                        { rule_any = { instance = { "gimp" } },
                                        except = { type = "dialog" },
                                        properties = { maximized = true } },
                                        { rule_any = { class = { "chromium" } },
                                        callback = function(c) awful.client.movetotag(tags[mouse.screen][2], c) end },
                                        { rule_any = { class = { "Vimb" } },
                                        callback = function(c) awful.client.movetotag(tags[mouse.screen][2], c) end},
                                        { rule_any = { class = { "tabbed" } },
                                        callback = function(c) awful.client.movetotag(tags[mouse.screen][2], c) end},
                                        { rule_any = { instance = { "mutt" } },
                                        callback = function(c) awful.client.movetotag(tags[mouse.screen][3], c) end},
                                    }
                                    -- }}}

                                    -- {{{ Signals
                                    -- Signal function to execute when a new client appears.
                                    client.connect_signal("manage", function (c, startup)
                                        -- Enable sloppy focus
                                        c:connect_signal("mouse::enter", function(c)
                                            if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
                                                and awful.client.focus.filter(c) then
                                                client.focus = c
                                            end
                                        end)

                                        if not startup then
                                            -- Set the windows at the slave,
                                            -- i.e. put it at the end of others instead of setting it master.
                                            -- awful.client.setslave(c)

                                            -- Put windows in a smart way, only if they does not set an initial position.
                                            if not c.size_hints.user_position and not c.size_hints.program_position then
                                                awful.placement.no_overlap(c)
                                                awful.placement.no_offscreen(c)
                                            end
                                                -- Hack fixes gaps for applications with fixed dimensions
                                                c.size_hints_honor = false
                                        end

                                        local titlebars_enabled = false
                                        if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
                                            -- buttons for the titlebar
                                            local buttons = awful.util.table.join(
                                            awful.button({ }, 1, function()
                                                client.focus = c
                                                c:raise()
                                                awful.mouse.client.move(c)
                                            end),
                                            awful.button({ }, 3, function()
                                                client.focus = c
                                                c:raise()
                                                awful.mouse.client.resize(c)
                                            end)
                                            )

                                            -- Widgets that are aligned to the left
                                            local left_layout = wibox.layout.fixed.horizontal()
                                            left_layout:add(awful.titlebar.widget.iconwidget(c))
                                            left_layout:buttons(buttons)

                                            -- Widgets that are aligned to the right
                                            local right_layout = wibox.layout.fixed.horizontal()
                                            right_layout:add(awful.titlebar.widget.floatingbutton(c))
                                            right_layout:add(awful.titlebar.widget.maximizedbutton(c))
                                            right_layout:add(awful.titlebar.widget.stickybutton(c))
                                            right_layout:add(awful.titlebar.widget.ontopbutton(c))
                                            right_layout:add(awful.titlebar.widget.closebutton(c))

                                            -- The title goes in the middle
                                            local middle_layout = wibox.layout.flex.horizontal()
                                            local title = awful.titlebar.widget.titlewidget(c)
                                            title:set_align("center")
                                            middle_layout:add(title)
                                            middle_layout:buttons(buttons)

                                            -- Now bring it all together
                                            local layout = wibox.layout.align.horizontal()
                                            layout:set_left(left_layout)
                                            layout:set_right(right_layout)
                                            layout:set_middle(middle_layout)

                                            awful.titlebar(c):set_widget(layout)
                                        end
                                    end)

                                    client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
                                    client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
                                    -- }}}
                                    -- {{{ Autostart
                                    -- Autostart apps after login
                                    awful.util.spawn_with_shell("`tabbed -d > /tmp/tabbed.xid`; vimb -e `cat /tmp/tabbed.xid`")
                                    awful.util.spawn(terminal .. " -e mutt -F ~/.config/mutt/muttrc")
                                    -- }}}
