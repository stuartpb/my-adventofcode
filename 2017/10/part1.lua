#! /usr/bin/env lua
local function reverse(t, a, z)
  local l = a <= z and (z - a - 1) // 2
    or (z + #t - a - 1) // 2
  for i = 0, l do
    local m = (a + i - 1) % #t + 1
    local n = (z - i - 1) % #t + 1
    t[m], t[n] = t[n], t[m]
  end
  return t
end
local lengths = {}
for v in io.read():gmatch'%d+' do
  lengths[#lengths+1] = tonumber(v)
end
local list = {}
for i = 0, 255 do
  list[i+1] = i
end
local pos = 1
local skip = 0
for i, len in ipairs(lengths) do
  if len > 0 then
    reverse(list, pos, (pos + len - 2) % #list + 1)
  end
  pos = (pos + len + skip - 1) % #list + 1
  skip = skip + 1
end
print(list[1] * list[2])
