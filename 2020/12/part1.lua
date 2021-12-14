#! /usr/bin/env lua
local dir = 1
local x, y = 0, 0
local abs = math.abs
for line in io.lines() do
  local action, value = line:match'(%u)(%d+)'
  value = tonumber(value)
  if action == 'F' then
    if dir == 0 then y = y + value
    elseif dir == 1 then x = x + value
    elseif dir == 2 then y = y - value
    elseif dir == 3 then x = x - value end
  elseif action == 'N' then y = y + value
  elseif action == 'E' then x = x + value
  elseif action == 'S' then y = y - value
  elseif action == 'W' then x = x - value
  elseif action == 'L' then dir = (dir - value // 90) % 4
  elseif action == 'R' then dir = (dir + value // 90) % 4 end
end
print(abs(x) + abs(y))
