#! /usr/bin/env lua
local required = {'byr', 'iyr', 'eyr',
  'hgt', 'hcl', 'ecl', 'pid'}
local valid = 0
local passport = {}
function validate()
  for i = 1, #required do
    if not passport[required[i]] then goto finish end
  end
  valid = valid + 1
  ::finish::
  passport = {}
end
for line in io.lines() do
  if line == '' then validate()
  else
    for key, value in line:gmatch'(%S+):(%S+)' do
      passport[key] = value
    end
  end
end
validate()
print(valid)
