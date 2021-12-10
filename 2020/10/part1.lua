#! /usr/bin/env lua
local adapters = {}
for line in io.lines() do
  adapters[#adapters+1] = tonumber(line)
end
table.sort(adapters)
local diff1s = 0
local diff3s = 1 -- for the implicit last difference
local prev = 0
for i, joltage in ipairs(adapters) do
  local diff = joltage - prev
  if diff == 1 then diff1s = diff1s + 1
  elseif diff == 3 then diff3s = diff3s + 1 end
  prev = joltage
end
print(diff1s * diff3s)
