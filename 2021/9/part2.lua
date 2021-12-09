#! /usr/bin/env lua
local map = {}
for line in io.lines() do
  local row = {}
  map[#map+1] = row
  for char in line:gmatch'.' do
    row[#row+1] = tonumber(char)
  end
end
local basinSizes = {0,0,0}
local function fillBasin(x, y)
  if not map[y] or not map[y][x] or map[y][x] == 9 then return 0 end
  map[y][x] = 9
  return 1 + fillBasin(x-1, y) + fillBasin(x+1, y) +
    fillBasin(x, y-1) + fillBasin(x, y+1)
end
for y, row in pairs(map) do
  for x, here in pairs(row) do
    if here ~= 9 then
      local basinSize = fillBasin(x,y)
      for i = 1, 3 do
        if basinSize > basinSizes[i] then
          table.insert(basinSizes,i,basinSize)
          basinSizes[4] = nil
          break
        end
      end
    end
  end
end
print(basinSizes[1] * basinSizes[2] * basinSizes[3])
