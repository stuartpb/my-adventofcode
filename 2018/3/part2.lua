#! /usr/bin/env lua
local inches = {}
for i = 1, 1000 do
  inches[i] = {}
end
local intact = {}
for line in io.lines() do
  local id, left, top, width, height = line:match('#(%d+) @ (%d+),(%d+): (%d+)x(%d+)')
  left = tonumber(left)
  top = tonumber(top)
  width = tonumber(width)
  height = tonumber(height)
  intact[id] = true
  for y = top + 1, top + height do
    for x = left + 1, left + width do
      if inches[y][x] then
        intact[inches[y][x]] = nil
        intact[id] = nil
      else
        inches[y][x] = id
      end
    end
  end
end
print((next(intact)))
