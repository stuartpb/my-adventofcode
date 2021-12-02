#! /usr/bin/env lua
for line in io.lines() do
  local digit = 5
  for udlr in line:gmatch('[UDLR]') do
    if udlr == 'U' and digit > 3 then digit = digit - 3
    elseif udlr == 'D' and digit < 7 then digit = digit + 3
    elseif udlr == 'L' and digit % 3 ~= 1 then digit = digit - 1
    elseif udlr == 'R' and digit % 3 ~= 0 then digit = digit + 1 end
  end
  io.write(digit)
end
io.write'\n'
