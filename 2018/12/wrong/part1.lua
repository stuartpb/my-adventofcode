#! /usr/bin/env lua
local function count(s,p)
  return select(2,s:gsub(p,'%0'))
end
local garden = io.read():match'initial state: ([.#]+)$'
io.read()
local rules = {}
for line in io.lines() do
  local llcrr, n = line:match'(.....) => (.)'
  rules[llcrr] = n
end
local total = count(garden,'#')
for i=1, 20 do
  garden = '..' .. garden .. '..'
  local oldgarden = '..' .. garden .. '..'
  garden = garden:gsub('().', function(i)
    return rules[oldgarden:sub(i, i+4)] or '.'
  end):gsub('^%.+',''):gsub('%.+$','')
  for
  total = total + count(garden,'#')
end
-- XXX: the total is supposed to be of pot numbers, not flowers
print(total)
