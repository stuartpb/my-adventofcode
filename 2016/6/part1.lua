#! /usr/bin/env lua
local function maxkey(t)
  local keys = {}
  local maxk = next(t)
  local maxv = t[maxk]
  for k, v in pairs(t) do
    if v > maxv then
      maxk = k
      maxv = v
    end
  end
  return maxk
end
local counts = {}
for i = 1, 8 do
  counts[i] = {}
end
for line in io.lines() do
  for i = 1, 8 do
    local letter = line:sub(i,i)
    counts[i][letter] = (counts[i][letter] or 0) + 1
  end
end
for i = 1, 8 do
  counts[i] = maxkey(counts[i])
end
print(table.concat(counts))
