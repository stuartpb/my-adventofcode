#! /usr/bin/env lua
local concat = table.concat
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
local last, lastscore
for gen = 0, 50000000000 do
  while current[left] == '#' or current[left+1] == '#' do
    left = left - 1
    current[left - 2] = '.'
  end
  while concat(current,'',left,left+2) == '...' do
    current[left-2] = nil
    nextgen[left-2] = nil
    left = left + 1
  end
  while current[right] == '#' or current[right-1] == '#' do
    right = right + 1
    current[right + 2] = '.'
  end
  while concat(current,'',right-2,right) == '...' do
    current[right+2] = nil
    nextgen[right+2] = nil
    right = right - 1
  end
  if lastscore then
    local score = 0
    for pot = left, right do
      if current[pot] == '#' then
        score = score + pot
      end
    end
    local shift = score - lastscore
    local remaining = 50000000000 - gen
    print(score + shift * remaining)
    break
  elseif concat(current,'',left,right) == last then
    lastscore = 0
    for pot = left, right do
      if current[pot] == '#' then
        lastscore = lastscore + pot
      end
    end
  end
  last = concat(current,'',left,right)
  nextgen[left - 1] = '.'
  nextgen[left - 2] = '.'
  for pot = left, right do
    nextgen[pot] = rules[concat(current,'',pot-2,pot+2)] or '.'
  end
  nextgen[right + 1] = '.'
  nextgen[right + 2] = '.'
  current, nextgen = nextgen, current
end
