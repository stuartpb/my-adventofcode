#! /usr/bin/env lua
local reg = {a=0, b=0, c=0, d=0}
local ops = {}
for line in io.lines() do
  local op = {line:match'^(%a+) (%S+) ?(%S*)$'}
  ops[#ops+1] = op
end
local pos = 1
while ops[pos] do
  local op = ops[pos]
  local instruction = op[1]
  local x = op[2]
  local y = op[3]
  if instruction == 'cpy' then
    local val = tonumber(x)
    reg[y] = val and val or reg[x]
  elseif instruction == 'inc' then
    reg[x] = reg[x] + 1
  elseif instruction == 'dec' then
    reg[x] = reg[x] - 1
  end
  if instruction == 'jnz' and reg[x] ~= 0 then
    pos = pos + tonumber(y)
  else
    pos = pos + 1
  end
end
print(reg.a)
