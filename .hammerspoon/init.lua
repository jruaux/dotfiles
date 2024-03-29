hs.window.animationDuration = 0

units = {
  right       = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  left        = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  up          = { x = 0.00, y = 0.00, w = 1.00, h = 0.66 },
  down        = { x = 0.00, y = 0.67, w = 1.00, h = 0.34 },
  center      = { x = 0.20, y = 0.00, w = 0.60, h = 1.00 },
  upleft      = { x = 0.00, y = 0.00, w = 0.50, h = 0.67 },
  downright   = { x = 0.50, y = 0.00, w = 0.50, h = 0.67 },
  downleft    = { x = 0.00, y = 0.67, w = 0.50, h = 0.33 },
  downleft67  = { x = 0.00, y = 0.33, w = 0.67, h = 0.67 },
  left33      = { x = 0.00, y = 0.00, w = 0.33, h = 1.00 },
  left67      = { x = 0.00, y = 0.00, w = 0.67, h = 1.00 },
  right33     = { x = 0.67, y = 0.00, w = 0.33, h = 1.00 },
  right67     = { x = 0.33, y = 0.00, w = 0.67, h = 1.00 },
  max         = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 }
}

layouts = {
  work = {
    { name = 'Reminders', app = 'Reminders.app', unit = units.upleft,     screen = 'Retina Display' },
    { name = 'Calendar',  app = 'Calendar.app',  unit = units.downleft67, screen = 'Retina Display' },
    { name = 'Mail',      app = 'Mail.app',      unit = units.max,        screen = 'Retina Display' },
    { name = 'Notes',     app = 'Notes.app',     unit = units.left,       screen = 'Retina Display' },
    { name = 'Messages',  app = 'Messages.app',  unit = units.left67,     screen = 'Retina Display' },
    { name = 'Slack',     app = 'Slack.app',     unit = units.left67,     screen = 'Retina Display' },
    { name = 'Plexamp',   app = 'Plexamp.app',   unit = units.right33,    screen = 'Retina Display' }
  }
}

-- Takes a layout definition (e.g. 'layouts.work') and iterates through
-- each application definition, laying it out as specified
function runLayout(layout)
  -- local screens = hs.screen.allScreens();
  -- for i = 1,#screens do
  --   local s = screens[i]
  --   hs.alert.show("Screen " .. s:id() .. ": " .. s:name())
  -- end
  for i = 1,#layout do
    local t = layout[i]
    local theapp = hs.application.get(t.name)
    if theapp == nil then
       theapp = hs.application.open(t.app)
    end
    local win = theapp:mainWindow()
    if win == nil then
      hs.alert.show("No window for " .. t.name)
    else
      local screen = hs.screen.find(t.screen)
      if screen == nil then
        hs.alert.show("No screen " .. t.screen .. " for " .. t.name)
      else
        win:move(t.unit, screen, true)
      end
    end
  end
end

function moveToNextScreen() 
  -- Get the focused window, its window frame dimensions, its screen frame dimensions,
  -- and the next screen's frame dimensions.
  local focusedWindow = hs.window.focusedWindow()
  local focusedScreenFrame = focusedWindow:screen():frame()
  local nextScreenFrame = focusedWindow:screen():next():frame()
  local windowFrame = focusedWindow:frame()

  -- Calculate the coordinates of the window frame in the next screen and retain aspect ratio
  windowFrame.x = ((((windowFrame.x - focusedScreenFrame.x) / focusedScreenFrame.w) * nextScreenFrame.w) + nextScreenFrame.x)
  windowFrame.y = ((((windowFrame.y - focusedScreenFrame.y) / focusedScreenFrame.h) * nextScreenFrame.h) + nextScreenFrame.y)
  windowFrame.h = ((windowFrame.h / focusedScreenFrame.h) * nextScreenFrame.h)
  windowFrame.w = ((windowFrame.w / focusedScreenFrame.w) * nextScreenFrame.w)

  -- Set the focused window's new frame dimensions
  focusedWindow:setFrame(windowFrame)
end

cmd = { 'cmd' }
mash = {'ctrl', 'alt', 'cmd' }
hs.hotkey.bind(mash, 'right', function() hs.window.focusedWindow():move(units.right, nil, true) end)
hs.hotkey.bind(mash, 'left',  function() hs.window.focusedWindow():move(units.left, nil, true) end)
hs.hotkey.bind(mash, 'up',    function() hs.window.focusedWindow():move(units.up, nil, true) end)
hs.hotkey.bind(mash, 'down',  function() hs.window.focusedWindow():move(units.down, nil, true) end)
hs.hotkey.bind(mash, '.',     function() hs.window.focusedWindow():move(units.center, nil, true) end)
hs.hotkey.bind(mash, '1',     function() hs.window.focusedWindow():move(units.leftup, nil, true) end)
hs.hotkey.bind(mash, '2',     function() hs.window.focusedWindow():move(units.rightup, nil, true) end)
hs.hotkey.bind(mash, '3',     function() hs.window.focusedWindow():move(units.leftdown, nil, true) end)
hs.hotkey.bind(mash, "4",     function() hs.window.focusedWindow():move(units.rightdown, nil, true) end)
hs.hotkey.bind(mash, 'm',     function() hs.window.focusedWindow():move(units.max, nil, true) end)
hs.hotkey.bind(mash, 'n',     moveToNextScreen)
hs.hotkey.bind(mash, '0',     function() runLayout(layouts.work) end)
hs.hotkey.bind(cmd , 'm',     function() hs.window.focusedWindow():move(units.max, nil, true) end)
