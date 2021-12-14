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
local function paths(node, previous, double)
  local total = 0
  for dest in pairs(graph[node]) do
    local double = double
    local visited = dest:match'%l' and previous:match(dest)
    if dest == 'start' then visited = 'start'
    elseif visited and not double then
      double = visited
      visited = nil
    end
    if dest == 'end' then total = total + 1
    elseif not visited then
      total = total + paths(dest, previous .. ',' .. dest, double)
    end
  end
  return total
end
print(paths('start',''))
