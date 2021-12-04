#! /usr/bin/env lua
local highest = 0
local max = math.max
local bits = {F=0,B=1,L=0,R=1}
local seated = {}
for line in io.lines() do
  local id = tonumber(line:gsub('.', bits), 2)
  highest = max(highest, id)
  seated[id] = true
end
for id = highest, 0, -1 do
  if not seated[id] and seated[id-1] and seated[id+1] then
    print(id)
    break
  end
end

