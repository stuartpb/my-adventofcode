#! /usr/bin/env lua
local sum = 0
for num in io.read():gmatch'%-?%d+' do
sum = sum + tonumber(num)
end
print(sum)
