#! /usr/bin/env lua
local connections = {}
for line in io.lines() do
  local src, dests = line:match'(%d+) <%-> (.*)$'
  local list = {}
  for dest in dests:gmatch'%d+' do
    list[#list+1] = tonumber(dest)
  end
  connections[tonumber(src)] = list
end
local seen = {}
local count = 0
local function traverse(i)
  seen[i] = count
  count = count + 1
  for k, dest in pairs(connections[i]) do
    if not seen[dest] then traverse(dest) end
  end
end
traverse(0)
print(count)
