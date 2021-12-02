#! /usr/bin/env lua
local freq = 0
for line in io.lines() do
  freq = freq + tonumber(line)
end
print(freq)
