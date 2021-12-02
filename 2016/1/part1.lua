#! /usr/bin/env lua
local dir = 0
local x = 0
local y = 0
local abs = math.abs
for rot, dist in io.read('a'):gmatch('([LR])(%d+)') do
  dist = tonumber(dist)
  if rot == 'L' then dir = (dir - 1) % 4
  elseif rot == 'R' then dir = (dir + 1) % 4 end
  if dir == 0 then y = y + dist
  elseif dir == 1 then x = x + dist
  elseif dir == 2 then y = y - dist
  elseif dir == 3 then x = x - dist end
end
print(abs(x) + abs(y))
