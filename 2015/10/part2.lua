#! /usr/bin/env lua
local sequence = io.read()
for i = 1, 50 do
  local buffer = {}
  local pos = 1
  while pos <= #sequence do
    local char = sequence:sub(pos, pos)
    local span = #sequence:match(char..'+', pos)
    buffer[#buffer+1] = span .. char
    pos = pos + span
  end
  sequence = table.concat(buffer)
end
print(#sequence)
