local STEP = 20

hs.window.animationDuration = 0

-- full screen
hs.hotkey.bind(HYPER, 'f', function()
    hs.window.focusedWindow():maximize()
end)

-- resize window
local resizes = {{
    key = "]",
    size = {STEP, 0}
}, {
    key = "[",
    size = {-STEP, 0}
}, {
    key = "=",
    size = {0, STEP}
}, {
    key = "-",
    size = {0, -STEP}
}}

for i, resize in ipairs(resizes) do
    hs.hotkey.bind(HYPER, resize.key, function()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = math.max(f.x - resize.size[1], max.x)
        f.y = math.max(f.y - resize.size[2], max.y)
        f.w = f.w + resize.size[1] * 2
        f.h = f.h + resize.size[2] * 2
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
}, {
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
        local screen = win:screen()
        local max = screen:frame()

        f.x = math.max(math.min(f.x + move.direction[1], max.x + (max.w - f.w)), max.x)
        f.y = math.max(math.min(f.y + move.direction[2], max.y + (max.h - f.h)), max.y)
        win:setFrame(f)
    end)
end