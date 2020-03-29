require "lib.maps"

local tileset, room = {}, {}
local objects = { items = { c8x8 = 1 } }
local location = { cx = 8, cy = 8 }
local character = { x = 8, y = 8 }

function love.load()
  room = load_map("test_map")
  tileset = load_tiles("test_set")
end

function love.update(dt)
  location = update_location(location, tileset, room, dt)
end

function love.draw()
  draw_map(location, tileset, room, objects)
end
