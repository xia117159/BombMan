

math.randomseed(os.time()); --����ʱ������


--#######################��ʼ#########################
----���棺���²���Ϊ�������ݣ����ɸ��ģ�

--MessageBox ѡ�ťѡ��
MB_OK                    =   0x00000000
MB_OKCANCEL              =   0x00000001
MB_ABORTRETRYIGNORE      =   0x00000002
MB_YESNOCANCEL           =   0x00000003
MB_YESNO                 =   0x00000004
MB_RETRYCANCEL           =   0x00000005

--MessageBox ����ֵ
IDOK       =         1
IDCANCEL   =         2
IDABORT    =         3
IDRETRY    =         4
IDIGNORE   =         5
IDYES      =         6
IDNO       =         7
--@@@@@@@@@@@@@@@@@@@@@@@����@@@@@@@@@@@@@@@@@@@@@@@@@



--#######################��ʼ#########################
--���棺���²���Ϊ�������ݣ����������ӵ�19
--��ͼλ��
NowView    =   0x0000
StartV     =   0x0000
PlotV      =   0x0001
ChallengeV =   0x0002
ShopV      =   0x0003
BackpackV  =   0x0004


LoadV      =   0x0019

--�ܵ�ͼƬ����
AllImageNum = 31
NowLoadPos = 1
NextLoadPos = 1
--@@@@@@@@@@@@@@@@@@@@@@@����@@@@@@@@@@@@@@@@@@@@@@@@@


--#######################��ʼ#########################
--���棺���²���Ϊ�������ݣ����ɸ��ģ�
--����״̬
KeepPressing  = 101  --һֱ����
Press         = 102  --���µ���һ˲��
Release       = 103  --�ɿ�����һ˲��
--@@@@@@@@@@@@@@@@@@@@@@@����@@@@@@@@@@@@@@@@@@@@@@@@@



--����ֵ�趨���ı����ã�
Up    =  0x11   --W
Down  =  0x1F   --S
Left  =  0x1E   --A
Right =  0x20   --D

--#######################��ʼ#########################
--���棺���²���Ϊ�������ݣ����ɸ��ģ�
--���״̬
MouseLeftDown  = 0x01   --����������
MouseLeftUp    = 0x02   --�������ɿ�
MouseRightDown = 0x03   --����Ҽ�����
MouseRightUp   = 0x04   --�������ɿ�
MouseHover     = 0x05   --�����ͣ

MousePosX      = 0      --��굱ǰXλ��
MousePosY      = 0		--��굱ǰYλ��
--@@@@@@@@@@@@@@@@@@@@@@@����@@@@@@@@@@@@@@@@@@@@@@@@@


LastMouseDownPosX = 0;  --��һ����갴��ʱ��Xλ��
LastMouseDownPosY = 0;	--��һ����갴��ʱ��Yλ��
MouseStatus = 0x00

--#######################��ʼ#########################
--���棺���²���Ϊ�������ݣ����ɸ��ģ�
--�����豸��
BGMDevice   =  0x101
SEDevice    =  0x102
--@@@@@@@@@@@@@@@@@@@@@@@����@@@@@@@@@@@@@@@@@@@@@@@@@




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




--#######################��ʼ#########################
--���棺���²���Ϊ�������ݣ����ɸ��ģ�
--���潹��
WM_SETFOCUS  = 0x0007 --��ý���
WM_KILLFOCUS = 0x0008 --ʧȥ����
WinFocus = WM_SETFOCUS



--������
--������ֵ���Բ��ɸ��ģ�������������
GirlsAssistant = 0x000
BoysAssistant = 0x001


--��ݼ�����ֵ�����޸�
ShortcutKey1 = 1
ShortcutKey2 = 2


--����ݼ��̵�ֵ�������޸�
DetectShortcutKey1 = ShortcutKey1+1
DetectShortcutKey2 = ShortcutKey2+1

--ͨ�ú�����������
function GetBitNum(Num, Bit)
	local StrGCNum = tostring(Num);
	return tonumber(string.sub(StrGCNum,Bit,Bit));
end

--ȫ�ֱ���
-- �齱����Ҫ�Ľ������
LotteryGoldSpend = 25
-- ��Ҫ�Ľ������
BigBombNeeds = 15
-- ��Ҫ�Ľ������
AssistantPropsNeeds = 30 

--C++����ӿ�
--SetViewIamgePath(����,"·��", "��ͼ������()", "Image_��ֵ");   @����ͼƬ
--LuaDrawImage                                            @�˺����ѷ�װ�����ɵ���ʹ��
--KeyDetect(����ֵ);                                      @���Ŀ�갴��״̬��==0 ��ʾһֱδ��������
--MouseDetect(��ʼX, ��ʼY, ��ֹX, ��ֹY);                @�������ڴ�����Ĳ���״̬�� ==0 ��ʾδ���������
--GetMouseStatus();                                       @��ȡ��굱ǰ״̬���޲���
--MessageBox("����","����",��ťֵ);                       @����MessageBox
--PlayMusic(�豸��,"wav����·��");                        @��������
--StopMusic(�豸��);                                      @ָֹͣ���豸�������ŵ�����
--PlayToPauseMusic(�豸��);                               @��ͣ����ָ���豸�������ŵ�����
--PauseToPlayMusic(�豸��);                               @�ָ�����ָ���豸�������ŵ�����
--SetMusicVol(�豸��, ������С);                          @�������ú�������ΧΪ0~100
--ReleaseImageData(����);                                 @�ͷ��Ѽ��ص�ĳ�����ͼƬ��Դ
--SetNowWindowView(����);                                 @���õ�ǰ�Ľ���λ��











