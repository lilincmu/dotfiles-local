local STEP = 20

hs.window.animationDuration = 0

-- switch between sizes
windowFrames = {}
local sizes = {
    {1, 1},
    {0.8, 0.8},
    {0.5, 1},
    {1, 0.5},
    {0.5, 0.5},
}
hs.hotkey.bind(HYPER, 'f', function()
    local win = hs.window.focusedWindow()
    local frames = windowFrames[win:id()]
    if frames ~= nil then
        local firstFrame = frames[1]
        -- check if window hasn't been resized
        if (win:frame():equals(firstFrame)) then
            table.remove(frames, 1)
            table.insert(frames, firstFrame)
            win:setFrame(frames[1])
            return
        end
    end

    local oldFrame = hs.geometry.copy(win:frame())
    win:maximize()
    frames = {}
    for i, size in ipairs(sizes) do
        local frame = hs.geometry.copy(win:frame())
        frame.w = frame.w * size[1]
        frame.h = frame.h * size[2]
        table.insert(frames, frame)
    end
    table.insert(frames, oldFrame)
    windowFrames[win:id()] = frames
end)

-- center window
hs.hotkey.bind(HYPER, '\\', function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local max = win:screen():frame()
    log(f)
    log(max)

    f.x = max.x + (max.w - f.w) / 2
    f.y = max.y + (max.h - f.h) / 2
    win:setFrame(f)
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
