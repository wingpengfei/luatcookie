module(...,package.seeall)

require"uitool"

--[[
  demo4
  out put image
]]
local function print(...)
  _G.print("lcddemo4",...)
end

local function render()
  disp2.clear()
  -- TODO better adapter
  disp.putimage("/ldata/logo.bmp",0,32,-1,0,0,127,31)
  disp.putimage("/ldata/logo.bmp",0,0,-1,0,32,127,63)
  disp2.update()
end

render()
