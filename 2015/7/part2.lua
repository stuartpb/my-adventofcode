#! /usr/bin/env lua
local outputs = {}
for line in io.lines() do
  local input, output = line:match'(.+) %-> (.+)'
  outputs[output] = input
end
local function memoize(f, x)
  local memos = {}
  return function(x)
    if not memos[x] then memos[x] = f(x) end
    return memos[x]
  end
end
local getoutput
local function getoutput_core (x)
  if tonumber(x) then return tonumber(x) end
  local input = outputs[x]
  local prefix, infix, suffix = input:match'^([a-z0-9]-) ?([A-Z]*) ?([a-z0-9]+)$'
  if infix == '' then return getoutput(suffix)
  elseif prefix == '' then
    if infix == 'NOT' then
      return ~getoutput(suffix)
    else error("Unrecognized unary operation "..infix) end
  else
    if infix == 'AND' then
      return getoutput(prefix) & getoutput(suffix)
    elseif infix == 'OR' then
      return getoutput(prefix) | getoutput(suffix)
    elseif infix == 'LSHIFT' then
      return getoutput(prefix) << getoutput(suffix) -- & 0xffff
    elseif infix == 'RSHIFT' then
      return getoutput(prefix) >> getoutput(suffix)
    else error("Unrecognized binary operation "..infix) end
  end
end
getoutput = memoize(getoutput_core)
outputs.b = tostring(getoutput'a')
getoutput = memoize(getoutput_core)
print(getoutput'a')
