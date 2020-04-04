local map = {
  map = {
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }, 
    { 1, 2, 1, 1, 3, 3, 3, 1, 4, 1, 4, 1, 2, 2, 2, 1, 1, 1, 1, 1 },
    { 1, 2, 1, 1, 3, 1, 3, 1, 4, 1, 4, 1, 2, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 2, 2, 1, 3, 3, 3, 1, 1, 4, 1, 1, 2, 2, 1, 1, 1, 1, 1, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 2, 1, 2, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 1 },
    { 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 2, 1, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 2, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 2, 1, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 3, 3, 3, 1, 4, 4, 4, 1, 2, 2, 2, 1, 3, 1, 1, 1, 1, 1, 1 },
    { 1, 3, 1, 1, 1, 4, 1, 4, 1, 2, 1, 2, 1, 3, 1, 1, 1, 1, 1, 1 },
    { 1, 3, 1, 1, 1, 4, 1, 4, 1, 2, 1, 2, 1, 3, 1, 1, 1, 1, 1, 1 },
    { 1, 3, 3, 3, 1, 4, 4, 4, 1, 2, 2, 2, 1, 3, 3, 3, 1, 1, 1, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
  },
  pass = {},
  items = {},
  objects = {},
}

map.pass[1] = 1

map.items['6,9'] = { nm = "dbush" }
map.items['7,9'] = { nm = "dbush" }
map.items['8,9'] = { nm = "dbush" }
map.items['9,5'] = { nm = "mosh" }

map.objects['6,11'] = { nm = "duck" }
map.objects['8,11'] = { nm = "calf" }
map.objects['7,6']  = { nm = "skel" }
map.objects['9,6']  = { nm = "zombi" }

return map
