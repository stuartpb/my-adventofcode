#! /usr/bin/env lua
local weights = {}
local upfrom = {}
local downfrom = {}
for line in io.lines() do
  local name, weight = line:match'^(%w+) %((%d+)%)'
  weights[name] = weight
  local above = line:match'%->.*$'
  if above then
    local disc = {}
    upfrom[name] = disc
    for topper in above:gmatch'%w+' do
      downfrom[topper] = name
      disc[#disc+1] = topper
    end
  end
end
for name, weight in pairs(weights) do
  if not downfrom[name] then print(name) end
end
