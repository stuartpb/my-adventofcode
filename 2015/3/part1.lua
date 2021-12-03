#! /usr/bin/env lua
local steps = {
  ['^'] = {0, -1},
  ['v'] = {0, 1},
  ['>'] = {1, 0},
  ['<'] = {-1, 0}}
local x = 0
local y = 0
local visits = {[0]={[0]=true}}
local presented = 1
for dir in io.read('a'):gmatch('[v%<%>%^]') do
  x = x + steps[dir][1]
  y = y + steps[dir][2]
  if not visits[y] then visits[y] = {} end
  if not visits[y][x] then
    visits[y][x] = true
    presented = presented + 1
  end
end
print(presented)