#! /usr/bin/env lua
local answered = {}
local group = 0
local total = 0
local function finishgroup()
  total = total + group
  group = 0
  answered = {}
end
for line in io.lines() do
  if line == '' then finishgroup()
  else
    for i = 1, #line do
      local char = line:sub(i,i)
      if not answered[char] then
        answered[char] = true
        group = group + 1
      end
    end
  end
end
finishgroup()
print(total)
