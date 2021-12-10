#! /usr/bin/env lua
local ends = {
  ['('] = ')',
  ['['] = ']',
  ['{'] = '}',
  ['<'] = '>',
}
local points = {
  [')'] = 1,
  [']'] = 2,
  ['}'] = 3,
  ['>'] = 4,
}

local scores = {}
for line in io.lines() do
  local stack = {}
  for char in line:gmatch('.') do
    if ends[char] then
      stack[#stack+1] = char
    elseif char ~= ends[stack[#stack]] then
      stack = {}
      break
    else
      stack[#stack] = nil
    end
  end
  if #stack > 0 then
    local score = 0
    for i = #stack, 1, -1 do
      score = score * 5 + points[ends[stack[i]]]
    end
    scores[#scores+1] = score
  end
end
table.sort(scores)
print(scores[#scores//2+1])
