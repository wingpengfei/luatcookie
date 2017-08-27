module(...,package.seeall)

require"disp2"

--[[
  demo1 
  lighting up lcd, render some content on spicified location
]]
local function print(...)
  _G.print("lcddemo1",...)
end

local count = 0;
local function refreshscreen()
  print("lcd update")

  local c = misc.getclock()
  
  disp2.clear()
  disp2.puttext("english,中文字体自动换行",0,0)
  disp2.puttext(c.month.."-"..c.day.." "..c.hour..":"..c.min..":"..c.sec,0,32)
  disp2.puttext("UPDATED "..count,0,48)
  count = count + 1
  --disp2.putimage("logo.bmp",0,0)
  disp2.update()
end

disp2.init("uc1701x") -- init driver uc1701x
sys.timer_loop_start(refreshscreen,1000)
