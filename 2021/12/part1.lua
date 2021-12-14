#! /usr/bin/env lua
local graph = {}
for line in io.lines() do
  local a, b = line:match'(%a+)%-(%a+)'
  local ga = graph[a] or {}
  graph[a] = ga
  ga[b] = true
  local gb = graph[b] or {}
  graph[b] = gb
  gb[a] = true
end
local function paths(node, previous)
  local total = 0
  for dest in pairs(graph[node]) do
    if dest == 'end' then total = total + 1
    elseif dest:match'%u' or not previous:match(dest) then
      total = total + paths(dest, previous .. ',' .. dest)
    end
  end
  return total
end
print(paths('start','start'))
