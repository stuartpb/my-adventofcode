#! /usr/bin/env lua
local targets = {}
local bots = {}
local outputs = {}
local function distribute(target, given)
  if target < 0 then
    outputs[-target] = given
  else
    local held = bots[target] or {}
    bots[target] = held
    held[#held + 1] = given
    local lohi = targets[target]
    if lohi and #held == 2 then
      local low = math.min(held[1], held[2])
      local high = math.max(held[1], held[2])
      if low == 17 and high == 61 then print(target) end
      distribute(lohi[1], low)
      distribute(lohi[2], high)
    end
  end
end
for line in io.lines() do
  local value, bot = line:match'value (%d+) goes to bot (%d+)'
  if value then
    distribute(tonumber(bot), tonumber(value))
  else
    local bot, lbo, li, hbo, hi = line:match'bot (%d+) gives low to (%S+) (%d+) and high to (%S+) (%d+)'
    bot = tonumber(bot)
    li = tonumber(li)
    if lbo == 'output' then li = -li end
    hi = tonumber(hi)
    if hbo == 'output' then hi = -hi end
    targets[bot] = {li, hi}
    distribute(bot)
  end
end
