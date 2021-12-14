#! /usr/bin/env lua
local current = {[-4]='.',[-3]='.',[-2]='.',[-1]='.'}
local nextgen = {[-4]='.',[-3]='.',[-2]='.',[-1]='.'}
local initial = io.read():match'initial state: ([.#]+)$'
for i, c in (initial..'....'):gmatch'()(.)' do
  i = i-1
  current[i] = c
  nextgen[i] = c
end
io.read()
local rules = {}
for line in io.lines() do
  local llcrr, n = line:match'(.....) => (.)'
  rules[llcrr] = n
end
local left = -2
local right = #initial+1
for gen = 1, 20 do
  while current[left] == '#' or current[left+1] == '#' do
    left = left - 1
    current[left - 2] = '.'
  end
  while current[right] == '#' or current[right-1] == '#' do
    right = right + 1
    current[right + 2] = '.'
  end
  nextgen[left - 1] = '.'
  nextgen[left - 2] = '.'
  for pot = left, right do
    nextgen[pot] = rules[table.concat(current,'',pot-2,pot+2)] or '.'
  end
  nextgen[right + 1] = '.'
  nextgen[right + 2] = '.'
  current, nextgen = nextgen, current
end
local total = 0
for pot = left, right do
  if current[pot] == '#' then
    total = total + pot
  end
end
print(total)
