#! /usr/bin/env lua
local sum = 0
for line in io.lines() do
  local name, id, checksum = line:match'([%a%-]+)%-(%d+)%[(%a+)%]'
  local counts = {}
  local letters = {}
  for letter in name:gmatch'%a' do
    if counts[letter] then counts[letter] = counts[letter] + 1
    else
      letters[#letters+1] = letter
      counts[letter] = 1
    end
  end
  table.sort(letters, function(m, n)
    return counts[m] == counts[n] and m < n or counts[m] > counts[n]
  end)
  if table.concat(letters):sub(1,5) == checksum then
    sum = sum + tonumber(id)
  end
end
print(sum)
