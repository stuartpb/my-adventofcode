#! /usr/bin/env lua
local ends = {
  ['('] = ')',
  ['['] = ']',
  ['{'] = '}',
  ['<'] = '>',
}
local points = {
  [')'] = 3,
  [']'] = 57,
  ['}'] = 1197,
  ['>'] = 25137,
}

local score = 0
for line in io.lines() do
  local stack = {}
  for char in line:gmatch('.') do
    if ends[char] then
      stack[#stack+1] = char
    elseif char ~= ends[stack[#stack]] then
      score = score + points[char]
      break
    else
      stack[#stack] = nil
    end
  end
end
print(score)
