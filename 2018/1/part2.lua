#! /usr/bin/env lua
local freq = 0
local list = {}
for line in io.lines() do
  list[#list+1] = tonumber(line)
end
local prev = {}
local i = 1
while not prev[freq] do
  prev[freq] = true
  freq = freq + list[i]
  i = i < #list and i + 1 or 1
end
print(freq)
