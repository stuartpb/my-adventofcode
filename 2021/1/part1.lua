#! /usr/bin/env lua
local last
local increases = 0
for line in io.lines() do
  local num = tonumber(line)
  if last and last < num then
    increases = increases + 1
  end
  last = num
end
print(increases)
