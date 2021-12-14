#! /usr/bin/env lua
local reg = {a=0, b=0, c=1, d=0}
local ops = {}
for line in io.lines() do
  local op = {line:match'^(%a+) (%S+) ?(%S*)$'}
  if op[1] == 'jnz' then op[3] = tonumber(op[3]) end
  op[2] = tonumber(op[2]) or op[2]
  ops[#ops+1] = op
end
local pos = 1
while ops[pos] do
  local op = ops[pos]
  local instruction = op[1]
  local x = op[2]
  local y = op[3]
  if instruction == 'cpy' then
    reg[y] = reg[x] or x
  elseif instruction == 'inc' then
    reg[x] = reg[x] + 1
  elseif instruction == 'dec' then
    reg[x] = reg[x] - 1
  end
  if instruction == 'jnz' and reg[x] ~= 0 then
    pos = pos + y
  else
    pos = pos + 1
  end
end
print(reg.a)
