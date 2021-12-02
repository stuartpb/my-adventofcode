#! /usr/bin/env lua
local total = 0
local max = math.max
for line in io.lines() do
  local l, w, h = line:match'(%d+)x(%d+)x(%d+)'
  l = tonumber(l)
  w = tonumber(w)
  h = tonumber(h)
  total = total + l*w*h + l*2 + w*2 + h*2 - max(l,w,h)*2
end
print(total)
