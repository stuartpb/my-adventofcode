#! /usr/bin/env lua
local sum = 0
local function redless(s)
  local pruned = s:sub(2):gsub('%b{}', redless)
  return pruned:match':"red"' and '' or pruned
end
local json = redless(io.read())
for num in json:gmatch'%-?%d+' do
  sum = sum + tonumber(num)
end
print(sum)
