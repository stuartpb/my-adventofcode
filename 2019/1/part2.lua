#! /usr/bin/env lua
local sum = 0
for line in io.lines() do
  local mass = tonumber(line) // 3 - 2
  while mass > 0 do
    sum = sum + mass
    mass = mass // 3 - 2
  end
end
print(sum)
