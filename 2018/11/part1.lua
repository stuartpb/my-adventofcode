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
local top, left
for y = 1, 298 do
  local row1 = fuel[y]
  local row2 = fuel[y+1]
  local row3 = fuel[y+2]
  for x = 1, 298 do
    local square =
      row1[x] + row1[x+1] + row1[x+2] +
      row2[x] + row2[x+1] + row2[x+2] +
      row3[x] + row3[x+1] + row3[x+2]
    if square > largest then
      largest = square
      top = y
      left = x
    end
  end
end
print(left, top)
