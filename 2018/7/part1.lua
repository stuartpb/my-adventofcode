#! /usr/bin/env lua
local pending = {}
local forward = {}
local ready = {}
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
local order = {}
while next(ready) do
  local top = next(ready)
  for k in pairs(ready) do
    if k < top then top = k end
  end
  ready[top] = nil
  order[#order+1] = top
  local unblocks = forward[top]
  if unblocks then
    for step, blockers in pairs(unblocks) do
      blockers[top] = nil
      if not next(blockers) then ready[step] = true end
    end
    forward[top] = nil
  end
end
print(table.concat(order))
