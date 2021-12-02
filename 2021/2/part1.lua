#! /usr/bin/env lua
local horiz = 0
local depth = 0
for line in io.lines() do
  local command, dist = line:match'(%w+) (%d+)'
  dist = tonumber(dist)
  if command == 'forward' then
    horiz = horiz + dist
  elseif command == 'down' then
    depth = depth + dist
  elseif command == 'up' then
    depth = depth - dist
  end
end
print(horiz * depth)
