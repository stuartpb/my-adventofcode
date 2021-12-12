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
  local above = current[y-1] or {}
  local below = current[y+1] or {}
  local row = current[y]
  return (above[x-1] == '#' and 1 or 0) +
    (above[x] == '#' and 1 or 0) +
    (above[x+1] == '#' and 1 or 0) +
    (row[x-1] == '#' and 1 or 0) +
    (row[x+1] == '#' and 1 or 0) +
    (below[x-1] == '#' and 1 or 0) +
    (below[x] == '#' and 1 or 0) +
    (below[x+1] == '#' and 1 or 0)
end
local live = true
while live do
  live = nil
  for y, row in pairs(current) do
    for x, here in pairs(row) do
      if here == 'L' and bysitters(x,y) == 0 then
        live = true
        upcoming[y][x] = '#'
      elseif here == '#' and bysitters(x,y) >= 4 then
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
