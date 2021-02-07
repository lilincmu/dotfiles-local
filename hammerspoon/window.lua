local STEP = 10

-- full screen
hs.hotkey.bind(HYPER, 'f', function()
    hs.window.focusedWindow():maximize()
end)

-- resize window
local resizes = {{
    key = "=",
    size = STEP
}, {
    key = "-",
    size = -STEP
}}

for i, resize in ipairs(resizes) do
    hs.hotkey.bind(HYPER, resize.key, function()
        local win = hs.window.focusedWindow()
        local f = win:frame()

        f.x = f.x - resize.size
        f.y = f.y - resize.size
        f.w = f.w + resize.size * 2
        f.h = f.h + resize.size * 2
        win:setFrame(f)
    end)
end

-- move window
local moves = {{
    key = "h",
    direction = {-STEP, 0}
}, {
    key = "l",
    direction = {STEP, 0}
},{
    key = "j",
    direction = {0, STEP}
}, {
    key = "k",
    direction = {0, -STEP}
}}

for i, move in ipairs(moves) do
    hs.hotkey.bind(HYPER, move.key, function()
        local win = hs.window.focusedWindow()
        local f = win:frame()
    
        f.x = f.x + move.direction[1]
        f.y = f.y + move.direction[2]
        win:setFrame(f)
    end)
end

-- move between displays
hs.hotkey.bind(HYPER, 'right', function()
    hs.window.focusedWindow():moveOneScreenEast()
end)
hs.hotkey.bind(HYPER, 'left', function()
    hs.window.focusedWindow():moveOneScreenWest()
end)
