#! /usr/bin/env lua
local current = {}
local upcoming = {}
for line in io.lines() do
  local row = {}
  current[#current+1] = row
  for i, c in line:gmatch'()(.)' do
    row[i] = c
  end
  upcoming[#current] = {table.unpack(row)}
end
local function bysitters(x,y)
  local rays = {
    [{-1,-1}] = true,
    [{ 0,-1}] = true,
    [{ 1,-1}] = true,
    [{-1, 0}] = true,
    [{ 1, 0}] = true,
    [{-1, 1}] = true,
    [{ 0, 1}] = true,
    [{ 1, 1}] = true,
  }
  local count = 0
  local i = 1
  while next(rays) do
    for ray in pairs(rays) do
      local row = current[y+ray[2]*i]
      local spot = row and row[x+ray[1]*i]
      if spot ~= '.' then
        if spot == '#' then count = count + 1 end
        rays[ray] = nil
      end
    end
    i = i + 1
  end
  return count
end
local live = true
while live do
  live = nil
  for y, row in pairs(current) do
    for x, here in pairs(row) do
      if here == 'L' and bysitters(x,y) == 0 then
        live = true
        upcoming[y][x] = '#'
      elseif here == '#' and bysitters(x,y) >= 5 then
        live = true
        upcoming[y][x] = 'L'
      else
        upcoming[y][x] = here
      end
    end
  end
  current, upcoming = upcoming, current
end
local occupied = 0
for y, row in pairs(current) do
  for x, here in pairs(row) do
    if here == '#' then
      occupied = occupied + 1
    end
  end
end
print(occupied)
