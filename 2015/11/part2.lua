#! /usr/bin/env lua
local straights = {
  'abc','bcd','cde','def','efg','fgh',
  -- straights containing [ilo] would go here
  'pqr','qrs','rst','stu','tuv','uvw','vwx','wxy','xyz'
}
local password = io.read()
local function validPassword()
  if password:match'[ilo]' then return false end
  local _, doubles = password:gsub('(.)%1', {})
  if doubles < 2 then return false end
  for i, straight in pairs(straights) do
    if password:match(straight) then return true end
  end
  return false
end
local function nextPassword()
  local prefix, incr, zs = password:match('^(.-)([^z])(z*)$')
  return prefix .. string.char(incr:byte() + 1) .. ('a'):rep(#zs)
end
while not validPassword() do password = nextPassword() end
password = nextPassword()
while not validPassword() do password = nextPassword() end
print(password)
