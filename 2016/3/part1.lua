#! /usr/bin/env lua
local valid = 0
for line in io.lines() do
  local a, b, c = line:match('(%d+)%s+(%d+)%s+(%d+)')
  a = tonumber(a)
  b = tonumber(b)
  c = tonumber(c)
  if a < b + c and b < a + c and c < a + b then
    valid = valid + 1
  end
end
print(valid)
