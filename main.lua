require "lib.maps"
require "lib.characters"

love.graphics.setDefaultFilter("nearest", "nearest", 1)

local tileset, room = {}, {}
local location = { cx = 8, cy = 8 }
local hero = { x = 8, y = 8, dir = "up" }
local chars = {}
local objects = {}
local frame = 0

function love.load()
  room = load_map("test_map")
  tileset = load_tiles("test_set")
end

function love.update(dt)
  frame = frame + dt
  hero = update_hero(hero, room, frame)
  chars, objects = update_characters(chars, hero)
  location = update_location(location, tileset, room, dt)
  update_animations(dt)
end

function love.draw()
  draw_map(location, tileset, room)
  draw_map(location, tileset, objects)
end
