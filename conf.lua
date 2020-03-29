function love.conf(t)
    t.identity = "outdoors_rpg"
    t.appendidentity = false
    t.window.title = "Outdoor RPG"
    -- We need an icon for our game
    t.window.icon = nil
    t.window.width = 800
    t.window.height = 600
    t.window.resizable = true
    t.window.minwidth = 200
    t.window.minheight = 150
    t.window.fullscreentype = "desktop"
end
