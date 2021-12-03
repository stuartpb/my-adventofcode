#! /usr/bin/env lua
local function isvalid(name, checksum)
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
  return table.concat(letters):sub(1,5) == checksum
end
local alphabet = {}
local pos = {}
local a = ('a'):byte()
for i = 0, 25 do
  letter = string.char(a+i)
  alphabet[i] = letter
  pos[letter] = i
end
local function shift(str, rot)
  local function shiftchar(char)
    return alphabet[(pos[char] + rot) % 26]
  end
  return (str:gsub('%-',' '):gsub('%a',shiftchar))
end
for line in io.lines() do
  local name, id, checksum = line:match'([%a%-]+)%-(%d+)%[(%a+)%]'
  if isvalid(name, checksum) then
    local rot = tonumber(id) % 26
    print(id, shift(name, rot))
  end
end
