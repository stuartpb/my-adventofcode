#! /usr/bin/env lua
local instructions = {}
for line in io.lines() do
  local op, arg = line:match'(...) ([+-]%d+)'
  instructions[#instructions+1] = {op, tonumber(arg)}
end
local visited = {}
local acc = 0
local pos = 1
while not visited[pos] do
  visited[pos] = true
  local instruction = instructions[pos]
  if instruction[1] == 'jmp' then
    pos = pos + instruction[2]
  else
    if instruction[1] == 'acc' then
      acc = acc + instruction[2]
    end
    pos = pos + 1
  end
end
print(acc)
