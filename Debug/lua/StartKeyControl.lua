
StartViewButtonSe = seMusicClass:new();
StartViewButtonSe:SetMusicData("music/ButtonSE2.wav");


function StartViewKC()
	
	Result = 0;
	--����ģʽ��ť�¼�
	if DetectMousePos(ksButton) == 1 then
		ButtonEvent(1, ksButton, goPlotView);

	--��սģʽ��ť�¼�
	elseif DetectMousePos(tzButton) == 1 then
		ButtonEvent(2, tzButton, goChallengeView);

	--�����̳ǰ�ť�¼�
	elseif DetectMousePos(djButton) == 1 then
		ButtonEvent(3, djButton, goShopView);

	
	--��Ϸ������ť�¼�
	elseif DetectMousePos(bzButton) == 1 then
		ButtonEvent(4, bzButton, goHelpView);
		
	--��Ϸ�浵��ť�¼�
	elseif DetectMousePos(cdButton) == 1 then
		ButtonEvent(5, cdButton, goSaveView);
		
	--�˳���Ϸ��ť�¼�
	elseif DetectMousePos(tcButton) == 1 then
		ButtonEvent(6, tcButton, goEndView);
		
	elseif Result == 0 then

		GetMouseStatus();
		NotReSetButton(0);
	end
end




function ButtonEvent(Num, ButtonClass, GoFunc)
	NotReSetButton(Num);
	Result = GetMouseStatus();
	if Result == MouseHover then --��������ͣ
		if ButtonClass["Hover"] == 0 then
			ButtonClass["Hover"] = 1;
			StartViewButtonSe:Play();
		end
		ButtonClass:setImagePos(ButtonWidth, ButtonWidth*2, ButtonHeight*(Num - 1), ButtonHeight*Num);
	elseif Result == MouseLeftDown then --����������
		ButtonClass:setImagePos(ButtonWidth*2, ButtonWidth*3, ButtonHeight*(Num - 1), ButtonHeight*Num);
		ButtonClass["Event"] = 1;
	elseif Result == MouseLeftUp then --�������ɿ�
		ButtonClass:setImagePos(0, ButtonWidth, ButtonHeight*(Num - 1), ButtonHeight*Num);
		if ButtonClass["Event"] == 1 then
			ButtonClass["Event"] = 0;
			Gamebgm:Play(ForcedSwitch);--ǿ���л���������
			GoFunc();
		end
	end
end
--��ת��ʼ����ҳ�沢����������õĺ���
function goStartView()
	
	ReleaseImageData();--���ͼƬ��Դ�Ա�Ŀ��ҳ�����
	LoadStartViewImageFile();--���ؿ�ʼ����
	NowView = StartV;--������ͼλ�ڿ�ʼ����
end

--��ת����ģʽҳ�沢����������õĺ���
function goPlotView()
	
	ReleaseImageData();--���ͼƬ��Դ�Ա�Ŀ��ҳ�����
	LoadMapViewImageFile()--�����̳ǽ����������
	NowView = PlotV;--������ͼλ���̳�
end


--��ת��սģʽҳ�沢����������õĺ���
function goChallengeView()
	
	--ReleaseImageData();--���ͼƬ��Դ�Ա�Ŀ��ҳ�����
	---�����̳ǽ����������
	--NowView = ShopV;--������ͼλ���̳�
end


--��ת�̳�ҳ�沢����������õĺ���
function goShopView()
	
	ReleaseImageData();--���ͼƬ��Դ�Ա�Ŀ��ҳ�����
	LoadShopImageFile();--�����̳ǽ���
	NowView = ShopV;--������ͼλ���̳�
end


--��ת����ҳ�沢����������õĺ���
function goHelpView()
	
	--ReleaseImageData();--���ͼƬ��Դ�Ա�Ŀ��ҳ�����
	--�����̳ǽ���
	--NowView = ShopV;--������ͼλ���̳�
end


--��ת�̳�ҳ�沢����������õĺ���
function goSaveView()
	
	--ReleaseImageData();--���ͼƬ��Դ�Ա�Ŀ��ҳ�����
	--�����̳ǽ���
	--NowView = ShopV;--������ͼλ���̳�
end


--�˳����򲢽���������õĺ���
function goEndView()
	Exit();
	--ReleaseImageData();--���ͼƬ��Դ�Ա�Ŀ��ҳ�����
	--�����̳ǽ���
	--NowView = ShopV;--������ͼλ���̳�
end

function NotReSetButton(TempB)
	if TempB ~= 1 then
		ksButton["Hover"] = 0;
		ksButton:setImagePos(0, ButtonWidth, ButtonHeight*0, ButtonHeight*1);
	end
	
	if TempB ~= 2 then
		tzButton["Hover"] = 0;
		tzButton:setImagePos(0, ButtonWidth, ButtonHeight*1, ButtonHeight*2);
	end
	
	if TempB ~= 3 then
		djButton["Hover"] = 0;
		djButton:setImagePos(0, ButtonWidth, ButtonHeight*2, ButtonHeight*3);
	end
	
	if TempB ~= 4 then
		bzButton["Hover"] = 0;
		bzButton:setImagePos(0, ButtonWidth, ButtonHeight*3, ButtonHeight*4);
	end
	
	if TempB ~= 5 then
		cdButton["Hover"] = 0;
		cdButton:setImagePos(0, ButtonWidth, ButtonHeight*4, ButtonHeight*5);
	end
	
	if TempB ~= 6 then
		tcButton["Hover"] = 0;
		tcButton:setImagePos(0, ButtonWidth, ButtonHeight*5, ButtonHeight*6);
	end
end


