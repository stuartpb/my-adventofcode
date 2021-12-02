#! /usr/bin/env lua
local total = 0
local first = tonumber(io.read(1))
local prev = first
local next = io.read(1)
while next and next:match('%d') do
  next = tonumber(next)
  if (next == prev) then total = total + next end
  prev, next = next, io.read(1)
end
if prev == first then total = total + first end
print(total)
