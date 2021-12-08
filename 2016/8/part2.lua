#! /usr/bin/env lua
local screen = {}
local h = 6
local w = 50
for y = 0, h-1 do
  local row = {}
  screen[y] = row
  for x = 0, w-1 do
    row[x] = '.'
  end
end
for line in io.lines() do
  local op, rest = line:match'^(%a+) (.+)$'
  if op == 'rect' then
    local rw, rh = rest:match'(%d+)x(%d+)'
    for y = 0, rh-1 do
      local row = screen[y]
      for x = 0, rw-1 do
        row[x] = '#'
      end
    end
  elseif op == 'rotate' then
    local axis, pos, by = rest:match'(%a+ [xy])=(%d+) by (%d+)'
    pos = tonumber(pos)
    by = tonumber(by)
    if axis == 'row y' then
      local row = screen[pos]
      table.move(row, 0, w-1, by, row)
      table.move(row, w, w-1 + by, 0, row)
      table.move({}, 1, by, w, row)
    elseif axis == 'column x' then
      local rot = {}
      for y = 0, h-1 do
        rot[(y + by) % h] = screen[y][pos]
      end
      for y = 0, h-1 do
        screen[y][pos] = rot[y]
      end
    end
  end
end
for y = h, 1, -1 do
  local row = screen[y-1]
  screen[y] = row[0]..table.concat(row)
end
print(table.concat(screen,'\n'))
