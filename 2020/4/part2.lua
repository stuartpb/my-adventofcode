#! /usr/bin/env lua
local function isvalid(passport)
  local function validyear(digits, first, last)
    if not digits or #digits ~= 4 then return false end
    local year = tonumber(digits)
    return year and year >= first and year <= last
  end
  if not validyear(passport.byr, 1920, 2002) then return false end
  if not validyear(passport.iyr, 2010, 2020) then return false end
  if not validyear(passport.eyr, 2020, 2030) then return false end

  if not passport.hgt then return false end
  local height, units = passport.hgt:match'^(%d+)(%a%a)$'
  if not height then return false end
  height = tonumber(height)
  if units == 'cm' then
    if height < 150 or height > 193 then return false end
  elseif units == 'in' then
    if height < 59 or height > 76 then return false end
  else return false end

  if not passport.hcl then return false end
  if not passport.hcl:match('^#'..('[0-9a-f]'):rep(6)..'$') then return false end

  local eyecolors = {
    amb=true, blu=true, brn=true, gry=true, grn=true, hzl=true, oth=true}
  if not eyecolors[passport.ecl] then return false end

  if not passport.pid then return false end
  if not passport.pid:match('^'..('%d'):rep(9)..'$') then return false end

  return true
end

local valid = 0
local passport = {}
local function validate()
  if isvalid(passport) then valid = valid + 1 end
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
