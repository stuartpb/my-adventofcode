#! /usr/bin/env lua
local layers = {{{}}}
local layer = layers[1]
local row = layer[1]
local width = 25
local height = 6
local count0 = 0
local count0least = math.huge 
local layer0least
for num in io.stdin:lines(1) do
  num = tonumber(num)
  if not num then goto continue end
  if #row == width then
    if #layer == height then
      if count0 < count0least then
        count0least = count0
        layer0least = #layers
      end
      count0 = 0
      layer = {}
      layers[#layers+1] = layer
    end
    row = {}
    layer[#layer+1] = row
  end
  if num == 0 then count0 = count0 + 1 end
  row[#row+1] = num
  ::continue::
end
if count0 < count0least then
  count0least = count0
  layer0least = #layers
end
local count1, count2 = 0, 0
for y, row in pairs(layers[layer0least]) do
  for x, num in pairs(row) do
    if num == 1 then count1 = count1 + 1
    elseif num ==  2 then count2 = count2 + 1 end
  end
end
print(count1 * count2)
