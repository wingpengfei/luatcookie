module(...,package.seeall)

local function print(...)
  _G.print("timereporterconsumer",...)
end

local function consume()
  print("time : "..misc.getclockstr())
end

--消息处理函数列表
local procer = {
  TIMEREPORT_EVENT = consume,
}
sys.regapp(procer)
