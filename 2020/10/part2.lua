#! /usr/bin/env lua
local adapters = {}
for line in io.lines() do
  adapters[#adapters+1] = tonumber(line)
end
table.sort(adapters)
local pathcounts = {}
for i, joltage in ipairs(adapters) do
  local pathcount = 0
  local prior = i - 1
  while prior > 0 and joltage - adapters[prior] <= 3 do
    pathcount = pathcount + pathcounts[prior] 
    prior = prior - 1
  end
  if prior == 0 then pathcount = pathcount + 1 end
  pathcounts[i] = pathcount
end
print(pathcounts[#adapters])
