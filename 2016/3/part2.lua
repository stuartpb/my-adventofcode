#! /usr/bin/env lua
local valid = 0
local triples = {}
for line in io.lines() do
  local a, b, c = line:match('(%d+)%s+(%d+)%s+(%d+)')
  triples[#triples+1] = {tonumber(a), tonumber(b), tonumber(c)}
  if #triples == 3 then
    for i = 1, 3 do
      local a = triples[1][i]
      local b = triples[2][i]
      local c = triples[3][i]
      if a < b + c and b < a + c and c < a + b then
        valid = valid + 1
      end
    end
    triples = {}
  end
end
print(valid)
