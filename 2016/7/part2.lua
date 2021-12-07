#! /usr/bin/env lua
local function supportsSSL(ip)
  local inner = {}
  local outer = ip:gsub('%b[]', function(s)
    inner[#inner+1] = s
  return ' ' end)
  inner = table.concat(inner)
  local a, start, b = outer:match'(.)()(.)%1'
  while a do
    if a ~= b and inner:match(b..a..b) then return true end
    a, start, b = outer:match('(.)()(.)%1', start)
  end
  return false
end

local total = 0
for line in io.lines() do
  if supportsSSL(line) then total = total + 1 end
end
print(total)
