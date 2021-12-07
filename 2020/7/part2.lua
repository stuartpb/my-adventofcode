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
function totalcontained(type, memo)
  if memo[type] then return memo[type] end
  local total = 0
  local inside = inward[type]
  if inside then for container, number in pairs(inside) do
    total = total + number * (totalcontained(container, memo) + 1)
  end end
  memo[type] = total
  return total
end
print(totalcontained('shiny gold', {}))
