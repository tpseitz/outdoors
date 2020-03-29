function load_tiles(filename)
  local set = loadfile("gfx/" .. filename .. ".lua")()

  set.tile = {}
  for i, fn in ipairs(set.tile_files) do
    set.tile[i] = love.graphics.newImage("gfx/" .. fn)
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

function draw_map(dsp, set, map)
  local sx, ox = math.modf(dsp.cx - dsp.tw / 2)
  local sy, oy = math.modf(dsp.cy - dsp.th / 2)
  ox, oy = ox * set.width, oy * set.height

  for y = 0, dsp.th  do
    for x = 0, dsp.tw do

      local mt = (map.map[sy + y] or {})[sx + x]
      if mt and mt > 0 then
        local tl = set.tile[mt]
        love.graphics.draw(tl, (x * set.width) - ox, (y * set.height) - oy)
      end

      if ob then
        local tl = nil
        love.graphics.draw(tl, (x * set.width) + ox, (y * set.height) + oy)
      end
    end
  end
end
