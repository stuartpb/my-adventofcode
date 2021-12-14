#! /usr/bin/env lua
local px, py, pz = {}, {}, {}
local vx, vy, vz = {}, {}, {}
for line in io.lines() do
  local i = #px + 1
  local x, y, z = line:match'<x=(%-?%d+), y=(%-?%d+), z=(%-?%d+)>'
  px[i] = tonumber(x)
  py[i] = tonumber(y)
  pz[i] = tonumber(z)
  vx[i], vy[i], vz[i] = 0, 0, 0
end
local moons = #px
local function cmp(m, n)
  if m < n then return 1
  elseif m > n then return -1
  else return 0 end
end
local format = string.format
local concat = table.concat
local buffer = {}
local function cycle(ps, vs, seen, step)
  for i = 1, moons do
    local v = vs[i]
    local p = ps[i] + v
    ps[i] = p
    buffer[i] = format('%d,%d',p,v)
  end
  local state = concat(buffer,';')
  if seen[state] then return step end
  seen[state] = true 
  for i = 1, moons do
    local c = ps[i]
    local v = vs[i]
    for j = 1, i-1 do
      v = v + cmp(c, ps[j])
    end
    for j = i+1, moons do
      v = v + cmp(c, ps[j])
    end
    vs[i] = v
  end
  return cycle(ps, vs, seen, step + 1)
end
local xcycle = cycle(px, vx, {}, 0)
local ycycle = cycle(py, vy, {}, 0)
local zcycle = cycle(pz, vz, {}, 0)
local function gcd(m, n)
  if n == 0 then return m end
  return gcd(n, m % n)
end
function lcm(m, n)
  return m * n // gcd(m, n)
end
print(lcm(lcm(xcycle, ycycle), zcycle))
