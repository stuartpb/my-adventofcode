#! /usr/bin/env lua
local fish = {}
for num in io.read():gmatch'%d+' do
  fish[#fish + 1] = tonumber(num)
end
local day = 0
while day < 80 do
  local spawning = 0
  for i, life in ipairs(fish) do
    if life == 0 then
      fish[i] = 6
      spawning = spawning + 1
    else
      fish[i] = life - 1
    end
  end
  local oldfish = #fish
  for i=1, spawning do
    fish[oldfish + i] = 8
  end
  day = day + 1
end
print(#fish)
