#! /usr/bin/env lua
local unpack = table.unpack
local max = math.max
local min = math.min
local abs = math.abs
local pairs = pairs

local points = {}
local left = math.huge
local top = math.huge
local right = 0
local bottom = 0
for line in io.lines() do
  local x, y = line:match('(%d+)%D+(%d+)')
  x = tonumber(x)
  y = tonumber(y)
  left = min(left, x)
  right = max(right, x)
  top = min(top, y)
  bottom = max(bottom, y)
  points[#points+1] = {x, y}
end
local area = 0
local margin = 10000 // #points - #points
for y = top - margin, bottom + margin do
  local rowmargin = max(top-y, y-bottom, 0)
  local rowleft = left - margin + rowmargin
  local rowright = right + margin - rowmargin
  for x = rowleft, rowright  do
    local distance = 0
    for id, point in pairs(points) do
      distance = distance + abs(x - point[1]) + abs(y - point[2])
      if distance >= 10000 then goto continue end
    end
    area = area + 1
    ::continue::
  end
end
print(area)
