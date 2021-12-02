#! /usr/bin/env lua
local floor = 0
local char = 1
local paren = io.read(1)
while paren and floor >= 0 do
  if paren == '(' then floor = floor + 1
  elseif paren == ')' then floor = floor - 1
  end
  if floor < 0 then print(char) end
  paren = io.read(1)
  char = char + 1
end
