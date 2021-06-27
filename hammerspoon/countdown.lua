local totalDuration = 25 * 60 -- 25 minutes
local alertDuration = 1.1 -- avoid blinking

local transparent = {
    white = 0,
    alpha = 0,
}
local black = {
    white = 0,
    alpha = 0.97,
}
local textColor = {
    hex = '#33FF00', -- green
    alpha = 1,
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
    local textFont = hs.styledtext.validFont('Monaco') and 'Monaco' or 'Menlo-Regular'
    return {
        fillColor = transparent,
        strokeColor = transparent, -- border color
        atScreenEdge = 1, -- screen top
        padding = screenHeight * 0.25,
        textSize = textSize,
        textFont = textFont,
        textColor = textColor,
    }
end

local function getBackgroundStyle()
    return {
        fillColor = black,
        strokeColor = transparent,
        padding = hs.screen.mainScreen():frame().h,
        atScreenEdge = 1,
    }
end

local function countdown(seconds, id)
    if COUNTDOWN_LATEST_ID ~= id then
        return
    end

    if seconds >= 0 then
        hs.alert.show(getAlertText(seconds), getAlertStyle(), alertDuration)
        local timer = hs.timer.doAfter(1, function()
            countdown(seconds - 1, id)
        end)
        timer:start()
    else
        hs.alert.closeAll()
    end
end

COUNTDOWN_LATEST_ID = 0

function startCountdown()
    -- add black background
    hs.alert.show("", getBackgroundStyle(), totalDuration + alertDuration)

    COUNTDOWN_LATEST_ID = hs.host.uuid()
    countdown(totalDuration, COUNTDOWN_LATEST_ID)
end

function stopCountdown()
    COUNTDOWN_LATEST_ID = hs.host.uuid()
    hs.alert.closeAll()
end

hs.hotkey.bind(HYPER, "2", startCountdown)
hs.hotkey.bind(HYPER, "3", stopCountdown)