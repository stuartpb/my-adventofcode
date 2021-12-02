#! /usr/bin/env lua
local pad = {
  {nil,nil,'1'},
  {nil,'2','3','4'},
  {'5','6','7','8','9'},
  {nil,'A','B','C'},
  {nil,nil,'D'}
}
local steps = {U = {0, -1}, D = {0, 1}, L = {-1, 0}, R = {1, 0}}
for line in io.lines() do
  local x, y = 1, 3
  for udlr in line:gmatch('[UDLR]') do
    local xstep, ystep = steps[udlr][1], steps[udlr][2]
    if (pad[y + ystep] or {})[x + xstep] then
      x = x + xstep
      y = y + ystep
    end
  end
  io.write(pad[y][x])
end
io.write'\n'
