#! /usr/bin/env lua
local crabs = {}
local abs = math.abs
local min = math.min
for code in io.read('a'):gmatch('%d+') do
  crabs[#crabs + 1] = tonumber(code)
end
pos = 0
local cheapest = math.huge
for dest = 1, #crabs do
  local fuel = 0
  for i, pos in pairs(crabs) do
    fuel = fuel + abs(pos - dest)
  end
  cheapest = min(cheapest, fuel)
end
print(cheapest)
