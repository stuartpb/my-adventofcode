#! /usr/bin/env lua
local size = 0
local char = io.read(1)
while char do
  if char == '\n' then
    char = io.read(1)
  elseif char == '(' then
    local spec = {}
    char = io.read(1)
    while char ~= ')' do
      spec[#spec+1] = char
      char = io.read(1)
    end
    local span, times = table.concat(spec):match'(%d+)x(%d+)'
    span = tonumber(span)
    times = tonumber(times)
    io.read(span)
    size = size + span * times
    char = io.read(1)
  else
    size = size + 1
    char = io.read(1)
  end
end
print(size)
