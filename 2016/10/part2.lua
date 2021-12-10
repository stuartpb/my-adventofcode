#! /usr/bin/env lua
local targets = {}
local bots = {}
local outputs = {}
local function distribute(bo, target, given)
  if bo == 'output' then
    outputs[target] = given
  else
    local held = bots[target] or {}
    bots[target] = held
    held[#held + 1] = given
    local lohi = targets[target]
    if lohi and #held == 2 then
      local low = math.min(held[1], held[2])
      local high = math.max(held[1], held[2])
      distribute(lohi[1], lohi[2], low)
      distribute(lohi[3], lohi[4], high)
    end
  end
end
for line in io.lines() do
  local value, bo, i = line:match'value (%d+) goes to (%S+) (%d+)'
  if value then
    distribute(bo, tonumber(i), tonumber(value))
  else
    local bot, lbo, li, hbo, hi = line:match'bot (%d+) gives low to (%S+) (%d+) and high to (%S+) (%d+)'
    bot = tonumber(bot)
    li = tonumber(li)
    hi = tonumber(hi)
    targets[bot] = {lbo, li, hbo, hi}
    distribute('bot', bot)
  end
end
print(outputs[0] * outputs[1] * outputs[2])
