local transparent = {
    white = 0,
    alpha = 0,
}
local textColor = {
    hex = '#33FF00', -- green
    alpha = 0.8,
}

local function getAlertText(seconds)
    local min = math.floor(seconds / 60)
    local sec = seconds % 60
    return string.format("%02d:%02d", min, sec)
end

local function getAlertStyle()
    local screenHeight = hs.screen.mainScreen():frame().h
    local textSize = screenHeight * 0.4
    -- hs.styledtext.fontNamesWithTraits(hs.styledtext.fontTraits.fixedPitchFont)
    -- Monaco, Menlo-Regular, AppleBraille, AppleColorEmoji, MesloLGSNerdFontCompleteM-Regular
    local textFont = hs.styledtext.validFont('Monaco')
        and 'Monaco' or 'Menlo-Regular'
    return {
        fillColor = transparent,
        strokeColor = transparent, -- border color
        atScreenEdge = 1, -- screen top
        padding = (screenHeight - textSize) / 2,
        textSize = textSize,
        textFont = textFont,
        textColor = textColor,
    }
end

local function countdown(seconds, id)
    if COUNTDOWN_LATEST_ID ~= id then
        return
    end

    hs.alert.closeAll()
    if seconds >= 0 then
        hs.alert.show(getAlertText(seconds), getAlertStyle(), nil, 1)
        local timer = hs.timer.doAfter(1, function()
            countdown(seconds - 1, id)
        end)
        timer:start()
    end
end

COUNTDOWN_LATEST_ID = 0

function startCountdown()
    COUNTDOWN_LATEST_ID = hs.host.uuid()
    countdown(25 * 60, COUNTDOWN_LATEST_ID)
end

function stopCountdown()
    COUNTDOWN_LATEST_ID = hs.host.uuid()
    hs.alert.closeAll()
end

hs.hotkey.bind(HYPER, "2", startCountdown)