#! /usr/bin/env lua
local log = {}
for line in io.lines() do
  log[#log+1] = line
end
table.sort(log)
local logpattern = '^%[(%d%d%d%d%-%d%d%-%d%d) (%d%d):(%d%d)%] (.*)$'
local sleepers = {}
local sleeptotals = {}
local onduty
local hoursleep
local function maxkey(t)
  local keys = {}
  for k in pairs(t) do
    keys[#keys+1] = k
  end
  table.sort(keys, function (m,n) return t[m] > t[n] end)
  return keys[1]
end
for i = 1, #log do
  local date, hour, minute, event = log[i]:match(logpattern)
  local newguard = event:match'Guard #(%d+) begins shift'
  if newguard then
    onduty = newguard
    hoursleep = sleepers[newguard]
    if not hoursleep then
      hoursleep = {}
      for i = 0, 59 do
        hoursleep[i] = 0
      end
      sleepers[newguard] = hoursleep
      sleeptotals[newguard] = 0
    end
  end
  if event == 'falls asleep' then
    local _, _, wakemin, wakeevent = log[i+1]:match(logpattern)
    assert(wakeevent == 'wakes up', wakeevent..' before wakeup')
    wakemin = tonumber(wakemin)
    minute = tonumber(minute)
    for i = minute, wakemin - 1 do
      hoursleep[i] = hoursleep[i] + 1
    end
    sleeptotals[onduty] = sleeptotals[onduty] + wakemin - minute
  end
end
local sleepiestguard = maxkey(sleeptotals)
local sleepiestminute = maxkey(sleepers[sleepiestguard])
print(tonumber(sleepiestguard) * sleepiestminute)
