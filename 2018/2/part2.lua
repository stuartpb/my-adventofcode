#! /usr/bin/env lua
local ids = {}
for line in io.lines() do
  ids[#ids+1] = line 
end
local length = #ids[1]
local sub = string.sub
for pos = length, 1, -1 do
  local prefixes = {}
  for i = 1, #ids do
    local id = ids[i]
    local prefix = sub(id, 1, pos-1)
    if not prefixes[prefix] then prefixes[prefix] = {} end
    local others = prefixes[prefix]
    local suffix = sub(id, pos+1, length)
    for j = 1, #others do
      if others[j] == suffix then
        print(prefix..suffix)
        goto done
      end
    end
    others[#others+1] = suffix
  end
end
::done::
