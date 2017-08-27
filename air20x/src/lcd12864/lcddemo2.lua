module(...,package.seeall)

require"uitool"

--[[
  demo2
  add simply format idea , could center/padding/align
]]
local function print(...)
  _G.print("lcddemo2",...)
end

local function render()
  local c = misc.getclock()
  
  local lines = {}
  lines[1] = {row = 0, txt = "左对齐默认."}
  lines[2] = {row = 1, txt = "居中显示", align = "C"}
  lines[3] = {row = 2, txt = "左缩进5px", pl = 5}
  lines[4] = {row = 3, txt = "右对齐", align = "R"}
  
  uitool.clearscreen()
  uitool.renderStrings(lines)
  uitool.update()
end

render()
