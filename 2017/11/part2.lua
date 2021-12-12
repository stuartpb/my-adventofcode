#! /usr/bin/env lua
local steps = {
  n  = { 0, 1,-1},
  ne = { 1, 0,-1},
  se = { 1,-1, 0},
  s  = { 0,-1, 1},
  sw = {-1, 0, 1},
  nw = {-1, 1, 0}
}
local abs = math.abs
local farthest = 0
local child = {0, 0, 0}
for dir in io.read():gmatch'%a+' do
  for d = 1, 3 do
    child[d] = child[d] + steps[dir][d]
  end
  farthest = math.max(farthest,
    (abs(child[1]) + abs(child[2]) + abs(child[3])) // 2)
end
print(farthest)
