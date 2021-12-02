#! /usr/bin/env lua
local valid = 0
for line in io.lines() do
  local least, most, char, password =
    line:match('(%d+)%-(%d+) (%a): (%a+)')
  least = tonumber(least)
  most = tonumber(most)
  local low = password:sub(least,least) == char
  local high = password:sub(most,most) == char
  if (low or high) and not (low and high) then
    valid = valid + 1
  end
end
print(valid)
