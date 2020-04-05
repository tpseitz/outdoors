local menu = {
  keys = {
    q   = function() return love.event.quit(0) end,
    f10 = function() return love.event.quit(0) end,
  },
  buttons = {
    { image_file = "creat_calf", hover_file = "creat_moo",
      func = function() return love.event.quit(0) end },
  }
}

return menu
