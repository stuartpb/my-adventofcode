#! /usr/bin/env lua
local size = 0
local file = string.gsub(io.read'a','%s','')
local function fullsize(s)
  local prefix, span, times, suffix = s:match'^(.-)%((%d+)x(%d+)%)(.*)'
  if prefix then
    span = tonumber(span)
    times = tonumber(times)
    local expanded = fullsize(suffix:sub(1,span))
    local rest = fullsize(suffix:sub(span+1))
    return #prefix + expanded * times + rest
  else return #s end
end
print(fullsize(file))
