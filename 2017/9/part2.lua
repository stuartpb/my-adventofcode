#! /usr/bin/env lua
local score = 0
local depth = 0
local garbage
local char = io.read(1)
while char do
  if garbage then
    while char == '!' do
      io.read(1)
      char = io.read(1)
    end
    if char == '>' then
      garbage = nil
    else
      score = score + 1
    end
  else
    if char == '{' then
      depth = depth + 1
    elseif char == '}' then
      depth = depth - 1
    elseif char == '<' then
      garbage = true
    end
  end
  char = io.read(1)
end
print(score)
