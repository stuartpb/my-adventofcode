#! /usr/bin/env lua
local total = 0
local list = {}
local next = io.read(1)
while next and next:match('%d') do
  list[#list+1] = tonumber(next)
  next = io.read(1)
end
local half = #list / 2
for i = 1, #list do
  if list[i] == list[(i + half) % #list] then total = total + list[i] end
end
print(total)
