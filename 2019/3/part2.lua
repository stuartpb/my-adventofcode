#! /usr/bin/env lua
local x = 0
local y = 0
local steps = 0
local wire1path = {}
local dirs = {U = {0, -1}, D = {0, 1}, L = {-1, 0}, R = {1, 0}}
for dir, dist in io.read():gmatch('([UDLR])(%d+)') do
  local xstep, ystep = dirs[dir][1], dirs[dir][2]
  local xdest = x + xstep * dist
  local ydest = y + ystep * dist
  while x ~= xdest or y ~= ydest do
    x = x + xstep
    y = y + ystep
    steps = steps + 1
    if not wire1path[y] then wire1path[y] = {} end
    wire1path[y][x] = steps
  end
end
x = 0
y = 0
steps = 0
local abs = math.abs
local min = math.min
local closest = math.huge
for dir, dist in io.read():gmatch('([UDLR])(%d+)') do
  local xstep, ystep = dirs[dir][1], dirs[dir][2]
  local xdest = x + xstep * dist
  local ydest = y + ystep * dist
  while x ~= xdest or y ~= ydest do
    x = x + xstep
    y = y + ystep
    steps = steps + 1
    if wire1path[y] and wire1path[y][x] then
      closest = min(closest, steps + wire1path[y][x])
    end
  end
end
print(closest)
