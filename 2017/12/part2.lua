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
local function traverse(i)
  local group = connections[i]
  connections[i] = nil
  for k, dest in pairs(group) do
    if connections[dest] then traverse(dest) end
  end
end
local count = 0
local entry = next(connections)
while entry do
  count = count + 1
  traverse(entry)
  entry = next(connections)
end
print(count)
