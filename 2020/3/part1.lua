#! /usr/bin/env lua
local map = {}
local sub = string.sub
for line in io.lines() do
  local row = {}
  map[#map+1] = row
  for i = 1, #line do
    row[i] = sub(line,i,i) == '#'
  end
end
local width = #map[1]
local right = 3
local trees = 0
local x = 1
for y = 1, #map do
  if map[y][x] then trees = trees + 1 end
  x = (x-1 + right) % width + 1
end
print(trees)
