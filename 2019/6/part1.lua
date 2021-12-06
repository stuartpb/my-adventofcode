#! /usr/bin/env lua
local orbits = {}
for line in io.lines() do
  local center, orbiter = line:match'(%w+)%)(%w+)'
  orbits[orbiter] = center
end
local sum = 0
for orbiter, center in pairs(orbits) do
  while center do
    sum = sum + 1
    center = orbits[center]
  end
end
print(sum)
