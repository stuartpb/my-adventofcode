#! /usr/bin/env lua
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
  local xstep = x1 == x2 and 0 or x1 > x2 and -1 or 1
  local ystep = y1 == y2 and 0 or y1 > y2 and -1 or 1
  local last = max(abs(x1 - x2), abs(y1 - y2))
  for i = 0, last do
    local x = x1 + i * xstep
    local y = y1 + i * ystep
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
