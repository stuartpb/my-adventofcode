#! /usr/bin/env lua
local counts = {}
for i = 1, 12 do
  counts[i] = {['1'] = 0, ['0'] = 0}
end
for line in io.lines() do
  for i = 1, 12 do
    local digit = line:sub(i,i)
    counts[i][digit] = counts[i][digit] + 1
  end
end
local gamma = {}
local epsilon = {}
for i = 1, 12 do
  if counts[i]['0'] < counts[i]['1'] then
    gamma[i] = '0'
    epsilon[i] = '1'
  else
    gamma[i] = '1'
    epsilon[i] = '0'
  end
end
gamma = tonumber(table.concat(gamma), 2)
epsilon = tonumber(table.concat(epsilon), 2)
print(gamma * epsilon)
