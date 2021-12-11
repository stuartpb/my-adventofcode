#! /usr/bin/env lua
local serial = tonumber(io.read())
local fuel = {[0]={[0]=0}}
for x = 1, 300 do
  fuel[0][x] = 0
end
for y = 1, 300 do
  local row = {[0]=0}
  fuel[y] = row
  local above = fuel[y-1]
  for x = 1, 300 do
    local rack = x + 10
    row[x] = (rack * y + serial) * rack // 100 % 10 - 5
      + row[x-1] + above[x] - above[x-1]
  end
end
local largest = -math.huge
local top, left, large
for size = 1, 300 do
  for y = size, 300 do
    local bottom = fuel[y]
    local topedge = fuel[y-size]
    for x = size, 300 do
      local square = bottom[x]
        - topedge[x] - bottom[x-size] + topedge[x-size]
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
