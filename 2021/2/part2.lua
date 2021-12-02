#! /usr/bin/env lua
local horiz = 0
local aim = 0
local depth = 0
for line in io.lines() do
  local command, dist = line:match'(%w+) (%d+)'
  dist = tonumber(dist)
  if command == 'forward' then
    horiz = horiz + dist
    depth = depth + aim * dist
  elseif command == 'down' then
    aim = aim + dist
  elseif command == 'up' then
    aim = aim - dist
  end
end
print(horiz * depth)
