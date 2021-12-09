#! /usr/bin/env lua
local map = {}
for line in io.lines() do
  local row = {}
  map[#map+1] = row
  for char in line:gmatch'.' do
    row[#row+1] = tonumber(char)
  end
end
local total = 0
for y, row in pairs(map) do
  for x, here in pairs(row) do
    if y > 1 and map[y-1][x] <= here then goto continue end
    if x > 1 and row[x-1] <= here then goto continue end
    if y < #map and map[y+1][x] <= here then goto continue end
    if x < #row and row[x+1] <= here then goto continue end
    total = total + here + 1
    ::continue::
  end
end
print(total)
