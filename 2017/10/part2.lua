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
for v in (io.read()..'\17\31\73\47\23'):gmatch'.' do
  lengths[#lengths+1] = v:byte()
end
local sparse = {}
for i = 0, 255 do
  sparse[i+1] = i
end
local pos = 1
local skip = 0
for round = 1, 64 do
  for i, len in ipairs(lengths) do
    if len > 0 then
      reverse(sparse, pos, (pos + len - 2) % #sparse + 1)
    end
    pos = (pos + len + skip - 1) % #sparse + 1
    skip = skip + 1
  end
end
local dense = {}
for block = 1, 16 do
  local byte = 0
  for i = (block-1) * 16 + 1, block * 16 do
    byte = byte ~ sparse[i]
  end
  dense[block] = ('%02x'):format(byte)
end
print(table.concat(dense))
