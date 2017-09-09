module(...,package.seeall)

require"pins"

local function print(...)
  _G.print("leddemo",...)
end

--------------------------------------------------------------------------------
local PIN7 = {pin=pio.P0_7,dir=pio.OUTPUT,valid=1}
local PIN6 = {pin=pio.P0_6,dir=pio.OUTPUT,valid=1}
local PIN5 = {pin=pio.P0_5,dir=pio.OUTPUT,valid=1}
local PIN4 = {pin=pio.P0_4,dir=pio.OUTPUT,valid=1}

pins.reg(PIN7,PIN6,PIN5,PIN4)
--------------------------------------------------------------------------------

local state = true
local function blink()
  print("going to switch the led state to : ",state)

  pins.set(state,PIN7)
  pins.set(state,PIN6)
  pins.set(state,PIN5)
  pins.set(state,PIN4)

  state = not state
end 

sys.timer_loop_start(blink,1000)
