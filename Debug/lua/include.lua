

math.randomseed(os.time()); --设置时间种子


--#######################开始#########################
----警告：以下部分为引擎数据，不可更改！

--MessageBox 选项按钮选项
MB_OK                    =   0x00000000
MB_OKCANCEL              =   0x00000001
MB_ABORTRETRYIGNORE      =   0x00000002
MB_YESNOCANCEL           =   0x00000003
MB_YESNO                 =   0x00000004
MB_RETRYCANCEL           =   0x00000005

--MessageBox 返回值
IDOK       =         1
IDCANCEL   =         2
IDABORT    =         3
IDRETRY    =         4
IDIGNORE   =         5
IDYES      =         6
IDNO       =         7
--@@@@@@@@@@@@@@@@@@@@@@@结束@@@@@@@@@@@@@@@@@@@@@@@@@



--#######################开始#########################
--警告：以下部分为引擎数据，最多可以增加到19
--视图位置
NowView    =   0x0000
StartV     =   0x0000
PlotV      =   0x0001
ChallengeV =   0x0002
ShopV      =   0x0003
BackpackV  =   0x0004


LoadV      =   0x0019

--总的图片数量
AllImageNum = 31
NowLoadPos = 1
NextLoadPos = 1
--@@@@@@@@@@@@@@@@@@@@@@@结束@@@@@@@@@@@@@@@@@@@@@@@@@


--#######################开始#########################
--警告：以下部分为引擎数据，不可更改！
--按键状态
KeepPressing  = 101  --一直按下
Press         = 102  --按下的那一瞬间
Release       = 103  --松开的那一瞬间
--@@@@@@@@@@@@@@@@@@@@@@@结束@@@@@@@@@@@@@@@@@@@@@@@@@



--按键值设定，改变无用！
Up    =  0x11   --W
Down  =  0x1F   --S
Left  =  0x1E   --A
Right =  0x20   --D

--#######################开始#########################
--警告：以下部分为引擎数据，不可更改！
--鼠标状态
MouseLeftDown  = 0x01   --鼠标左键按下
MouseLeftUp    = 0x02   --鼠标左键松开
MouseRightDown = 0x03   --鼠标右键按下
MouseRightUp   = 0x04   --鼠标左键松开
MouseHover     = 0x05   --鼠标悬停

MousePosX      = 0      --鼠标当前X位置
MousePosY      = 0		--鼠标当前Y位置
--@@@@@@@@@@@@@@@@@@@@@@@结束@@@@@@@@@@@@@@@@@@@@@@@@@


LastMouseDownPosX = 0;  --上一次鼠标按下时的X位置
LastMouseDownPosY = 0;	--上一次鼠标按下时的Y位置
MouseStatus = 0x00

--#######################开始#########################
--警告：以下部分为引擎数据，不可更改！
--音乐设备名
BGMDevice   =  0x101
SEDevice    =  0x102
--@@@@@@@@@@@@@@@@@@@@@@@结束@@@@@@@@@@@@@@@@@@@@@@@@@




MusicStop   = 0x110
MusicOpen   = 0x111
MusicPause  = 0x112
MusicPlay   = 0x113

seMusicStopStatus   = 0
seMusicPauseStatus  = 0
bgmMusicStopStatus  = 0
bgmMusicPauseStatus = 0

ForcedSwitch   = 0x201
EndSwitch      = 0x202




--#######################开始#########################
--警告：以下部分为引擎数据，不可更改！
--界面焦点
WM_SETFOCUS  = 0x0007 --获得焦点
WM_KILLFOCUS = 0x0008 --失去焦点
WinFocus = WM_SETFOCUS



--程序定义
--助手右值绝对不可更改！！！！！！！
GirlsAssistant = 0x000
BoysAssistant = 0x001


--快捷键设置值，可修改
ShortcutKey1 = 1
ShortcutKey2 = 2


--检测快捷键盘的值，无需修改
DetectShortcutKey1 = ShortcutKey1+1
DetectShortcutKey2 = ShortcutKey2+1

--通用函数定义区域
function GetBitNum(Num, Bit)
	local StrGCNum = tostring(Num);
	return tonumber(string.sub(StrGCNum,Bit,Bit));
end

--全局变量
-- 抽奖所需要的金币数量
LotteryGoldSpend = 25
-- 需要的金币数量
BigBombNeeds = 15
-- 需要的金币数量
AssistantPropsNeeds = 30 

--C++程序接口
--SetViewIamgePath(界面,"路劲", "画图函数名()", "Image_数值");   @加载图片
--LuaDrawImage                                            @此函数已封装，不可单独使用
--KeyDetect(按键值);                                      @检测目标按键状态，==0 表示一直未被操作过
--MouseDetect(起始X, 起始Y, 终止X, 终止Y);                @检测鼠标在此区域的操作状态， ==0 表示未进入此区域
--GetMouseStatus();                                       @获取鼠标当前状态，无参数
--MessageBox("内容","标题",按钮值);                       @弹出MessageBox
--PlayMusic(设备名,"wav音乐路劲");                        @播放音乐
--StopMusic(设备名);                                      @停止指定设备名所播放的音乐
--PlayToPauseMusic(设备名);                               @暂停播放指定设备名所播放的音乐
--PauseToPlayMusic(设备名);                               @恢复播放指定设备名所播放的音乐
--SetMusicVol(设备名, 音量大小);                          @音量设置函数，范围为0~100
--ReleaseImageData(界面);                                 @释放已加载的某界面的图片资源
--SetNowWindowView(界面);                                 @设置当前的界面位置











