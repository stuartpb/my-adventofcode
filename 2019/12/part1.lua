#! /usr/bin/env lua
local moons = {}
for line in io.lines() do
  local moon = {vel={0, 0, 0}}
  moons[#moons+1] = moon
  local x, y, z = line:match'<x=(%-?%d+), y=(%-?%d+), z=(%-?%d+)>'
  moon.pos = {tonumber(x), tonumber(y), tonumber(z)}
end
local function cmp(m, n)
  if m < n then return 1
  elseif m > n then return -1
  else return 0 end
end
local function absum(v)
  local sum = 0
  for axis = 1, 3 do
    sum = sum + math.abs(v[axis])
  end
  return sum
end
local log = print
local function xyz(v)
  return ('<x=%3d, y=%3d, z=%3d>'):format(v[1], v[2], v[3])
end
local function serialize(moon)
  return ("pos=%s, vel=%s"):format(xyz(moon.pos), xyz(moon.vel))
end
for step = 1, 1000 do
  for i, near in pairs(moons) do
    for j, far in pairs(moons) do
      for axis = 1, 3 do
        near.vel[axis] = near.vel[axis] + cmp(near.pos[axis], far.pos[axis])
      end
    end
  end
  for i, moon in ipairs(moons) do
    for axis = 1, 3 do
      moon.pos[axis] = moon.pos[axis] + moon.vel[axis]
    end
  end
end
local energy = 0
for i, moon in pairs(moons) do
  energy = energy + absum(moon.pos) * absum(moon.vel)
end
print(energy)
