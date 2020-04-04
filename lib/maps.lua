local animations = {}
local frame = 0

function load_animation(filename, layout, speed)
  local size = size or 16
  local img = love.graphics.newImage("gfx/" .. filename)
  local width, height = img:getDimensions()
  local anim = {}
  local obj = { atlas=img, spd=(speed or 1) }

  obj.fc = math.floor(width / size) - 1

  if layout == "char" then
    for y,nm in ipairs({"down","right","up","left"}) do
      if y * size > height then break end
      anim[nm] = {}
      for x=0,obj.fc do
        anim[nm][x] = love.graphics.newQuad(
          x * size, (y - 1) * size, size, size, width, height)
      end
    end
    obj.default = "down"
  elseif layout == "anim" then
    obj.default = "default"
    anim[obj.default] = {}
    for x=0,obj.fc do
      anim[obj.default][x] = love.graphics.newQuad(
        x * size, 0, size, size, width, height)
    end
  else
    print("Unknown animation type " .. layout)
    return nil
  end

  obj.anim = anim
  obj.frame = obj.anim[obj.default][1]

  return obj
end

function load_tiles(filename)
  local set = loadfile("gfx/" .. filename .. ".lua")()

  set.images = {}

  set.tile = {}
  for i, fn in ipairs(set.tile_files) do
    if not set.images[fn] then
      set.images[fn] = love.graphics.newImage("gfx/" .. fn)
    end
    set.tile[i] = set.images[fn]
  end

  set.obj = {}
  for nm, ani in pairs(set.object_files) do
    set.obj[nm] = load_animation(unpack(ani))
    animations[nm] = set.obj[nm]
  end

  return set
end

function update_animations(delta)
  frame = frame + delta * 7
end

function get_ani(name, ani)
  local obj = animations[name]
  if not obj then
    print("No animation object " .. name)
    return nil
  end

  ani = ani or obj.default

  return obj.atlas, obj.anim[ani][math.floor((frame * obj.spd) % obj.fc + 1)]
end

function load_map(filename)
  local map = loadfile("maps/" .. filename .. ".lua")()

  map.width, map.height = 1, 1
  for p in ipairs(map.map[1]) do map.width  = map.width  + 1 end
  for p in ipairs(map.map)    do map.height = map.height + 1 end

  return map
end

function update_location(dsp, set, map, hero, delta)
  dsp.width  = dsp.width  or love.graphics.getWidth()
  dsp.height = dsp.height or love.graphics.getHeight()

  dsp.tw = math.ceil(dsp.width  / set.size)
  dsp.th = math.ceil(dsp.height / set.size)

  if love.keyboard.isDown("left") then
    hero.follow = nil
    dsp.cx = dsp.cx - delta * dsp.tw
  end
  if love.keyboard.isDown("right") then
    hero.follow = nil
    dsp.cx = dsp.cx + delta * dsp.tw
  end
  if love.keyboard.isDown("up") then
    hero.follow = nil
    dsp.cy = dsp.cy - delta * dsp.th
  end
  if love.keyboard.isDown("down") then
    hero.follow = nil
    dsp.cy = dsp.cy + delta * dsp.th
  end
  if love.keyboard.isDown("space") then
    hero.follow = 1
  end

  if hero.follow then
    dsp.cx, dsp.cy = hero.x + 1, hero.y + 1
  end

  if dsp.cx < 1 then dsp.cx = 1 end
  if dsp.cy < 1 then dsp.cy = 1 end
  if dsp.cx > map.width  then dsp.cx = map.width  end
  if dsp.cy > map.height then dsp.cy = map.height end

  return dsp
end

function draw_map(dsp, set, map)
  local sx, ox = math.modf(dsp.cx - dsp.tw / 2)
  local sy, oy = math.modf(dsp.cy - dsp.th / 2)
  ox, oy = ox * set.size, oy * set.size

  for y = 0, dsp.th do
    for x = 0, dsp.tw do
      tx, ty = (x * set.size) - ox, (y * set.size) - oy

      if map.map then
        local mt = (map.map[sy + y] or {})[sx + x]
        if mt and mt > 0 then
          local tl = set.tile[mt]
          love.graphics.draw(tl, tx, ty, 0)
        end
      end

      if map.items then
        cs = (sx + x) .. ',' .. (sy + y)
        ob = map.items[cs]
        if ob then
          local img, q = get_ani(ob.nm, ob.dir)
          love.graphics.draw(img, q, tx, ty, 0)
        end
      end
    end
  end
end
