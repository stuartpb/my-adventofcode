#! /usr/bin/env lua
local pos = tonumber(io.read())
local ring = 0
local width = 1
local first = 0
while pos > width * width do
  ring = ring + 1
  first = width * width + 1
  width = ring * 2 + 1
end
local edgepos = (pos - first) % (width - 1)
print(ring + math.abs(edgepos - ring + 1))
