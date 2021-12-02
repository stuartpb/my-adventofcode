#! /usr/bin/env lua
local increases = 0
local a = tonumber(io.read())
local b = tonumber(io.read())
local c = tonumber(io.read())
for line in io.lines() do
  local d = tonumber(line)
  if a + b + c < b + c + d then
    increases = increases + 1
  end
  a, b, c = b, c, d
end
print(increases)
