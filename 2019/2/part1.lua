#! /usr/bin/env lua
local ram = {}
local pos = 0
for code in io.read('a'):gmatch('%d+') do
  ram[pos] = tonumber(code)
  pos = pos + 1
end
ram[1] = 12
ram[2] = 2
pos = 0
while ram[pos] ~= 99 do
  if ram[pos] == 1 then
    ram[ram[pos+3]] = ram[ram[pos+1]] + ram[ram[pos+2]]
  elseif ram[pos] == 2 then
    ram[ram[pos+3]] = ram[ram[pos+1]] * ram[ram[pos+2]]
  end
  pos = pos + 4
end
print(ram[0])
