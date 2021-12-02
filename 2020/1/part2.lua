#! /usr/bin/env lua
local expenses = {}
local set = {}
for expense in io.lines() do
  expense = tonumber(expense)
  expenses[#expenses+1] = expense
  set[expense] = true
end
table.sort(expenses)
for right = #expenses, 1, -1 do
  for left = 1, right do
    local a = expenses[left]
    local c = expenses[right]
    local b = 2020 - a - c
    if b <= 0 then break
    elseif set[b] then
      print(a * b * c)
      goto done
    end
  end
end
::done::
