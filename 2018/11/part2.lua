#! /usr/bin/env lua
local serial = tonumber(io.read())
local fuel = {}
local squares = {}
for y = 1, 300 do
  row = {}
  fuel[y] = row
  sqrow = {}
  squares[y] = sqrow
  for x = 1, 300 do
    local rack = x + 10
    row[x] = (rack * y + serial) * rack // 100 % 10 - 5
    sqrow[x] = 0
  end
end
local largest = -math.huge
local top, left, large
for size = 1, 300 do
  for y = 1, 301 - size do
    local sqrow = squares[y]
    local rows = {}
    for i = 0, size - 1 do
      rows[i+1] = fuel[y+i]
    end
    for x = 1, 301 - size do
      local square = sqrow[x] + rows[size][x + size - 1]
      for i = 0, size - 2 do
        square = square + rows[i+1][x + size - 1] + rows[size][x+i]
      end
      sqrow[x] = square
      if square > largest then
        largest = square
        top = y
        left = x
        large = size
      end
    end
  end
end
print(left, top, large)
