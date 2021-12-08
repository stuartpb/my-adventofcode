#! /usr/bin/env lua
local metaTotal = 0
local function readNode()
  local meta = {}
  local node = {meta=meta}
  local children, metas = io.read'n', io.read'n'
  for i=1, children do
    node[i] = readNode()
  end
  for i=1, metas do
    meta[i] = io.read'n'
  end
  return node
end
local function nodeValue(node)
  if node.val then return node.val end
  local sum = 0
  if node[1] then
    for _, i in pairs(node.meta) do
      sum = sum + (node[i] and nodeValue(node[i]) or 0)
    end
  else
    for _, i in pairs(node.meta) do
      sum = sum + i
    end
  end
  node.val = sum
  return sum
end
print(nodeValue(readNode()))
