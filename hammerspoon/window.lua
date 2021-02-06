-- full screen
hs.hotkey.bind(HYPER, 'f', function() hs.window.focusedWindow():maximize() end)

-- move between displays
hs.hotkey.bind(HYPER, 'right', function() hs.window.focusedWindow():moveOneScreenEast() end)
hs.hotkey.bind(HYPER, 'left', function() hs.window.focusedWindow():moveOneScreenWest() end)