require "lib.maps"

love.graphics.setDefaultFilter("nearest", "nearest", 1)

local tileset, room = {}, {}
local objects = { items = {} }
local location = { cx = 8, cy = 8 }
local character = { x = 8, y = 8 }
objects.items['8,8'] = "hero"
objects.items['6,9'] = "dbush"

function love.load()
  room = load_map("test_map")
  tileset = load_tiles("test_set")
end

function love.update(dt)
  update_hero(tileset, dt)
  location = update_location(location, tileset, room, dt)
  update_animations(dt)
end

function love.draw()
  draw_map(location, tileset, room, objects)
end
