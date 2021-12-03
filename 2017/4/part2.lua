#! /usr/bin/env lua
local valid = 0
for line in io.lines() do
  local seen = {}
  for word in line:gmatch'%a+' do
    local letters = {}
    for i = 1, #word do
      letters[i] = word:sub(i, i)
    end
    table.sort(letters)
    word = table.concat(letters)
    if seen[word] then goto nextline
    else seen[word] = true end
  end
  valid = valid + 1
  ::nextline::
end
print(valid)
