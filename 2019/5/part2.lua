#! /usr/bin/env lua
local unpack = table.unpack
local program = {}
local pos = 0
for code in io.open(arg[1] or 'input'):read('a'):gmatch('%-?%d+') do
  program[pos] = tonumber(code)
  pos = pos + 1
end

local function intcode(ram)
  local pos = 0
  local halted
  local function deref(inout, cb)
    return function(mode)
      local params = {}
      for i = 1, #inout do
        local v = ram[pos + i]
        -- mode[i] should always be 0 if 'o'
        if inout:sub(i,i) == 'i' and mode[i] ~= 1 then
          -- TODO: error on bad reads like this
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
      ram[dest] = tonumber(io.read())
    end),
    [4] = deref('i', function(val)
      print(val)
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
    [99] = function() halted = true end
  }
  while not halted do
    local modes = {}
    -- undefined sources have undefined behavior; we treat them as 0 here
    local instruction = ram[pos]
    local opcode = instruction % (instruction >= 0 and 100 or -100)
    local param = math.abs(instruction // 100)
    while param > 0 do
      modes[#modes+1] = param % 10
      param = param // 10
    end
    opcodes[opcode](modes)
  end
  return ram[0]
end

intcode(program)
