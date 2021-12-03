#! /usr/bin/env lua
local pos = tonumber(io.read())
local mem = {[0]={[0]=1}}
local x = 0
local y = 0
local ring = 0
while pos > mem[y][x] do
  if y == ring then
    if x == ring then
      ring = ring + 1
      x = ring
    else x = x + 1 end
  elseif x == ring then
    if y == -ring then
      x = x - 1
    else y = y - 1 end
  elseif y == -ring then
    if x == -ring then
      y = y + 1
    else x = x - 1 end
  elseif x == -ring then
    if y == ring then
      x = x + 1
    else y = y + 1 end
  end
  if not mem[y] then mem[y] = {} end
  local above = mem[y-1]
  local below = mem[y+1]
  mem[y][x] = (mem[y][x-1] or 0) + (mem[y][x+1] or 0) +
    (above and ((above[x-1] or 0) + (above[x] or 0) +
      (above[x+1] or 0)) or 0) +
    (below and ((below[x-1] or 0) + (below[x] or 0) +
      (below[x+1] or 0)) or 0)
end
print(mem[y][x])
