#! /usr/bin/env lua
local total = 0
local min = math.min
for line in io.lines() do
  local l, w, h = line:match'(%d+)x(%d+)x(%d+)'
  l = tonumber(l)
  w = tonumber(w)
  h = tonumber(h)
  total = total + 2*l*w + 2*w*h + 2*l*h + min(l*w, w*h, l*h)
end
print(total)
