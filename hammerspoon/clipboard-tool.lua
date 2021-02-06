-- https://www.hammerspoon.org/Spoons/ClipboardTool.html 
ClipboardTool = hs.loadSpoon('ClipboardTool')
ClipboardTool.show_in_menubar = false
ClipboardTool.show_copied_alert = false
ClipboardTool.paste_on_select = true
ClipboardTool:start()
ClipboardTool:bindHotkeys({
  toggle_clipboard = {HYPER, "v"}
})