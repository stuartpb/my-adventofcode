#! /usr/bin/env lua
local layers = {{{}}}
local layer = layers[1]
local row = layer[1]
local width = 25
local height = 6
for num in io.stdin:lines(1) do
  num = tonumber(num)
  if not num then goto continue end
  if #row == width then
    if #layer == height then
      layer = {}
      layers[#layers+1] = layer
    end
    row = {}
    layer[#layer+1] = row
  end
  row[#row+1] = num
  ::continue::
end
local image = {}
for y = 1, height do
  local row = {}
  for x = 1, width do
    local z = 1
    while layers[z][y][x] == 2 do
      z = z + 1
    end
    row[x] = layers[z][y][x]
  end
  image[y] = table.concat(row)
end
print(table.concat(image,'\n'))
