module(...,package.seeall)

require"uc1701x"

-- init the proxy, to adapt different LCD driver
local proxy = uc1701x

--[[
  expose unified API
  
  clear           clear the screen
  update          flush the buffer content to the screen
  puttext         populate text data
  putimage        populate image data
  setcolor        switch pen color
  drawrect        draw rectangle
]]

-------------------------------------------------------------------------------
function init(driver)
  if "" == driver then
    proxy = uc1701x
  elseif "" == driver then
    proxy = uc1701x -- other driver
  end

  proxy.init()
end

function clear()
  proxy.clear()
end

function update()
  proxy.update()
end

function puttext(txt,x,y)
  proxy.puttext(txt,x,y)
end

function putimage(fname,x,y)
  proxy.putimage(fname,x,y)
end

function setcolor(color)
  proxy.setcolor(color)
end

function drawrect(left, top, right, bottom, color)
  proxy.drawrect(left, top, right, bottom, color)
end
-------------------------------------------------------------------------------
