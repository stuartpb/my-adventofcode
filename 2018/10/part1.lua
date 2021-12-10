#! /usr/bin/env lua
local points = {}
local pattern = 'position=<%s-(%-?%d+),%s-(%-?%d+)> \z
  velocity=<%s-(%-?%d+),%s-(%-?%d+)>'
local left, top, right, bottom = math.huge, math.huge, -math.huge, -math.huge 
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
local unpack = table.unpack
local maxwidth = 79
local blankline = {}
for i = 1, maxwidth do
  blankline[i] = '.'
end
local fixleft
while not fixleft or right - left < maxwidth do
  left, top, right, bottom = math.huge, math.huge, -math.huge, -math.huge 
  for i, point in pairs(points) do
    for d = 1, 2 do
      point.p[d] = point.p[d] + point.v[d]
    end
    pushbounds(point.p[1], point.p[2])
  end
  local width = math.abs(right - left) + 1
  local height = math.abs(bottom - top) + 1
  if width <= maxwidth then
    fixleft = fixleft or left
    local frame = {}
    for i = 1, height do
      frame[i] = {unpack(blankline)}
    end
    for i, point in pairs(points) do
      local p = point.p
      local x = 1 + p[1] - fixleft
      local y = 1 + p[2] - top
      frame[y][x] = '#'
    end
    print(('='):rep(maxwidth))
    for i = 1, height do
      print(table.concat(frame[i]))
    end
  end
end
print(('='):rep(maxwidth))
