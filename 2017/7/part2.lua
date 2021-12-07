#! /usr/bin/env lua
local weights = {}
local upfrom = {}
local downfrom = {}
for line in io.lines() do
  local name, weight = line:match'^(%w+) %((%d+)%)'
  weights[name] = tonumber(weight)
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
local bottom
for name, weight in pairs(weights) do
  if not downfrom[name] then bottom = name end
end
local function totalweight(name)
  local total = weights[name]
  local toppers = upfrom[name]
  if toppers then for i, topper in pairs(toppers) do
    total = total + totalweight(topper)
  end end
  return total
end
local function imbalancer(name)
  local toppers = upfrom[name]
  if not toppers then return name
  elseif #toppers == 1 then return imbalancer(toppers[1])
  else
    local weight1 = totalweight(toppers[1])
    local weight2 = totalweight(toppers[2])
    if weight1 == weight2 then
      for i = 3, #toppers do
        if totalweight(toppers[i]) ~= weight1 then
          return imbalancer(toppers[i])
        end
      end
      return name
    elseif #toppers == 2 then
      local softblame = imbalancer(toppers[1])
      if softblame == toppers[1] then return imbalancer(toppers[2])
      else return softblame end
    else
      local weight3 = totalweight(toppers[3])
      if weight1 == weight3 then return imbalancer(toppers[2])
      else return imbalancer(toppers[1]) end
    end
  end
end
local blame = imbalancer(bottom)
local blameholder = downfrom[blame]
local neighbors = #upfrom[blameholder] - 1
local badweight = totalweight(blame)
local aboveweight = badweight - weights[blame]
local neighborweight = totalweight(blameholder)
  - weights[blameholder] - badweight
local ideal = neighborweight // neighbors
print(ideal - aboveweight)
