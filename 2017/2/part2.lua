#! /usr/bin/env lua
local sum = 0
for line in io.lines() do
  local row = {}
  for num in line:gmatch('%d+') do
    row[#row+1] = tonumber(num)
  end
  table.sort(row)
  for left = 1, #row do
    for right = left + 1, #row do
      if row[right] % row[left] == 0 then
        sum = sum + row[right] // row[left]
        goto endrow
      end
    end
  end
  ::endrow::
end
print(sum)
