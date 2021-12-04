#! /usr/bin/env lua
local total = 0
local function nice(s)
  local double = not not s:match('(%a%a).*%1')
  local rep = not not s:match('(%a).%1')
  return double and rep
end
for line in io.lines() do
  if nice(line) then total = total + 1 end
end
print(total)
