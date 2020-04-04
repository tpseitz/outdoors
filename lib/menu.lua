local main_menu = { keys = {}, buttons = {} }
main_menu.keys['q'] = function() return love.event.quit(0) end
main_menu.keys['f10'] = function() return love.event.quit(0) end
local stack = {}

function key_pressed(key, menu)
  if key == "escape" then
    if menu then
      return table.remove(stack)
    else
      return main_menu
    end
  end

  if menu then
    fnc = menu.keys[key]
    if fnc then fnc(menu) end
  end

  return menu
end

function update_menu(menu)
  return menu
end

function draw_menu(dsp, menu)
  if not menu then return nil end

  love.graphics.setColor(0, 0, 0, 0.75)
  love.graphics.rectangle("fill", 0, 0, dsp.width, dsp.height)
  love.graphics.setColor(1, 1, 1, 1)
end
