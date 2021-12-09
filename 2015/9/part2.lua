#! /usr/bin/env lua
local move = table.move
local insert = table.insert
local remove = table.remove
local function permutation(items, k)
  k = k - 1
  local picks = {k % 2, 0}
  local fac = 2
  for i = 3, #items do
    insert(picks, 1, (k % (fac * i)) // fac)
    fac = fac * i
  end
  local p = {}
  for i = 1, #picks do
    p[#p+1] = remove(items, picks[i]+1)
  end
  return p
end
local distances = {}
local cities = {}
for line in io.lines() do
  local from, to, dist = line:match'(%a+) to (%a+) = (%d+)'
  dist = tonumber(dist)
  local fromdist = distances[from]
  if fromdist then
    fromdist[to] = dist
  else
    cities[#cities + 1] = from
    distances[from] = {[to] = dist}
  end
  local todist = distances[to]
  if todist then
    todist[from] = dist
  else
    cities[#cities + 1] = to
    distances[to] = {[from] = dist}
  end
end
local n = #cities
local nfac = 1
for i = 2, #cities do
  nfac = nfac * i
end
local max = 0
for k = 1, nfac do
  local total = 0
  local order = permutation(move(cities,1,n,1,{}),k)
  for i = 1, n-1 do
    total = total + distances[order[i]][order[i+1]]
  end
  if total > max then max = total end
end
print(max)
