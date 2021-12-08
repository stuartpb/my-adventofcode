#! /usr/bin/env lua
local total = 0
local min = math.min
for line in io.lines() do
  local vallen = #line + 2
  for esc in line:gmatch'[\\"]' do
    vallen = vallen + 1
  end
  total = total + vallen - #line
end
print(total)
