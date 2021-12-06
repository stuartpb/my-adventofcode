#! /usr/bin/env lua
local common
local total = 0
local function finishgroup()
  total = total + #common
  common = nil
end
for line in io.lines() do
  if line == '' then finishgroup()
  elseif common then
    common = common:gsub('.', function(c)
      return line:match(c) or '' end)
  else common = line end
end
finishgroup()
print(total)
