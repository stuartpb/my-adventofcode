#! /usr/bin/env lua
local total = 0
local min = math.min
for line in io.lines() do
  local vallen = #line - 2
  for esc in line:gmatch'\\(.)' do
    vallen = vallen - (esc == 'x' and 3 or 1)
  end
  total = total + #line - vallen
end
print(total)
