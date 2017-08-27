module(...,package.seeall)

require"uitool"

--[[
  demo3
  very basic 'graphic', lets draw some lines, blocks, rectangles
]]
local function print(...)
  _G.print("lcddemo3",...)
end

local function renderverticallines()
  local lines = {}
  
  local marginLeft = 4 
  for i=0,127,8 do
    i = i + marginLeft
    lines[i/8 + 1] = {x1 = i, y1 = 0, x2 = i, y2 = 64}    
  end

  uitool.clearscreen()
  uitool.renderLines(lines)
  uitool.update()
end

local function renderhorizonlines()
  local lines = {}
  
  local marginTop = 4
  for i=0,63,8 do
    i = i + marginTop
    lines[i/8 + 1] = {x1 = 0, y1 = i, x2 = 128, y2 = i}    
  end

  uitool.clearscreen()
  uitool.renderLines(lines)
  uitool.update()
end

--[[
  block with 18 * 12
  margin-left : 3
  margin-top  : 4 
]]
local function renderblocks()
  local blocks = {}
  
  local index = 1
  local left,top
  for row=0,3,1 do
    for col=0,5,1 do 
       left = (18 + 3) * col + 3
       top  = (12 + 4) * row + 4
       blocks[index] = {
          l = left,
          t = top,
          r = left + 18, 
          b = top + 12
       }
       
       index = index + 1
    end
  end

  uitool.clearscreen()
  uitool.renderBlocks(blocks)
  uitool.update()
end

local function renderrectangles()
  local rects = {}
  rects[1] = {l = 1, t = 1, r = 127, b = 63}
  rects[2] = {l = 5, t = 5, r = 122, b = 58}
  rects[3] = {l = 10, t = 10, r = 117, b = 53}
  rects[4] = {l = 15, t = 15, r = 112, b = 48}
  rects[5] = {l = 20, t = 20, r = 107, b = 43}
  rects[6] = {l = 25, t = 25, r = 102, b = 38}
  rects[7] = {l = 29, t = 29, r = 98, b = 34}
      
  uitool.clearscreen()
  uitool.renderRectangles(rects)
  uitool.update()
end

--------------------------------------------------------------------------------
local winid = 0
local function switchscreen()
  if winid == 0 then
    renderhorizonlines()
  elseif winid == 1 then
    renderverticallines()
  elseif winid == 2 then
    renderblocks()
  elseif winid == 3 then
    renderrectangles()    
  end
  
  winid = winid == 3 and 0 or (winid + 1)
end

sys.timer_loop_start(switchscreen,3000)
