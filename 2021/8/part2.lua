#! /usr/bin/env lua
local function has(a, b)
  return b:match('^['..a..']*$')
end
local segcounts = {
  [2] = {1},
  [3] = {7},
  [4] = {4},
  [5] = {2, 3, 5},
  [6] = {0, 6, 9},
  [7] = {8}
}
local total = 0
for line in io.lines() do
  local patterns, output = line:match'^(.+) | (.+)$'
  local digits = {}
  local ambig = {[5]={},[6]={}}
  for digit in patterns:gmatch'%a+' do
    if #segcounts[#digit] == 1 then
      digits[segcounts[#digit][1]] = digit
    else
      local list = ambig[#digit]
      list[#list+1] = digit
    end
  end
  for i, digit in pairs(ambig[6]) do
    if has(digit, digits[7]) then
      if has(digit, digits[4]) then
        digits[9] = digit
      else
        digits[0] = digit
      end
    else
      digits[6] = digit
    end
  end
  for i, digit in pairs(ambig[5]) do
    if has(digit, digits[1]) then
      digits[3] = digit
    elseif has(digits[6], digit) then
      digits[5] = digit
    else
      digits[2] = digit
    end
  end
  local readout = {}
  for digit in output:gmatch'%a+' do
    local possible = segcounts[#digit]
    if #possible == 1 then
      digit = segcounts[#digit][1]
    else
      for i, candidate in pairs(possible) do
        if has(digits[candidate], digit) then
          digit = candidate
          break
        end
      end
    end
    readout[#readout+1] = digit
  end
  total = total + tonumber(table.concat(readout))
end
print(total)
