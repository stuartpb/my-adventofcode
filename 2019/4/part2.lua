#! /usr/bin/env lua
local low, high = io.read():match'(%d+)%-(%d+)'
local total = 0
for i = tonumber(low), tonumber(high) do
  local digits = tostring(i)
  local seq = 1
  local had2
  local prev = digits:sub(1,1)
  for j = 2, #digits do
    local here = digits:sub(j,j)
    if here < prev then goto nextnum
    elseif here == prev then seq = seq + 1
    else
      had2 = had2 or seq == 2
      seq = 1
    end
    prev = here
  end
  if had2 or seq == 2 then total = total + 1 end
  ::nextnum::
end
print(total)
