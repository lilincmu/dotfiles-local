local apps = {
  { key = "a", app = "Finder" },
  { key = "c", app = "Google Chrome" },
  { key = "t", app = "Terminal" },
}
  
for i, object in ipairs(apps) do
  hs.hotkey.bind(HYPER, object.key, function()
    hs.application.launchOrFocus(object.app)
  end)
end