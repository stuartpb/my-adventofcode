#! /usr/bin/env lua
local points = {}
local pattern = 'position=<%s-(%-?%d+),%s-(%-?%d+)> \z
  velocity=<%s-(%-?%d+),%s-(%-?%d+)>'
local left, top, right, bottom = math.huge, math.huge, -math.huge, -math.huge
local width, height = math.huge, math.huge
local function pushbounds(x, y)
  if x < left then left = x end
  if x > right then right = x end
  if y < top then top = y end
  if y > bottom then bottom = y end
end
for line in io.lines() do
  local px, py, vx, vy = line:match(pattern)
  px = tonumber(px)
  py = tonumber(py)
  vx = tonumber(vx)
  vy = tonumber(vy)
  pushbounds(px, py)
  points[#points+1] = {p={px, py}, v={vx, vy}}
end
local maxwidth = 62
local second = 0
while width > maxwidth do
  left, top, right, bottom = math.huge, math.huge, -math.huge, -math.huge 
  for i, point in pairs(points) do
    for d = 1, 2 do
      point.p[d] = point.p[d] + point.v[d]
    end
    pushbounds(point.p[1], point.p[2])
  end
  width = math.abs(right - left) + 1
  height = math.abs(bottom - top) + 1
  second = second + 1
end
print(second)
