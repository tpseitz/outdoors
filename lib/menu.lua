local main_menu = {}
local stack = {}

function prepare_menu(name)
  local menu = loadfile("lib/menu_" .. name .. ".lua")()
  return menu
end

function load_menus()
  main_menu = prepare_menu("main")
end

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
