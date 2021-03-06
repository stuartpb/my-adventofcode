#! /usr/bin/env lua
local grid = {}
local min = math.min
local function flashat(x,y)
  local above = grid[y-1] or {}
  local below = grid[y+1] or {}
  local row = grid[y]
  if (above[x-1] or 0) > 0 then above[x-1] = above[x-1] + 1 end
  if (above[x] or 0) > 0 then above[x] = above[x] + 1 end
  if (above[x+1] or 0) > 0 then above[x+1] = above[x+1] + 1 end
  if (row[x-1] or 0) > 0 then row[x-1] = row[x-1] + 1 end
  if (row[x+1] or 0) > 0 then row[x+1] = row[x+1] + 1 end
  if (below[x-1] or 0) > 0 then below[x-1] = below[x-1] + 1 end
  if (below[x] or 0) > 0 then below[x] = below[x] + 1 end
  if (below[x+1] or 0) > 0 then below[x+1] = below[x+1] + 1 end
end
for line in io.lines() do
  local row = {}
  grid[#grid+1] = row
  for i, c in line:gmatch'()(.)' do
    row[i] = tonumber(c)
  end
end
local flashes = 0
for step = 1, 100 do
  local flashing
  for y, row in pairs(grid) do
    for x, here in pairs(row) do
      row[x] = here + 1
      if here >= 9 then flashing = true end
    end
  end
  while flashing do
    flashing = nil
    for y, row in pairs(grid) do
      for x, here in pairs(row) do
        if here > 9 then 
          row[x] = 0
          flashat(x,y)
          flashes = flashes + 1
          flashing = true
        end
      end
    end
  end
end
print(flashes)
