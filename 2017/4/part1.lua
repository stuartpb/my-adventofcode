#! /usr/bin/env lua
local valid = 0
for line in io.lines() do
  local seen = {}
  for word in line:gmatch'%a+' do
    if seen[word] then goto nextline
    else seen[word] = true end
  end
  valid = valid + 1
  ::nextline::
end
print(valid)
