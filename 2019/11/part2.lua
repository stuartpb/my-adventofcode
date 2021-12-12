#! /usr/bin/env lua
local unpack = table.unpack
local program = {}
local pos = 0
for code in io.read('a'):gmatch('%-?%d+') do
  program[pos] = tonumber(code)
  pos = pos + 1
end

local function intcode(ram) return coroutine.wrap(function(input)
  local pos = 0
  local relbase = 0
  local halted
  local function deref(inout, cb)
    return function(mode)
      local params = {}
      for i = 1, #inout do
        local v = ram[pos + i]
        -- mode[i] should always be 0 if 'o'
        if mode[i] == 2 then
          v = relbase + v
        end
        if inout:sub(i,i) == 'i' and mode[i] ~= 1 then
          -- TODO: error on negative position reads
          v = ram[v] or 0
        end
        params[i] = v
      end
      local dest = cb(unpack(params))
      if dest then pos = dest
      else pos = pos + 1 + #inout end
    end
  end
  local opcodes = {
    [1] = deref('iio', function(m, n, dest)
      ram[dest] = m + n
    end),
    [2] = deref('iio', function(m, n, dest)
      ram[dest] = m * n
    end),
    [3] = deref('o', function(dest)
      while not input do
        input = coroutine.yield()
      end
      ram[dest] = input
      input = nil
    end),
    [4] = deref('i', function(val)
      input = coroutine.yield(val)
    end),
    [5] = deref('ii', function(cnd, dest)
      if cnd ~= 0 then return dest end
    end),
    [6] = deref('ii', function(cnd, dest)
      if cnd == 0 then return dest end
    end),
    [7] = deref('iio', function(m, n, dest)
      ram[dest] = m < n and 1 or 0
    end),
    [8] = deref('iio', function(m, n, dest)
      ram[dest] = m == n and 1 or 0
    end),
    [9] = deref('i', function(inc)
      relbase = relbase + inc
    end),
    [99] = function() halted = true end
  }
  while not halted do
    local modes = {}
    local instruction = ram[pos]
    local opcode = instruction % (instruction >= 0 and 100 or -100)
    local param = math.abs(instruction // 100)
    while param > 0 do
      modes[#modes+1] = param % 10
      param = param // 10
    end
    opcodes[opcode](modes)
  end
  return 'halt'
end) end

local painter = intcode(program)
local hull = {}
local x = 0
local y = 0
local dir = 0
local paint = painter(1)
local rot = painter()
local total = 0
while paint ~= 'halt' and rot ~= 'halt' do
  local row = hull[y] or {}
  hull[y] = row
  row[x] = paint
  if rot == 0 then dir = (dir - 1) % 4
  elseif rot == 1 then dir = (dir + 1) % 4 end
  if dir == 0 then y = y - 1
  elseif dir == 1 then x = x + 1
  elseif dir == 2 then y = y + 1
  elseif dir == 3 then x = x - 1 end
  row = hull[y] or {}
  hull[y] = row
  local under = row[x] or 0
  paint = painter(under)
  if paint ~= 'halt' then rot = painter() end
end
if paint ~= 'halt' then
  local row = hull[y] or {}
  hull[y] = row
  row[x] = paint
end
local left, top, right, bottom =
  math.huge, math.huge, -math.huge, -math.huge
for y, row in pairs(hull) do
  if y < top then top = y end
  if y > bottom then bottom = y end
  for x in pairs(row) do
    if x < left then left = x end
    if x > right then right = x end
  end
end
for y = top, bottom do
  local row = hull[y]
  local buffer = {}
  for x = left, right do
    buffer[x-left+1] = row[x] == 1 and '#' or '.'
  end
  print(table.concat(buffer))
end
