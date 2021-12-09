#! /usr/bin/env lua
local players, last = io.read():match'(%d+)%D-(%d+)'
players = tonumber(players)
last = tonumber(last)
local scores = {}
for i = 1, players do
  scores[i] = 0
end
local circle = {0}
local pos = 1
for turn = 1, last do
  if turn % 23 == 0 then
    local player = (turn - 1) % players + 1
    pos = (pos - 8) % #circle + 1
    scores[player] = scores[player] + turn + table.remove(circle,pos)
  else
    pos = (pos + 1) % #circle + 1
    table.insert(circle,pos,turn)
  end
end
local max = scores[1]
for i = 2, #scores do
  if scores[i] > max then max = scores[i] end
end
print(max)
