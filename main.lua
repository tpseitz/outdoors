require "lib.maps"
require "lib.characters"
require "lib.menu"

love.graphics.setDefaultFilter("nearest", "nearest", 1)

local tileset, room = {}, {}
local location = { cx = 8, cy = 8 }
local hero = { x = 8, y = 8, dir = "up", follow = 1 }
local objects = {}
local chars = {}
local frame = 0
local scale = 4
local menu = nil

function love.load()
  room = load_map("test_map")
  chars = room.objects
  tileset = load_tiles("test_set")
end

function love.keypressed(key)
  if key == '-' then scale = scale - 1 end
  if key == '+' then scale = scale + 1 end
  if scale < 1 then scale = 1 end
  if scale > 8 then scale = 8 end
  menu = key_pressed(key, menu)
end

function love.update(dt)
  location.width  = math.ceil(love.graphics.getWidth()  / scale)
  location.height = math.ceil(love.graphics.getHeight() / scale)

  menu = update_menu(menu)
  if not menu then
    frame = frame + dt
    hero = update_hero(hero, room, frame)
    chars, objects = update_characters(chars, hero)
    location = update_location(location, tileset, room, hero, dt)
    update_animations(dt)
  end
end

function love.draw()
  local cnv = love.graphics.newCanvas(location.width, location.height) 
  love.graphics.setCanvas(cnv)

  draw_map(location, tileset, room)
  draw_map(location, tileset, objects)
  draw_menu(location, menu)

  love.graphics.setCanvas()
  love.graphics.draw(cnv, 0, 0, 0, scale)
end
