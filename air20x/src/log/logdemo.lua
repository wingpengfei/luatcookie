module(...,package.seeall)

local function print(...)
  _G.print("logdemo",...)
end

local function showtime()
  print("time : "..misc.getclockstr())
end

sys.timer_loop_start(showtime,1000)
