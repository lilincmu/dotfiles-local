-- ref: https://github.com/anishathalye/dotfiles-local/blob/mac/hammerspoon/util.lua
utilMenu = hs.menubar.new()

local icon = [[
1 . . . . . . . . . . . 3
. # # . . . . . . . # # .
. # # # # . . . # # # # .
. . # # # # 2 # # # # . .
. . # # # # # # # # # . .
. . . # # # # # # # . . .
. . . 8 # # # # # 4 . . .
. . . # # # # # # # . . .
. . # # # # # # # # # . .
. . # # # # 6 # # # # . .
. # # # # . . . # # # # .
. # # . . . . . . . # # .
7 . . . . . . . . . . . 5
]]

utilMenu:setIcon('ASCII:' .. icon)

local menu = nil

local reloadMenu = function() utilMenu:setMenu(menu) end

menu = {
  {
    title = "Caffeinate",
    checked = hs.caffeinate.toggle('displayIdle'), -- set default to true
    fn = function(modifiers, menuItem)
      local enabled = hs.caffeinate.toggle('displayIdle')
      if enabled then
        hs.notify.new({title='Caffeinate', informativeText='Caffeinate on'}):send()
      else
        hs.notify.new({title='Caffeinate', informativeText='Caffeinate off'}):send()
      end

      menuItem.checked = enabled
      reloadMenu()
    end
  },
  {
    title = "-" -- separator
  },
  {
    title = "Auto Layout",
    fn = autoLayout
  },
  {
    title = "-" -- separator
  },
  {
    title = "Start Countdown",
    fn = function()
      startCountdown()
    end
  },
  {
    title = "Stop Countdown",
    fn = function()
      stopCountdown()
    end
  },
}

reloadMenu()