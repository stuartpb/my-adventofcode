#! /usr/bin/env lua
local min = math.min
local max = math.max
local abs = math.abs
local visits = {}
local overlaps = 0
for line in io.lines() do
  local x1, y1, x2, y2 = line:match('(%d+),(%d+) %-> (%d+),(%d+)')
  x1 = tonumber(x1)
  y1 = tonumber(y1)
  x2 = tonumber(x2)
  y2 = tonumber(y2)
  -- XXX: this causes left-low diagonal lines to be flipped
  x1, x2 = min(x1, x2), max(x1, x2)
  y1, y2 = min(y1, y2), max(y1, y2)
  local vert = x1 == x2
  local horiz = y1 == y2
  local length = vert and y2 - y1 or x2 - x1
  for offset = 0, length do
    local y = horiz and y1 or y1 + offset
    local x = vert and x1 or x1 + offset
    local row = visits[y]
    if not row then
      row = {}
      visits[y] = row
    end
    local prior = row[x]
    if prior then
      if prior == 1 then overlaps = overlaps + 1 end
      row[x] = prior + 1
    else row[x] = 1 end
  end
end
print(overlaps)
for y = 0,9 do
  local row = visits[y] or {}
  local prow = {}
  for x = 0,9 do
    prow[x+1] = row[x] or '.'
  end
  print(table.concat(prow))
end
