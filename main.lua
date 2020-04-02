require "lib.maps"

love.graphics.setDefaultFilter("nearest", "nearest", 1)

local tileset, room = {}, {}
local location = { cx = 8, cy = 8 }
local character = { x = 8, y = 8 }

function love.load()
  room = load_map("test_map")
  room.items['8,8'] = "hero" --XXX
  tileset = load_tiles("test_set")
end

function love.update(dt)
  update_hero(tileset, dt)
  location = update_location(location, tileset, room, dt)
  update_animations(dt)
end

function love.draw()
  draw_map(location, tileset, room)
end
