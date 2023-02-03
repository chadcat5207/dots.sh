local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local wibox = require("wibox")

local profile = require("ui.mainframe.modules.profile")
local sliders = require("ui.mainframe.modules.sliders")
local music = require("ui.mainframe.modules.music")
local settings = require("ui.mainframe.modules.settings")
-- not using footer at the moment
local footer = require("ui.mainframe.modules.footer")

local height = 725

awful.screen.connect_for_each_screen(function(s)
  local mainframe = wibox({
    type = "dock",
    shape = helpers.rrect(4),
    screen = s,
    width = dpi(480),
    --height = dpi(height),
    bg = beautiful.bg,
    ontop = true,
    visible = false
  })

  mainframe:setup {
    {
      profile,
      sliders,
      music,
      settings,
      --footer,
      spacing = 20,
      layout = wibox.layout.fixed.vertical,
    },
    margins = dpi(15),
    widget = wibox.container.margin,
  }

  awesome.connect_signal("toggle::dashboard", function()
    mainframe.visible = not mainframe.visible
  end)
  awesome.connect_signal("signal::toggler", function(val)
    if val then
      mainframe.height = dpi(height + 98)
      awful.placement.bottom_right(mainframe, { honor_workarea = true, margins = beautiful.useless_gap * 2 })
    else
      mainframe.height = dpi(height)
      awful.placement.bottom_right(mainframe, { honor_workarea = true, margins = beautiful.useless_gap * 2 })
    end
  end)
end)
