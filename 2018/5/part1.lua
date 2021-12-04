#! /usr/bin/env lua
local lower = string.lower
local stack = {}
local unit = io.read(1)
while unit and unit:match'%a' do
  if #stack == 0 or stack[#stack] == unit
    or lower(stack[#stack]) ~= lower(unit) then
    stack[#stack+1] = unit
  else
    stack[#stack] = nil
  end
  unit = io.read(1)
end
print(#stack)
