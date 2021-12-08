#! /usr/bin/env lua
local registers = {}
local pattern = '^(%a+) (...) (%-?%d+) if (%a+) (%S+) (%-?%d+)$'
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
    registers[reg] = (registers[reg] or 0) + arg
  end
end
local max = 0
for reg, val in pairs(registers) do
  if val > max then max = val end
end
print(max)
