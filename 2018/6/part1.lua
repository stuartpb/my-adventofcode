#! /usr/bin/env lua
local unpack = table.unpack
local max = math.max
local min = math.min
local abs = math.abs

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
local space = {}
for spacey = top, bottom do
  local row = {}
  space[spacey] = row
  for spacex = left, right do
    local closest = math.huge
    local owned
    for id, point in pairs(points) do
      local pointx, pointy = unpack(point)
      local dist = abs(spacex - pointx) + abs(spacey - pointy)
      if dist < closest then
        closest = dist
        owned = id
      elseif dist == closest then
        owned = nil
      end
    end
    if owned then row[spacex] = owned end
  end
end
local largest = 0
for id, point in pairs(points) do
  local x, y = unpack(point)
  local infinite = space[y][left] == id or space[y][right] == id
    or space[top][x] == id or space[bottom][x] == id
  if not infinite then
    local size = 0
    for y = top, bottom do
      local row = space[y]
      for x = left, right do
        if row[x] == id then size = size + 1 end
      end
    end
    largest = max(largest, size)
  end
end
print(largest)
