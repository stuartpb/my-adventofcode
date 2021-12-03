#! /usr/bin/env lua
local sum = 0
local max = math.max
local min = math.min
for line in io.lines() do
  local large = 0
  local small = math.huge
  for num in line:gmatch('%d+') do
    num = tonumber(num)
    large = max(large, num)
    small = min(small, num)
  end
  sum = sum + large - small
end
print(sum)
