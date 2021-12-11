#! /usr/bin/env lua
local serial = tonumber(io.read())
local fuel = {}
for y = 1, 300 do
  row = {}
  fuel[y] = row
  for x = 1, 300 do
    local rack = x + 10
    row[x] = (rack * y + serial) * rack // 100 % 10 - 5
  end
end
local largest = -math.huge
local top, left, large
for size = 1, 300 do
  print('checking size',size)
  for y = 1, 301 - size do
    local rows = {}
    for i = 0, size - 1 do
      rows[i+1] = fuel[y+i]
    end
    for x = 1, 301 - size do
      local square = 0
      for rx = x, x + size - 1 do
        for i = 1, size do
          square = square + rows[i][rx]
        end
      end
      if square > largest then
        largest = square
        top = y
        left = x
        large = size
      end
    end
  end
end
print(left, top, large)
