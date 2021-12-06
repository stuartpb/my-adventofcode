#! /usr/bin/env lua
local lights = {}
for y = 0, 999 do
  local row = {}
  lights[y] = row
  for x = 0, 999 do
    row[x] = false
  end
end
local tt = {
  ['turn on'] = {[true] = true, [false] = true},
  ['turn off'] = {[true] = false, [false] = false},
  ['toggle'] = {[true] = false, [false] = true},
}

for line in io.lines() do
  local command, left, top, right, bottom =
    line:match('(.+) (%d+),(%d+) through (%d+),(%d+)')
  local op = tt[command]
  for y = tonumber(top), tonumber(bottom) do
    local row = lights[y]
    for x = tonumber(left), tonumber(right) do
      row[x] = op[row[x]]
    end
  end
end
local total = 0
for y = 0, 999 do
  local row = lights[y]
  for x = 0, 999 do
    if row[x] then total = total + 1 end
  end
end
print(total)
