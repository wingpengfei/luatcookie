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

local state = 1
local function blink()
  print("going to switch the led state to : ",state)

  pins.set(bit.isset(state,0),PIN7)
  pins.set(bit.isset(state,1),PIN6)
  pins.set(bit.isset(state,2),PIN5)
  pins.set(bit.isset(state,3),PIN4)

  state = bit.lshift(state,1)
  state = state == 16 and 1 or state
end 

sys.timer_loop_start(blink,1000)
