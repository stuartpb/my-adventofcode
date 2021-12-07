#! /usr/bin/env lua
local function hasABBA(s)
  for a, b in s:gmatch'(.)(.)%2%1' do
    if a ~= b then return true end
  end
  return false
end

local function supportsTLS(ip)
  local innerABBA
  local outer = ip:gsub('%b[]', function(inner)
    if hasABBA(inner) then innerABBA = true end
    return ' '
  end)
  if innerABBA then return false end
  return hasABBA(outer)
end

local total = 0
for line in io.lines() do
  if supportsTLS(line) then total = total + 1 end
end
print(total)
