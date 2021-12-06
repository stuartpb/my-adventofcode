#! /usr/bin/env lua
local min = math.min
local max = math.max
local visits = {}
local overlaps = 0
for line in io.lines() do
  local x1, y1, x2, y2 = line:match('(%d+),(%d+) %-> (%d+),(%d+)')
  x1 = tonumber(x1)
  y1 = tonumber(y1)
  x2 = tonumber(x2)
  y2 = tonumber(y2)
  if x1 == x2 or y1 == y2 then
    x1, x2 = min(x1, x2), max(x1, x2)
    y1, y2 = min(y1, y2), max(y1, y2)
    for y = y1, y2 do
      local row = visits[y]
      if not row then
        row = {}
        visits[y] = row
      end
      for x = x1, x2 do
        local prior = row[x]
        if prior then
          if prior == 1 then overlaps = overlaps + 1 end
          row[x] = prior + 1
        else row[x] = 1 end
      end
    end
  end
end
print(overlaps)
