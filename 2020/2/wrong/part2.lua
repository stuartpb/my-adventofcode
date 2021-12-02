#! /usr/bin/env lua
local valid = 0
for line in io.lines() do
  local least, most, char, password =
    line:match('(%d+)%-(%d+) (%a): (%a+)')
  least = tonumber(least)
  most = tonumber(most)
  local count = 0
  -- XXX: positions are just the extents, not the range
  for i = least, most do
    if password:sub(i,i) == char then
      if count == 0 then
        count = 1
      else
        count = 2
        break
      end
    end
  end
  if count == 1 then
    valid = valid + 1
  end
end
print(valid)
