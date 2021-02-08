-- Based on https://github.com/Hammerspoon/hammerspoon/issues/235#issuecomment-341298390
-- Install spaces module https://github.com/asmagill/hs._asm.undocumented.spaces

local spaces = require("hs._asm.undocumented.spaces")

local function getGoodFocusedWindow(nofull)
    local win = hs.window.focusedWindow()
    if not win or not win:isStandard() then
        return
    end
    if nofull and win:isFullScreen() then
        return
    end
    return win
end

function switchSpace(skip, dir)
    for i = 1, skip do
        hs.eventtap.keyStroke({"ctrl"}, dir)
    end
end

local function moveWindowOneSpace(dir)
    local win = getGoodFocusedWindow(true)
    if not win then
        return
    end
    local screen = win:screen()
    local uuid = screen:spacesUUID()
    local userSpaces = spaces.layout()[uuid]
    local thisSpace = win:spaces() -- first space win appears on
    if not thisSpace then
        return
    else
        thisSpace = thisSpace[1]
    end
    local last = nil
    local skipSpaces = 0
    for _, spc in ipairs(userSpaces) do
        if spaces.spaceType(spc) ~= spaces.types.user then -- skippable space
            skipSpaces = skipSpaces + 1
        else -- A good user space, check it
            if last and (dir == "left" and spc == thisSpace) or (dir == "right" and last == thisSpace) then
                switchSpace(skipSpaces + 1, dir)
                win:spacesMoveTo(dir == "left" and last or spc)
                win:focus()
                return
            end
            last = spc -- Haven't found it yet...
            
            skipSpaces = 0
        end
    end
    -- end of spaces
    if dir == "left" then
        hs.window.focusedWindow():moveOneScreenWest()
    else
        hs.window.focusedWindow():moveOneScreenEast()
    end
    win:focus()
end

-- move between spaces
hs.hotkey.bind(HYPER, "left", function()
    moveWindowOneSpace("left")
end)

hs.hotkey.bind(HYPER, "right", function()
    moveWindowOneSpace("right")
end)

-- move between displays
hs.hotkey.bind(HYPER, "'", function()
    hs.window.focusedWindow():moveOneScreenEast()
end)
hs.hotkey.bind(HYPER, ';', function()
    hs.window.focusedWindow():moveOneScreenWest()
end)