module(...,package.seeall)

function init()
  local para =
  {
    width = 128,
    height = 65,
    bpp = 1,
    --xoffset = 32,
    --yoffset = 64,
    bus = disp.BUS_SPI,
    hwfillcolor = 0xFFFF,
    pinrst = pio.P0_2,
    pinrs = pio.P0_12,
    initcmd =
    {
      0xE2, --soft reset
      0x2F, --选择内部电压供应操作模式 通常是 0x2C,0x2E,0x2F 三条 指令按顺序紧接着写，表示依次打开内部升压、电压调整电路、电压跟随器。也可以单单写0x2F，一次性打开三部分电路
      0x23, --选择内部电阻比例（Rb/Ra）:可以理解为粗调对比度值。可设置范围为：0x20～0x27， 数值越大对比度越浓，越小越淡
      0x81, --设置内部电阻微调，可以理解为微调对比度值，此两个指令需紧接着使用。上面一条指令0x81是不改的，下面一条指令可设置范围为：0x00～0x3F,数值越大对比度越浓，越小越淡
      0xA2, --设置偏压比：  0XA2：BIAS=1/9 (常用) 0XA3：BIAS=1/7 
      0xC8, --行扫描顺序选择：  0XC0:普通扫描顺序：从上到下 0XC8:反转扫描顺序：从下到上
      0xA0, --显示列地址增减：  0xA0：常规：列地址从左到右， 0xA1：反转：列地址从右到左
      -- 0xA7, --显示正显/反显: 0xA6：常规：正显 0xA7：反显 
      -- 0x2E,
      0x40, --设置显示存储器的显示初始行,可设置值为0X40~0X7F,分别代表第0～63行，针对该液晶屏一般设置为0x40
      0xAF, --显示开/关: 0XAE:关，0XAF：开
    },
    sleepcmd = {
      0xAE,
    },
    wakecmd = {
      0xAF,
    }
  }
  print("lcd init")
  disp.init(para)
  disp.clear()
end

local Y_OFFSET = 32;
local function offsetcalculate(x,y)
  y = y < 32 and (y + 32) or (y - 32)
  return x,y
end

function clear()
  disp.clear()
end

function update()
  disp.update()
end

function puttext(txt,x,y)
  x,y = offsetcalculate(x,y)
  disp.puttext(txt,x,y)
end

--[[
  fname       image name
  x           start left
  y           start top
  w           image width [optional]
  h           image height[optional] 
]]
function putimage(fname,x,y,w,h)
  x,y = offsetcalculate(x,y)
  disp.putimage(fname,x,y)
  --TODO
  --disp.putimage(fname,0,32,-1,0,0,127,31)
  --disp.putimage(fname,0,0,-1,0,32,127,63)
end

--[[
  color  black/white
  black   0x0000
  white   0xffff
]]
function setcolor(color)
  disp.setcolor(color)
end

--[[
  draw rectangle 
  maybe we could use this to clear screen
]]
function drawrect(left, top, right, bottom, color)
  if left > right then
    left,right = right,left
  end
  
  if top > bottom then
    top, bottom = bottom, top
  end
  
  if top < 32 and bottom > 32 then
    disp.drawrect(left, 32 + top, right, 64, color)  
    
    local lowpart = bottom - 31 
    disp.drawrect(left, 0, right, lowpart, color)  
  else
    top = top <= 32 and (top + 32) or (top - 32)
    bottom = bottom <= 32 and (bottom + 32) or (bottom - 32)
    disp.drawrect(left, top, right, bottom, color)  
  end
end

---------------------------------
pmd.ldoset(6,pmd.LDO_VMMC)
