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
    local metadata = io.read'n'
    metaTotal = metaTotal + metadata
    meta[i] = metadata
  end
  return node
end
readNode()
print(metaTotal)
