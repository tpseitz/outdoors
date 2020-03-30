function load_animation(filename, layout, size)
  size = size or 16
  img = love.graphics.newImage("gfx/" .. filename)
  width, height = img:getDimensions()
  anim = { atlas=img }

  if layout == "char" then
    for y,nm in ipairs({"down","right","up","left","idle"}) do
      if y * size >= height then break end
      anim[nm] = {}
      for x=1,4 do
        if x * size >= width then break end
        anim[nm][x] = love.graphics.newQuad(
          x * size, y * size, size, size, width, height)
      end
    end
  end

  return anim
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
  for i, ani in ipairs(set.object_files) do
    set.obj[i] = load_animation(unpack(ani))
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

function update_location(dsp, set, map, dt)
  dsp.width  = love.graphics.getWidth()
  dsp.height = love.graphics.getHeight()

  dsp.tw = math.floor(dsp.width  / set.width)
  dsp.th = math.floor(dsp.height / set.height)

  if love.keyboard.isDown("left") then
    dsp.cx = dsp.cx - dt * dsp.tw
  end
  if love.keyboard.isDown("right") then
    dsp.cx = dsp.cx + dt * dsp.tw
  end
  if love.keyboard.isDown("up") then
    dsp.cy = dsp.cy - dt * dsp.th
  end
  if love.keyboard.isDown("down") then
    dsp.cy = dsp.cy + dt * dsp.th
  end

  if dsp.cx < 1 then dsp.cx = 1 end
  if dsp.cy < 1 then dsp.cy = 1 end
  if dsp.cx > map.width  then dsp.cx = map.width  end
  if dsp.cy > map.height then dsp.cy = map.height end

  return dsp
end

function draw_map(dsp, set, map, obj)
  local sx, ox = math.modf(dsp.cx - dsp.width / 2)
  local sy, oy = math.modf(dsp.cy - dsp.height / 2)
  local wd, ht = set.width * set.scale, set.height * set.scale
  ox, oy = ox * set.width, oy * set.height

  for y = 0, dsp.th do
    for x = 0, dsp.tw do
      cs = 'c' .. (sx + x) .. 'x' .. (sy + y)
      tx, ty = (x * wd) - ox, (y * ht) - oy

      local mt = (map.map[sy + y] or {})[sx + x]
      if mt and mt > 0 then
        local tl = set.tile[mt]
        love.graphics.draw(tl, tx, ty, 0, dsp.scale, dsp.scale)
      end

      ob = obj.items[cs]
      if ob then
        local img, q = set.obj[ob].atlas, set.obj[ob]['up'][1]
        love.graphics.draw(img, q, tx, ty, 0, scale, scale)
      end
    end
  end
end
