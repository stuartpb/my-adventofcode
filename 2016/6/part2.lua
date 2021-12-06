#! /usr/bin/env lua
local function minkey(t)
  local keys = {}
  local mink = next(t)
  local minv = t[mink]
  for k, v in pairs(t) do
    if v < minv then
      mink = k
      minv = v
    end
  end
  return mink
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
  counts[i] = minkey(counts[i])
end
print(table.concat(counts))
