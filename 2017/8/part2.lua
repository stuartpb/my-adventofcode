#! /usr/bin/env lua
local registers = {}
local pattern = '^(%a+) (...) (%-?%d+) if (%a+) (%S+) (%-?%d+)$'
local max = 0
for line in io.lines() do
  local reg, op, arg, test, cmp, val = line:match(pattern)
  arg = tonumber(arg)
  if op == 'dec' then arg = -arg end
  val = tonumber(val)
  local testval = registers[test] or 0
  local pass
  if cmp == '==' then pass = testval == val
  elseif cmp == '!=' then pass = testval ~= val
  elseif cmp == '<=' then pass = testval <= val
  elseif cmp == '>=' then pass = testval >= val
  elseif cmp == '<' then pass = testval < val
  elseif cmp == '>' then pass = testval > val
  end
  if pass then
    local newval = (registers[reg] or 0) + arg
    if newval > max then max = newval end
    registers[reg] = newval
  end
end
print(max)
