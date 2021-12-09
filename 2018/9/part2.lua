#! /usr/bin/env lua
local players, last = io.read():match'(%d+)%D-(%d+)'
players = tonumber(players)
last = tonumber(last)
local scores = {}
for i = 1, players do
  scores[i] = 0
end
local current = {val = 0}
local first = current
current.next = current
current.prev = current
for turn = 1, last * 100 do
  if turn % 23 == 0 then
    local player = (turn - 1) % players + 1
    for i = 1, 7 do
      current = current.prev
    end
    scores[player] = scores[player] + turn + current.val
    current.next.prev, current.prev.next = current.prev, current.next
    current = current.next
  else
    current = current.next
    current = {val = turn, prev = current, next = current.next}
    current.prev.next = current
    current.next.prev = current
  end
end
local max = scores[1]
for i = 2, #scores do
  if scores[i] > max then max = scores[i] end
end
print(max)
