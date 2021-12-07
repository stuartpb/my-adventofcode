#! /usr/bin/env lua
local pending = {}
local forward = {}
local ready = {}
local working = {}
local workers = 5
for line in io.lines() do
  local prereq, step = line:match'Step (.) must be finished before step (.) can begin%.'
  if ready[step] then ready[step] = nil end
  local blockers = pending[step]
  if blockers then
    blockers[prereq] = true
  else
    blockers = {[prereq] = true}
    pending[step] = blockers
  end
  local unblocks = forward[prereq]
  if unblocks then
    unblocks[step] = blockers
  else
    unblocks = {[step] = blockers}
    forward[prereq] = unblocks
  end
  if not pending[prereq] then ready[prereq] = true end
end
local duration = 0
while next(ready) or next(working) do
  local idle = workers
  for work, timeleft in pairs(working) do
    if timeleft > 1 then
      working[work] = timeleft - 1
      idle = idle - 1
    else
      working[work] = nil
      local unblocks = forward[work]
      if unblocks then
        for step, blockers in pairs(unblocks) do
          blockers[work] = nil
          if not next(blockers) then ready[step] = true end
        end
        forward[work] = nil
      end
    end
  end
  local top = next(ready)
  while top and idle > 0 do
    for k in pairs(ready) do
      if k < top then top = k end
    end
    ready[top] = nil
    working[top] = top:byte() - ('A'):byte() + 61
    idle = idle - 1
    top = next(ready)
  end
  if next(working) then duration = duration + 1 end
end
print(duration)
