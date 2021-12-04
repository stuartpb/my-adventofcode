#! /usr/bin/env lua
local calls = {}
for call in io.read():gmatch'%d+' do
  calls[#calls+1] = tonumber(call)
end
local boardswith = {}
local pending = {}
for line in io.lines() do
  if line == '' then
    board = {}
    pending[board] = true
  else
    local row = {}
    local y = #board + 1
    board[y] = row
    for num in line:gmatch'%d+' do
      num = tonumber(num)
      local x = #row + 1
      row[x] = num
      local boardlist = boardswith[num]
      if boardlist then
        boardlist[#boardlist+1] = {board, x, y}
      else
        boardswith[num] = {{board, x, y}}
      end
    end
  end
end
local called = {}
for turn, call in ipairs(calls) do
  called[call] = true
  if turn >= 5 then
    local checking = boardswith[call] or {}
    for _, tuple in ipairs(checking) do
      local board, x, y = table.unpack(tuple)
      if not pending[board] then goto continue end
      local rightwin = true
      local downwin = true
      for cross = 1, 5 do
        rightwin = rightwin and called[board[y][cross]]
        downwin = downwin and called[board[cross][x]]
      end
      if rightwin or downwin then
        pending[board] = nil
        if next(pending) then goto continue end
        local uncalledsum = 0
        for y, row in ipairs(board) do
          for x, num in ipairs(row) do
            uncalledsum = uncalledsum + (called[num] and 0 or num)
          end
        end
        print(uncalledsum * call)  
        goto done
      end
      ::continue::
    end
  end
end
::done::
