function move_char(chr, map, frame, x, y)
  chr.afr = frame + 0.1
  chr.x, chr.y = x, y
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
      hero.afr = frame + 0.2
      hero.dir = "left"
    end
  end
  if love.keyboard.isDown("d") then
    if hero.dir == "right" then
      hero = move_char(hero, map, frame, hero.x + 1, hero.y)
    else
      hero.afr = frame + 0.2
      hero.dir = "right"
    end
  end
  if love.keyboard.isDown("w") then
    if hero.dir == "up" then
      hero = move_char(hero, map, frame, hero.x, hero.y - 1)
    else
      hero.afr = frame + 0.2
      hero.dir = "up"
    end
  end
  if love.keyboard.isDown("s") then
    if hero.dir == "down" then
      hero = move_char(hero, map, frame, hero.x, hero.y + 1)
    else
      hero.afr = frame + 0.2
      hero.dir = "down"
    end
  end

  return hero
end

function update_characters(cls, hero)
  map = { items = {}, }
  for i,ch in ipairs(cls) do
    map.items[ch.x .. ',' .. ch.y] = { nm = ch.name, dir = ch.dir }
  end

  map.items[hero.x .. ',' .. hero.y] = { nm = "hero", dir = hero.dir }

  return cls, map
end
