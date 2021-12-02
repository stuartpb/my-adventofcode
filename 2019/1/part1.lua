#! /usr/bin/env lua
local sum = 0
for line in io.lines() do
  sum = sum + tonumber(line) // 3 - 2
end
print(sum)
