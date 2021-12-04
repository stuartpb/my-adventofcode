#! /usr/bin/env lua
local highest = 0
local max = math.max
local bits = {F=0,B=1,L=0,R=1}
for line in io.lines() do
  highest = max(highest, tonumber(line:gsub('.',bits),2))
end
print(highest)
