#! /usr/bin/env lua
local x, y = 0, 0
local wx, wy = 10, 1
local abs = math.abs
for line in io.lines() do
  local action, value = line:match'(%u)(%d+)'
  value = tonumber(value)
  if action == 'F' then
    x = x + wx * value
    y = y + wy * value
  elseif action == 'N' then wy = wy + value
  elseif action == 'E' then wx = wx + value
  elseif action == 'S' then wy = wy - value
  elseif action == 'W' then wx = wx - value
  elseif action == 'L' or action == 'R' then
    if action == 'L' then value = 360 - value end
    if value == 90 then wx, wy = wy, -wx
    elseif value == 180 then wx, wy = -wx, -wy
    elseif value == 270 then wx, wy = -wy, wx end
  end
end
print(abs(x) + abs(y))
