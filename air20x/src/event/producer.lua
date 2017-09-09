module(...,package.seeall)

local function print(...)
  _G.print("producer",...)
end

--[[
  
  produce per state
  
  true      generate log event
  false     generate time report

]]
local state = true
local function produce()
  print("produce for state : ", state)
  
  if state then
     sys.dispatch('LOG_EVENT')
  else
     sys.dispatch('TIMEREPORT_EVENT')
  end
  
  state = not state
end

sys.timer_loop_start(produce,2000)
