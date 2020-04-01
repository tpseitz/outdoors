local animations = {}
local frame = 0

function load_animation(filename, layout, size, speed)
  local size = size or 16
  local img = love.graphics.newImage("gfx/" .. filename)
  local width, height = img:getDimensions()
  local anim = {}
  local obj = { atlas=img, spd=(speed or 1) }

  if layout == "char" then
    for y,nm in ipairs({"down","right","up","left","idle"}) do
      if y * size > height then break end
      anim[nm] = {}
      for x=0,15 do
        if x * size > width then break end
        anim[nm][x] = love.graphics.newQuad(
          x * size, (y - 1) * size, size, size, width, height)
      end
    end
    obj.nm = "down"
  elseif layout == "anim" then
    obj.nm = "default"
    anim[obj.nm] = {}
    for x=0,15 do
      if x * size > width then break end
      anim[obj.nm][x] = love.graphics.newQuad(
        x * size, 0, size, size, width, height)
    end
  else
    print("Unknown animation type " .. layout)
    return nil
  end

  obj.anim = anim
  obj.fc = width / size - 1
  obj.frame = obj.anim[obj.nm][1]

  table.insert(animations, obj)

  return obj
end

function update_animations(delta)
  frame = frame + delta * 10

  for i,obj in ipairs(animations) do
    obj.frame = obj.anim[obj.nm][math.floor((frame * obj.spd) % obj.fc + 1)]
  end
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
  end

  return set
end

function load_map(filename)
  local map = loadfile("maps/" .. filename .. ".lua")()

  map.width, map.height = 1, 1
  for p in ipairs(map.map[1]) do map.width  = map.width  + 1 end
  for p in ipairs(map.map)    do map.height = map.height + 1 end

  return map
end

function update_hero(set, delta)
  if set.obj["hero"] then
    if love.keyboard.isDown("a") then set.obj["hero"].nm = "left"  end
    if love.keyboard.isDown("d") then set.obj["hero"].nm = "right" end
    if love.keyboard.isDown("w") then set.obj["hero"].nm = "up"    end
    if love.keyboard.isDown("s") then set.obj["hero"].nm = "down"  end
  end
end

function update_location(dsp, set, map, delta)
  dsp.width  = love.graphics.getWidth()
  dsp.height = love.graphics.getHeight()

  dsp.tw = math.ceil(dsp.width  / set.width  / set.scale)
  dsp.th = math.ceil(dsp.height / set.height / set.scale)

  if love.keyboard.isDown("left") then
    dsp.cx = dsp.cx - delta * dsp.tw
  end
  if love.keyboard.isDown("right") then
    dsp.cx = dsp.cx + delta * dsp.tw
  end
  if love.keyboard.isDown("up") then
    dsp.cy = dsp.cy - delta * dsp.th
  end
  if love.keyboard.isDown("down") then
    dsp.cy = dsp.cy + delta * dsp.th
  end

  if dsp.cx < 1 then dsp.cx = 1 end
  if dsp.cy < 1 then dsp.cy = 1 end
  if dsp.cx > map.width  then dsp.cx = map.width  end
  if dsp.cy > map.height then dsp.cy = map.height end

  return dsp
end

function draw_map(dsp, set, map, obj)
  local sx, ox = math.modf(dsp.cx - dsp.tw / 2)
  local sy, oy = math.modf(dsp.cy - dsp.th / 2)
  local wd, ht = set.width * set.scale, set.height * set.scale
  ox, oy = ox * set.width * set.scale, oy * set.height * set.scale

  for y = 0, dsp.th do
    for x = 0, dsp.tw do
      if map then
        tx, ty = (x * wd) - ox, (y * ht) - oy
        local mt = (map.map[sy + y] or {})[sx + x]
        if mt and mt > 0 then
          local tl = set.tile[mt]
          love.graphics.draw(tl, tx, ty, 0, set.scale, set.scale)
        end
      end

      if obj then
        cs = (sx + x) .. ',' .. (sy + y)
        ob = obj.items[cs]
        if ob then
          local img, q = set.obj[ob].atlas, set.obj[ob].frame
          love.graphics.draw(img, q, tx, ty, 0, set.scale, set.scale)
        end
      end
    end
  end
end
