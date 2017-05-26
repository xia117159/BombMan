
--警告：win32 自带的MessageBox在用户没有确认的情况下会造成程序暂停运行
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


--视图位置
NowView    =   0x1001
StartV     =   0x1001
ChallengeV =   0x1002
ShopV      =   0x1003

--按键状态
KeepPressing  = 101  --一直按下
Press         = 102  --按下的那一瞬间
Release       = 103  --松开的那一瞬间

--按键值设定，改变无用！
Up    =  0x11   --W
Down  =  0x1F   --S
Left  =  0x1E   --A
Right =  0x20   --D


--鼠标状态
MouseLeftDown  = 0x01   --鼠标左键按下
MouseLeftUp    = 0x02   --鼠标左键松开
MouseRightDown = 0x03   --鼠标右键按下
MouseRightUp   = 0x04   --鼠标左键松开
MouseHover     = 0x05   --鼠标悬停


MousePosX      = 0      --鼠标当前X位置
MousePosY      = 0		--鼠标当前Y位置


--C++程序接口
--SetViewIamgePath("路劲", "画图函数名()", "Image_数值"); @加载图片
--LuaDrawImage                                            @此函数已封装，不可单独使用
--KeyDetect(按键值);                                      @检测目标按键状态，==0 表示一直未被操作过
--MouseDetect(起始X, 起始Y, 终止X, 终止Y);                @检测鼠标在此区域的操作状态， ==0 表示未进入此区域
--GetMouseStatus();                                       @获取鼠标当前状态，无参数
--MessageBox("内容","标题",按钮值);                       @弹出MessageBox
--PlayMusic("wav音乐路劲");                               @播放音乐
--ReleaseImageData();                                     @释放当前已加载的图片资源











