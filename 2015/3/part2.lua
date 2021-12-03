#! /usr/bin/env lua
local steps = {
  ['^'] = {0, -1},
  ['v'] = {0, 1},
  ['>'] = {1, 0},
  ['<'] = {-1, 0}}
local santas = {{0,0}, {0,0}}
local moving = 1
local visits = {[0]={[0]=true}}
local presented = 1
for dir in io.read('a'):gmatch'[v%<%>%^]' do
  for d = 1, 2 do
    santas[moving][d] = santas[moving][d] + steps[dir][d]
  end
  local x = santas[moving][1]
  local y = santas[moving][2]
  if not visits[y] then visits[y] = {} end
  if not visits[y][x] then
    visits[y][x] = true
    presented = presented + 1
  end
  if moving == 1 then moving = 2 else moving = 1 end
end
print(presented)

