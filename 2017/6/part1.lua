#! /usr/bin/env lua
local seen = {}
local line = io.read()
local banks = {}
for num in line:gmatch('%d+') do
  banks[#banks+1] = tonumber(num)
end
local cycle = 0
local bankser = table.concat(banks,' ')
while not seen[bankser] do
  seen[bankser] = true
  local most = 0
  local pos = 1
  for i = 1, #banks do
    if banks[i] > most then
      most = banks[i]
      pos = i
    end
  end
  banks[pos] = 0
  while most > 0 do
    pos = pos + 1
    if pos > #banks then pos = 1 end
    banks[pos] = banks[pos] + 1
    most = most - 1
  end
  bankser = table.concat(banks,' ')
  cycle = cycle + 1
end
print(cycle)
