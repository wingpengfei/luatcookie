module(...,package.seeall)

require"common"


--[[
    --注意，此处的i2cslaveaddr是7bit地址
    --底层在读操作时，自动将第一个字节的内容转换为(i2cslaveaddr << 1) | 0x01
    --底层在写操作时，自动将第一个字节的内容转换为(i2cslaveaddr << 1) | 0x00
    --i2cslaveaddr根据外设地址而定
]]
local i2cid = 0

local function print(...) 
  _G.print("i2cscan",...)
end

local function devicescan()
  local i2cslaveaddr = 0x00      --芯片地址

  while i2cslaveaddr < 127 do
    local fre = i2c.setup(i2cid,i2c.SLOW,i2cslaveaddr)
    if fre ~= i2c.SLOW then
      print("init fail ",i2cslaveaddr)
    end
    
    local result= i2c.read(i2cid,0x00,1)
    if string.byte(result)~=nil then
      print("located live I2C asset on the bus : ", i2cslaveaddr,string.format("0x%02X ",i2cslaveaddr))
    end

    i2c.close(i2cid)
    i2cslaveaddr = i2cslaveaddr + 1
  end
end

sys.timer_start(devicescan,3000)
