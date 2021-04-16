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

local function getScreenSpaces(name)
    local screenUUID = hs.screen.find(name):getUUID()
    return spaces.layout()[screenUUID]
end

local function applyLayout(layout)
    for _, entry in ipairs(layout) do
        local appName = entry[1]
        local screenName = entry[2]
        local spaceNum = entry[3]
        local rect = entry[4]

        local screenSpaces = getScreenSpaces(screenName)
        local spaceId = screenSpaces[spaceNum] and screenSpaces[spaceNum] or screenSpaces[#screenSpaces]
        local app = hs.application.get(appName)
        if app == nil then
            goto continue
        end

        local win = app:mainWindow()
        win:spacesMoveTo(spaceId)

        local frame = hs.geometry.copy(win:screen():frame())
        if rect:type() == 'rect' then
            frame.x = frame.x + rect.x
            frame.y = frame.y + rect.y
            frame.w = rect.w
            frame.h = rect.h
        elseif rect:type() == 'unitrect' then
            frame.x = frame.x + rect.x * frame.w
            frame.y = frame.y + rect.y * frame.h
            frame.w = frame.w * (rect.w - rect.x)
            frame.h = frame.h * (rect.h - rect.y)
        end
        win:setFrame(frame)

        ::continue::
    end
end

-- ref: https://github.com/anishathalye/dotfiles-local/blob/mac/hammerspoon/layout.lua
function autoLayout()
    if getScreenSpaces(LEFT_MONITOR) then
        applyLayout(LAYOUT_OFFICE)
    elseif getScreenSpaces(MIDDLE_MONITOR) then
        applyLayout(LAYOUT_HOME)
    else
        applyLayout(LAYOUT_LAPTOP)
    end
end