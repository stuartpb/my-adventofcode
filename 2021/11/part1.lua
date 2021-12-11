#! /usr/bin/env lua
local grid = {}
local min = math.min
local function flashat(x,y)
  local above = grid[y-1] or {}
  local below = grid[y+1] or {}
  local row = grid[y]
  if (above[x-1] or 0) > 0 then above[x-1] = min(9, above[x-1] + 1) end
  if (above[x] or 0) > 0 then above[x] = min(9, above[x] + 1) end
  if (above[x+1] or 0) > 0 then above[x+1] = min(9, above[x+1] + 1) end
  if (row[x-1] or 0) > 0 then row[x-1] = min(9, row[x-1] + 1) end
  if (row[x+1] or 0) > 0 then row[x+1] = min(9, row[x+1] + 1) end
  if (below[x-1] or 0) > 0 then below[x-1] = min(9, below[x-1] + 1) end
  if (below[x] or 0) > 0 then below[x] = min(9, below[x] + 1) end
  if (below[x+1] or 0) > 0 then below[x+1] = min(9, below[x+1] + 1) end
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
  print(('!'):rep(#grid[1]),step)
  for y, row in pairs(grid) do
    print(table.concat(row))
    for x, here in pairs(row) do
      if here < 9 then row[x] = here + 1
      else flashing = true end
    end
  end
  while flashing do
    flashing = nil
    print(('*'):rep(#grid[1]),step)
    for y, row in pairs(grid) do
      print(table.concat(row))
      for x, here in pairs(row) do
        if here == 9 then 
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
