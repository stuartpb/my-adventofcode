#! /usr/bin/env lua
local orbits = {}
for line in io.lines() do
  local center, orbiter = line:match'(%w+)%)(%w+)'
  orbits[orbiter] = center
end
local tocom = {}
local dist = 0
local center = orbits.YOU
while center do
  tocom[center] = dist
  dist = dist + 1
  center = orbits[center]
end
dist = 0
center = orbits.SAN
while not tocom[center] do
  dist = dist + 1
  center = orbits[center]
end
print(dist + tocom[center])
