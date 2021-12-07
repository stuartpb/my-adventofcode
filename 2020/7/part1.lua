#! /usr/bin/env lua
local inward = {}
local outward = {}
for line in io.lines() do
  local container, content = line:match'^(.+) bags contain (.+)%.$'
  local inside = {}
  inward[container] = inside
  if content ~= 'no other bags' then
    for number, contained in (content):gmatch'(%d+) (.-) bag' do
      inside[contained] = tonumber(number)
      local outside = outward[contained]
      if not outside then
        outside = {}
        outward[contained] = outside
      end
      outside[container] = inside
    end
  end
end
function totalcontaining(type, counted)
  local total = 0
  local outside = outward[type]
  if outside then for container in pairs(outside) do
    if not counted[container] then
      counted[container] = true
      total = total + 1 + totalcontaining(container, counted)
    end
  end end
  return total
end
print(totalcontaining('shiny gold', {}))
