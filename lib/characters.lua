local move_time = 0.1
local turn_time = 0.1

function move_char(chr, map, frame, x, y)
  local mt = (map.map[y] or {})[x]
  if not mt then return chr end
  local ps = map.pass[mt]
  if not ps then return chr end
  local mo = map.items[x .. ',' .. y]
  if mo then return chr end

  chr.afr = frame + move_time
  chr.x, chr.y = x, y
  chr.follow = 1
  return chr
end

function update_hero(hero, map, frame)
  if frame < (hero.afr or 0) then
    return hero
  end

  if love.keyboard.isDown("a") then
    if hero.dir == "left" then
      hero = move_char(hero, map, frame, hero.x - 1, hero.y)
    else
      hero.afr = frame + turn_time
      hero.dir = "left"
    end
  end
  if love.keyboard.isDown("d") then
    if hero.dir == "right" then
      hero = move_char(hero, map, frame, hero.x + 1, hero.y)
    else
      hero.afr = frame + turn_time
      hero.dir = "right"
    end
  end
  if love.keyboard.isDown("w") then
    if hero.dir == "up" then
      hero = move_char(hero, map, frame, hero.x, hero.y - 1)
    else
      hero.afr = frame + turn_time
      hero.dir = "up"
    end
  end
  if love.keyboard.isDown("s") then
    if hero.dir == "down" then
      hero = move_char(hero, map, frame, hero.x, hero.y + 1)
    else
      hero.afr = frame + turn_time
      hero.dir = "down"
    end
  end

  return hero
end

function update_characters(cls, hero)
  map = { items = {}, }
  for cc,ch in pairs(cls) do
    map.items[cc] = { nm = ch.nm, dir = ch.dir }
  end

  map.items[hero.x .. ',' .. hero.y] = { nm = "hero", dir = hero.dir }

  return cls, map
end
