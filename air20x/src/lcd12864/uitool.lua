module(...,package.seeall)

require"disp2"

--LCD分辨率的宽度和高度(单位是像素)
WIDTH,HEIGHT = 128,64
--1个ASCII字符宽度为8像素，高度为16像素；汉字宽度和高度都为16像素
--lua string.len(txt) 对汉字单个字长度返回2
ASCII_WIDTH = 8
ROW_HEIGHT = 16

--------------------------------------------------------------------------------
local function centerOffset(txt)
  local length = string.len(txt) * ASCII_WIDTH
  if length >= WIDTH then
    return 0;
  end
  
  return (WIDTH-length)/2
end

local function rightOffset(txt, paddingright)
  local length = string.len(txt) * ASCII_WIDTH
  if ( length + paddingright) >= WIDTH then
    return 0;
  end
  
  return WIDTH - length - paddingright
end

--[[
  render page with strings
  
  row           Y offset is row*ROW_HEIGHT
  txt           text content
  align         L, R, C (LEFT,RIGHT,CENTER) LEFT as default
  pl            padding left
  pr            padding right
  
  sample 
      strings[1] = {row = 3, txt = "hello"}
      strings[2] = {row = 4, txt = "中文", align = "C"}
      strings[3] = {row = 5, txt = "hello", pl = 2}
      strings[4] = {row = 6, txt = "hello", align = "R", pr = 2}
      
]]
function renderStrings(strings)
    local align, pl, pr
    local x, y
    for i=1,#strings,1 do
      align = strings[i].align or 'L'
      pl =  strings[i].pl or 0
      pr =  strings[i].pr or 0
    
      y = ROW_HEIGHT * strings[i].row
      x = 0 + pl
      if 'R' == align then
        x = rightOffset(strings[i].txt, pr)
      elseif 'C' == align then
        x = centerOffset(strings[i].txt)
      end
      
      disp2.puttext(strings[i].txt,x,y)
    end    
end

--[[
  render lines
  only horizontal/vertical (0/90 degree) for now
  in theory, we could draw any type lines via rectangle overlapping
  but do not overkill for now
  
  x1,y1     start
  x2,y2     end
  
]] 

local function drawline(x1,y1,x2,y2)
    -- assert(x1 == x2 or y1 == y2,"only support 0/90 degree for now")
    if x1 ~= x2 and y1 ~= y2 then
      print("only support 0/90 degree for now")
      return
    end
    
    if x1 == x2 then
        disp2.drawrect(x1,y1,x1+2,y2,0xffff);
        disp2.drawrect(x1+1,y1,x1+3,y2,0);
    else 
        disp2.drawrect(x1,y1,x2,y1+1,0xffff);
        disp2.drawrect(x1,y1+1,x2,y1+2,0);
    end
end

--[[
    sample 
      lines[1] = {x1 = 10, y1 = 0, x2 = 10, y2 = 64}
      lines[2] = {x1 = 20, y1 = 0, x2 = 20, y2 = 64}
      lines[3] = {x1 = 30, y1 = 0, x2 = 30, y2 = 64}
      lines[4] = {x1 = 40, y1 = 0, x2 = 40, y2 = 64}
]]
function renderLines(lines)
    local line
    for i=1,#lines,1 do
      line = lines[i]
      drawline(line.x1, line.y1, line.x2, line.y2)
    end
end

--[[
  sample 
      rect[1] = {l = 1, t = 1, r = 127, b = 63}
      rect[2] = {l = 10, t = 10, r = 117, b = 53}
      rect[3] = {l = 20, t = 20, r = 107, b = 43}
      rect[4] = {l = 30, t = 30, r = 97, b = 33}
]]
function renderRectangles(rects)
    local rect
    for i=1,#rects,1 do
      rect = rects[i]
      disp2.drawrect(rect.l, rect.t, rect.r, rect.b, 0xffff)
      disp2.drawrect(rect.l+1, rect.t+1, rect.r-1, rect.b-1, 0x0000)
    end
end

--[[
  sample 
      block[1] = {l = 5, t = 5, r = 25, b = 25}
      block[2] = {l = 30, t = 5, r = 30+25, b = 5+25}
]]
function renderBlocks(blocks)
    local block
    for i=1,#blocks,1 do
      block = blocks[i]
      disp2.drawrect(block.l, block.t, block.r, block.b, 0xffff)
    end
end

function clearscreen()
    disp2.clear()
end

function update()
    disp2.update()
end
    
disp2.init("uc1701x") -- init driver uc1701x
