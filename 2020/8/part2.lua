#! /usr/bin/env lua
local instructions = {}
for line in io.lines() do
  local op, arg = line:match'(...) ([+-]%d+)'
  instructions[#instructions+1] = {op, tonumber(arg)}
end
local visited = {}
local ok = {}
local checking
local acc = 0
local pos = 1
while pos <= #instructions do
  if visited[pos] then
    visited = {}
    ok[checking] = true
    checking = nil
    acc = 0 
    pos = 1
  end
  visited[pos] = true

  local instruction = instructions[pos]
  local op = instruction[1]
  local arg = instruction[2]
  local checkable = op == 'jmp' or op == 'nop'
  if checkable and not checking and not ok[pos] then
    checking = pos
    op = op == 'nop' and 'jmp' or 'nop'
  end
  if op == 'jmp' then
    pos = pos + arg
  else
    if op == 'acc' then
      acc = acc + arg
    end
    pos = pos + 1
  end
end
print(acc)
