#! /usr/bin/env lua
local sum2 = 0
local sum3 = 0
for line in io.lines() do
  local counts = {}
  local has2 = 0
  local has3 = 0
  for char in line:gmatch('%a') do
    local count = counts[char] or 0
    if count == 1 then
      has2 = has2 + 1
    elseif count == 2 then
      has2 = has2 - 1
      has3 = has3 + 1
    elseif count == 3 then
      has3 = has3 - 1
    end
    counts[char] = count + 1
  end
  if has2 > 0 then sum2 = sum2 + 1 end
  if has3 > 0 then sum3 = sum3 + 1 end
end
print(sum2 * sum3)
