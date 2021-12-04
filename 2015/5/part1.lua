#! /usr/bin/env lua
local total = 0
local function nice(s)
  local _, vowels = s:gsub('[aeiou]',{})
  local double = not not s:match('(%a)%1')
  local naughty = s:match'ab' or s:match'cd' or s:match'pq' or s:match'xy'
  return vowels >= 3 and double and not naughty 
end
for line in io.lines() do
  if nice(line) then total = total + 1 end
end
print(total)
