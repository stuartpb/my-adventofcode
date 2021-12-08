#! /usr/bin/env lua
local total = 0
for line in io.lines() do
  local patterns, output = line:match'^(.+) | (.+)$'
  for digit in output:gmatch'%a+' do
    if #digit < 5 or #digit == 7 then
      total = total + 1
    end
  end
end
print(total)
