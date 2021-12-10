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
local station
local rays
for i, origin in pairs(asteroids) do
  local views = {}
  local count = 0
  for j, target in pairs(asteroids) do
    if i == j then goto continue end
    local dy = origin[2] - target[2]
    local dx = target[1] - origin[1]
    local angle = atan(dy, dx)
    local ray = views[angle]
    if ray then
      ray[#ray+1] = target
    else
      views[angle] = {target}
      count = count + 1
    end
    ::continue::
  end
  if count > most then
    most = count
    station = origin
    rays = views
  end
end
local function clockangle(a)
  return (2.5 * math.pi - a) % (2 * math.pi)
end
local function mandist(m, n)
  return math.abs(m[1]-n[1]) + math.abs(m[2]-n[2])
end
local angles = {}
for angle, ray in pairs(rays) do
  angles[#angles+1] = angle
  table.sort(ray, function(m, n)
    return mandist(station, m) < mandist(station, n)
  end)
end
table.sort(angles, function(m, n)
  return clockangle(m) < clockangle(n) end)
local blasted = 0
local depth = 1
while blasted < #asteroids - 1 do
  for i, angle in ipairs(angles) do
    if rays[angle][depth] then
      local target = rays[angle][depth]
      blasted = blasted + 1
      if blasted == 200 then
        print((target[1] - 1) * 100 + target[2] - 1)
      end
    end
  end
  depth = depth + 1
end
