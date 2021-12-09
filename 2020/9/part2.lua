#! /usr/bin/env lua
local list = {}
for line in io.lines() do
  list[#list + 1] = tonumber(line)
end
local window = {}
local num
for i = 1, 25 do
  num = list[i]
  if window[num] then
    window[num] = window[num] + 1
  else
    window[num] = 1
  end
end
for i = 26, #list do
  num = list[i]
  local a = next(window)
  local b
  while a and not b do
    if window[num - a] then b = num - a
    else a = next(window, a) end
  end
  if not a then break end
  local leaving = list[i-25]
  if window[leaving] == 1 then
    window[leaving] = nil
  else
    window[leaving] = window[leaving] - 1
  end
  if window[num] then
    window[num] = window[num] + 1
  else
    window[num] = 1
  end
end
local left = 1
local right = 2
local sum = list[1] + list[2]
while sum ~= num or left == right do
  if sum < num then
    right = right + 1
    sum = sum + list[right]
  elseif sum > num then
    sum = sum - list[left]
    left = left + 1
  else
    left = left + 1
    right = left + 2
    sum = list[left] + list[right]
  end
end
local min = list[left]
local max = list[left]
for i = left + 1, right do
  if list[i] < min then min = list[i]
  elseif list[i] > max then max = list[i] end
end
print(min+max)
