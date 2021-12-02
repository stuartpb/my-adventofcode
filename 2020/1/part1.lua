#! /usr/bin/env lua
local expenses = {}
local set = {}
for expense in io.lines() do
  expense = tonumber(expense)
  expenses[#expenses+1] = expense
  set[expense] = true
end
for i = 1, #expenses do
  local ours = expenses[i]
  local other = 2020 - ours
  if set[other] then
    print(ours * other)
    break
  end
end
