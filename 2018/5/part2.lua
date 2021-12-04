#! /usr/bin/env lua
local lower = string.lower
local stacks = {['']={}}
local unit = io.read(1)
while unit and unit:match'%a' do
  local lowerunit = lower(unit)
  local unstack = stacks[lowerunit]
  if not unstack then
    unstack = {table.unpack(stacks[''])}
    stacks[lowerunit] = unstack
  end
  for _, stack in pairs(stacks) do
    if stack == unstack then goto continue end
    if #stack == 0 or stack[#stack] == unit
      or lower(stack[#stack]) ~= lowerunit then
      stack[#stack+1] = unit
    else
      stack[#stack] = nil
    end
    ::continue::
  end
  unit = io.read(1)
end
local function minlen(t)
  local lengths = {}
  for k, v in pairs(t) do
    lengths[#lengths+1] = #v
  end
  return math.min(table.unpack(lengths))
end
print(minlen(stacks))
