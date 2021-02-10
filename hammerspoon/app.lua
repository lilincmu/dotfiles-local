local apps = {
  { key = "d", app = "Finder" },
  { key = "g", app = "Google Chrome" },
  { key = "t", app = "Terminal" },
  { key = "i", app = "IntelliJ IDEA" },
  { key = "o", app = "Microsoft OneNote" },
  { key = "s", app = "Slack" },
  { key = "a", app = "Atom" },
  { key = "p", app = "Postman" },
  { key = "z", app = "zoom.us" },
  { key = "c", app = "Visual Studio Code" },
}

for i, object in ipairs(apps) do
  hs.hotkey.bind(HYPER, object.key, function()
    hs.application.launchOrFocus(object.app)
  end)
end
