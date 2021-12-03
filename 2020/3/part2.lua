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
local function treehits(right, down)
  local trees = 0
  local x = 1
  for y = 1, #map, down do
    if map[y][x] then trees = trees + 1 end
    x = (x-1 + right) % width + 1
  end
  return trees
end
print(
  treehits(1, 1) *
  treehits(3, 1) *
  treehits(5, 1) *
  treehits(7, 1) *
  treehits(1, 2))
