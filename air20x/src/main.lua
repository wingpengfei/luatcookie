--必须在这个位置定义PROJECT和VERSION变量
--PROJECT：ascii string类型，可以随便定义，只要不使用,就行
--VERSION：ascii string类型，如果使用Luat物联云平台固件升级的功能，必须按照"X.X.X"定义，X表示1位数字；否则可随便定义
PROJECT = "LUAT_COOKIE_V1"
VERSION = "1.0.0"
require"sys"
require"misc"
require"common"

require"ntp"
--require"lcddemo1"
--require"lcddemo2"
--require"lcddemo3"
--require"lcddemo4"
--require"logdemo"
require"leddemo1"

--require"producer"
--require"logconsumer"
--require"timereportconsumer"

sys.init(0,0)
sys.setworkmode(sys.SIMPLE_MODE)
--misc.setflymode(true)

sys.run()

