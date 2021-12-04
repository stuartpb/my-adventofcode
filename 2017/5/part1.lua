#! /usr/bin/env lua
local list = {}
for line in io.lines() do
  list[#list+1] = tonumber(line)
end
local pos = 1
local step = 0
while pos > 0 and pos <= #list do
  step = step + 1
  pos, list[pos] = pos + list[pos], list[pos] + 1
end
print(step)
