#! /usr/bin/env lua
local floor = 0
local paren = io.read(1)
while paren do
  if paren == '(' then floor = floor + 1
  elseif paren == ')' then floor = floor - 1
  end
  paren = io.read(1)
end
print(floor)
