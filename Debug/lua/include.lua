
--���棺win32 �Դ���MessageBox���û�û��ȷ�ϵ�����»���ɳ�����ͣ����
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


--��ͼλ��
NowView    =   0x1001
StartV     =   0x1001
ChallengeV =   0x1002
ShopV      =   0x1003

--����״̬
KeepPressing  = 101  --һֱ����
Press         = 102  --���µ���һ˲��
Release       = 103  --�ɿ�����һ˲��

--����ֵ�趨���ı����ã�
Up    =  0x11   --W
Down  =  0x1F   --S
Left  =  0x1E   --A
Right =  0x20   --D


--���״̬
MouseLeftDown  = 0x01   --����������
MouseLeftUp    = 0x02   --�������ɿ�
MouseRightDown = 0x03   --����Ҽ�����
MouseRightUp   = 0x04   --�������ɿ�
MouseHover     = 0x05   --�����ͣ


MousePosX      = 0      --��굱ǰXλ��
MousePosY      = 0		--��굱ǰYλ��


--C++����ӿ�
--SetViewIamgePath("·��", "��ͼ������()", "Image_��ֵ"); @����ͼƬ
--LuaDrawImage                                            @�˺����ѷ�װ�����ɵ���ʹ��
--KeyDetect(����ֵ);                                      @���Ŀ�갴��״̬��==0 ��ʾһֱδ��������
--MouseDetect(��ʼX, ��ʼY, ��ֹX, ��ֹY);                @�������ڴ�����Ĳ���״̬�� ==0 ��ʾδ���������
--GetMouseStatus();                                       @��ȡ��굱ǰ״̬���޲���
--MessageBox("����","����",��ťֵ);                       @����MessageBox
--PlayMusic("wav����·��");                               @��������
--ReleaseImageData();                                     @�ͷŵ�ǰ�Ѽ��ص�ͼƬ��Դ











