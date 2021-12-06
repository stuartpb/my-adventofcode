#! /usr/bin/env lua
local fishtotal = 0
local spawning = {[0]=0,0,0,0,0,0,0,0,0}
for cycle in io.read():gmatch'%d+' do
  cycle = tonumber(cycle)
  spawning[cycle] = spawning[cycle] + 1
  fishtotal = fishtotal + 1
end
for day = 0, 255 do
  local tospawn = 0
  for i = day, 1, -7 do
    tospawn = tospawn + spawning[i]
  end
  fishtotal = fishtotal + tospawn
  spawning[day + 9] = tospawn
end
print(fishtotal)
