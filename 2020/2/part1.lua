#! /usr/bin/env lua
local valid = 0
for line in io.lines() do
  local least, most, char, password =
    line:match('(%d+)%-(%d+) (%a): (%a+)')
  least = tonumber(least)
  most = tonumber(most)
  local count = 0
  for c in password:gmatch(char) do
    count = count + 1
  end
  if least <= count and most >= count then
    valid = valid + 1
  end
end
print(valid)
