#! /usr/bin/env lua
local function fryfree(here)
  -- for here in floors:gmatch('%a+') do
  local gens = here:gsub('%U','')
  local chips = here:gsub('%L','')
  local pat = '[^'..gens:lower()..']'
  if gens ~= '' and chips:match('[^'..gens:lower()..']') then
    return false
  end
  -- end
  return true
end
local sort = table.sort
local concat = table.concat
local function floormalize(here)
  local uppers = {}
  for upper in here:gmatch'%u' do
    uppers[#uppers+1] = upper
  end
  sort(uppers)
  local lowers = {}
  for lower in here:gmatch'%l' do
    lowers[#lowers+1] = lower
  end
  sort(lowers)
  return concat(uppers) .. concat(lowers)
end
local function normalize(floors, ...)
  floors = floors:format(...)
  local order = {}
  local newletter = 'A'
  for letter in floors:gmatch'%l' do
    if not order[letter] then
      order[letter:upper()] = newletter:upper()
      order[letter:lower()] = newletter:lower()
      newletter = string.char(newletter:byte()+1)
    end
  end
  return (floors:gsub('%a',order):gsub('%a+',floormalize))
end
local loud = true
local long = false
local clear = true
local function log(f, ...)
  if loud then return io.write(f:format(...)) end
end
local floors = {}
local elletters = {}
local newletter = 'C'
for line in io.lines() do
  local here = #floors > 0 and {} or {'A','B','a','b'}
  for element, chipdash in line:gmatch'a (%a+)(%-?)' do
    local elletter = elletters[element]
    if not elletter then
      elletter = newletter
      elletters[element] = elletter
      newletter = string.char(newletter:byte()+1)
    end
    if chipdash == '-' then elletter = elletter:lower() end
    here[#here+1] = elletter
  end
  floors[#floors+1] = concat(here)
end
local start = normalize(';#%s;', concat(floors, ';'))
local finish = normalize('%s#%s;', (';'):rep(#floors), concat(floors))
local distances = {{[start] = 0}, {[finish] = 0}}
local step = 1
local queues = {{start}, {finish}}
local shortest
while not shortest and #queues[1] > 0 and #queues[2] > 0 do
  for side = 1, 2 do
    local queue = queues[side]
    local seen = distances[side]
    local met = distances[side%2+1]
    local sidename = side == 1 and 'forward' or 'reverse'
    local nextqueue = {}
    for qpos, state in ipairs(queue) do
      local prefix, here, suffix = state:match'^(.*);#(%a+);(.*)$'
      local lowerfloor, upperfloor
      if #prefix > 0 then
        prefix, lowerfloor = prefix:match'^(.-)(%a*)$'
      end
      if #suffix > 0 then
        upperfloor, suffix = suffix:match'^(%a*)(.-)$'
      end
      local protoqueue = {}
      for leader, following in here:gmatch'(.)()' do
        for i = following, #here+1 do
          local moving = leader..here:sub(i,i)
          local staying = here:gsub('['..moving..']','')
          if not fryfree(staying) then goto followerdone end
          if upperfloor and fryfree(moving..upperfloor) then
            protoqueue[#protoqueue+1] = normalize('%s%s;%s;#%s%s%s',
              prefix, lowerfloor or '', staying,
              moving, upperfloor, suffix)
          end
          if lowerfloor and fryfree(moving..lowerfloor) then
            protoqueue[#protoqueue+1] = normalize('%s#%s%s;%s;%s%s',
              prefix, moving, lowerfloor,
              staying, upperfloor or '', suffix)
          end
        ::followerdone:: end
      ::leaderdone:: end
      for i, nextstate in ipairs(protoqueue) do
        if seen[nextstate] then goto enqueuedone end
        seen[nextstate] = step
        if met[nextstate] then
          shortest = step + met[nextstate]
          goto stepdone
        else
          nextqueue[#nextqueue+1] = nextstate
        end
      ::enqueuedone:: end
      log('%s%s %d %3d%% done %s (%d/%d)%s',
        long and '' or '\r',
        sidename, step,
        100*qpos/#queue//1,
        state, qpos, #queue,
        long and '\n' or '')
    ::statedone:: end
    log(clear and (long and '' or '\27[K') or '\n')
    queues[side] = nextqueue
  ::sidedone:: end
  step = step + 1
::stepdone:: end
log'\n'
print(shortest)
