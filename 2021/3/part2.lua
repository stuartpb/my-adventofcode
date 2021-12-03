#! /usr/bin/env lua
local report = {}
for line in io.lines() do
  report[#report+1] = line
end
function getstats(report)
  local counts = {}
  for i = 1, 12 do
    counts[i] = {['1'] = 0, ['0'] = 0}
  end
  for j = 1, #report do
    for i = 1, 12 do
      local digit = report[j]:sub(i,i)
      counts[i][digit] = counts[i][digit] + 1
    end
  end
  return counts
end
local stats = getstats(report)
local greater1 = stats[1]['0'] > stats[1]['1'] and '0' or '1'
local gamma = {}
local epsilon = {}
for i = 1, #report do
  if report[i]:sub(1, 1) == greater1 then
    gamma[#gamma+1] = report[i]
  else
    epsilon[#epsilon+1] = report[i]
  end
end
local function filter(tab, pos, char)
  if #tab == 1 then return tab end
  local filtered = {}
  for i = 1, #tab do
    if tab[i]:sub(pos, pos) == char then
      filtered[#filtered+1] = tab[i]
    end
  end
  return filtered
end
for i = 2, 12 do
  local gstats = getstats(gamma)
  local estats = getstats(epsilon)
  gdigit = gstats[i]['0'] > gstats[i]['1'] and '0' or '1'
  edigit = estats[i]['0'] <= estats[i]['1'] and '0' or '1'
  gamma = filter(gamma, i, gdigit)
  epsilon = filter(epsilon, i, edigit)
end

gamma = tonumber(gamma[1], 2)
epsilon = tonumber(epsilon[1], 2)
print(gamma * epsilon)
