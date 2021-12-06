#! /usr/bin/env lua
local lights = {}
for y = 0, 999 do
  local row = {}
  lights[y] = row
  for x = 0, 999 do
    row[x] = 0
  end
end
local tt = {
  ['turn on'] = 1,
  ['turn off'] = -1,
  ['toggle'] = 2,
}

for line in io.lines() do
  local command, left, top, right, bottom =
    line:match('(.+) (%d+),(%d+) through (%d+),(%d+)')
  local op = tt[command]
  for y = tonumber(top), tonumber(bottom) do
    local row = lights[y]
    for x = tonumber(left), tonumber(right) do
      row[x] = math.max(row[x] + op, 0)
    end
  end
end
local total = 0
for y = 0, 999 do
  local row = lights[y]
  for x = 0, 999 do
    total = total + row[x]
  end
end
print(total)
