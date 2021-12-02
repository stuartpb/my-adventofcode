#! /usr/bin/env lua
local dir = 0
local x = 0
local y = 0
local abs = math.abs
local visits = {}
local steps = {[0] = {0, 1}, {1, 0}, {0, -1}, {-1, 0}}
for rot, dist in io.read('a'):gmatch('([LR])(%d+)') do
  dist = tonumber(dist)
  if rot == 'L' then dir = (dir - 1) % 4
  elseif rot == 'R' then dir = (dir + 1) % 4 end
  local xstep, ystep = steps[dir][1], steps[dir][2]
  local xdest = x + xstep * dist
  local ydest = y + ystep * dist
  while x ~= xdest or y ~= ydest do
    if not visits[y] then visits[y] = {} end
    if visits[y][x] then
      print(abs(x) + abs(y))
      goto done
    else visits[y][x] = true end
    x = x + xstep
    y = y + ystep
  end
end
::done::
