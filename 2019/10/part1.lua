#! /usr/bin/env lua
local y = 1
local asteroids = {}
local atan = math.atan
for line in io.lines() do
  for x in line:gmatch'()#' do
    asteroids[#asteroids+1] = {x, y}
  end
  y = y + 1
end
local most = 0
for i, origin in pairs(asteroids) do
  local views = {}
  local count = 0
  for j, target in pairs(asteroids) do
    if i == j then goto continue end
    local angle = atan(target[2] - origin[2], target[1] - origin[1])
    if not views[angle] then
      views[angle] = true
      count = count + 1
    end
    ::continue::
  end
  if count > most then
    most = count
  end
end
print(most)
