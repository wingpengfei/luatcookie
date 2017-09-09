module(...,package.seeall)

local function print(...)
  _G.print("logconsumer",...)
end

local function consume()
  print("consumed by log consumer")
end

--消息处理函数列表
local procer = {
  LOG_EVENT = consume,
}
sys.regapp(procer)

