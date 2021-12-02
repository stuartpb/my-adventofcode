#! /usr/bin/env lua
local unpack = table.unpack
local program = {}
local pos = 0
for code in io.read('a'):gmatch('%d+') do
  program[pos] = tonumber(code)
  pos = pos + 1
end

local function intcode(ram)
  local pos = 0
  while ram[pos] ~= 99 do
    -- undefined sources have undefined behavior; we treat them as 0 here
    if ram[pos] == 1 then
      ram[ram[pos+3]] = (ram[ram[pos+1]] or 0) + (ram[ram[pos+2]] or 0)
    elseif ram[pos] == 2 then
      ram[ram[pos+3]] = (ram[ram[pos+1]] or 0) * (ram[ram[pos+2]] or 0)
    end
    pos = pos + 4
  end
  return ram[0]
end

for noun = 0, 99 do
  for verb = 0, 99 do
    local trial = {unpack(program)}
    trial[1] = noun
    trial[2] = verb
    local result = intcode(trial)
    if result == 19690720 then
      print(100 * noun + verb)
      goto done
    end
  end
end
::done::
