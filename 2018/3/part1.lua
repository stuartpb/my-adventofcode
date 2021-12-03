#! /usr/bin/env lua
local inches = {}
for i = 1, 1000 do
  local row = {}
  inches[i] = row
  for j = 1, 1000 do
    row[j] = 0
  end
end
for line in io.lines() do
  local left, top, width, height = line:match('#%d+ @ (%d+),(%d+): (%d+)x(%d+)')
  left = tonumber(left)
  top = tonumber(top)
  width = tonumber(width)
  height = tonumber(height)
  for y = top + 1, top + height do
    for x = left + 1, left + width do
      inches[y][x] = inches[y][x] + 1
    end
  end
end
local overlap = 0
for i = 1, 1000 do
  local row = inches[i]
  for j = 1, 1000 do
    if row[j] > 1 then overlap = overlap + 1 end
  end
end
print(overlap)
