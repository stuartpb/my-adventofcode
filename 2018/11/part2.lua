#! /usr/bin/env lua
local serial = tonumber(io.read())
local fuel = {}
for y = 1, 300 do
  local row = {}
  fuel[y] = row
  local above = fuel[y-1] or {}
  for x = 1, 300 do
    local rack = x + 10
    row[x] = (rack * y + serial) * rack // 100 % 10 - 5 +
      (row[x-1] or 0) + (above[x] or 0) - (above[x-1] or 0)
  end
end
local largest = -math.huge
local top, left, large
for size = 1, 300 do
  for y = size, 300 do
    local bottom = fuel[y]
    local topedge = fuel[y-size] or {}
    for x = size, 300 do
      local square = bottom[x] - (topedge[x] or 0) -
        (bottom[x-size] or 0) + (topedge[x-size] or 0)
      if square > largest then
        largest = square
        top = y - size + 1
        left = x - size + 1
        large = size
      end
    end
  end
end
print(left, top, large)
