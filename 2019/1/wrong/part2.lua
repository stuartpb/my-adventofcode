#! /usr/bin/env lua
local sum = 0
for line in io.lines() do
  sum = sum + tonumber(line) // 3 - 2
end
-- XXX: each module's extra should be calculated individually
local extra = sum
while extra > 0 do
  extra = extra // 3 - 2
  if extra < 0 then extra = 0 end
  sum = sum + extra
end
print(sum)
