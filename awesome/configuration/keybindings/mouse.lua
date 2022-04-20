local awful = require "awful"
local naughty = require "naughty"

local mouse_bindings = {
  awful.button({}, 1, function()
    naughty.destroy_all_notifications()
    if mymainmenu then
      mymainmenu:hide()
    end
  end),
  --awful.button({}, 2, function()
  --dashboard_toggle()
  --end),
  awful.button({}, 3, function()
    mymainmenu:toggle()
  end),
  awful.button({}, 4, awful.tag.viewprev),
  awful.button({}, 5, awful.tag.viewnext),
}

local signal_bindings = {
  awful.button({}, 1, function(c)
    c:activate { context = "mouse_click" }
  end),
  awful.button({ modkey }, 1, function(c)
    c:activate { context = "mouse_click", action = "mouse_move" }
  end),
  awful.button({ modkey }, 3, function(c)
    c:activate { context = "mouse_click", action = "mouse_resize" }
  end),
}

return {
  standard = mouse_bindings,
  signal = signal_bindings,
}