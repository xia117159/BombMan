




function StartViewKC()
	
	
	
	Result = 0;
	--����ģʽ��ť�¼�
	if DetectMousePos(ksButton) == 1 then
		
		NotReSetButton(1);
		
		Result = GetMouseStatus();
		if Result == MouseHover then --��������ͣ
			if ksButton["Hover"] == 0 then
				ksButton["Hover"] = 1;
				PlayMusic(SEDevice,"music/StartButtonMHover.wav");
			end
			ksButton:setImagePos(ButtonWidth, ButtonWidth*2, ButtonHeight*0, ButtonHeight*1);
		elseif Result == MouseLeftDown then --����������
			ksButton["Event"] = 1;
			ksButton:setImagePos(ButtonWidth*2, ButtonWidth*3, ButtonHeight*0, ButtonHeight*1);
		elseif Result == MouseLeftUp then --�������ɿ�
			ksButton:setImagePos(0, ButtonWidth, ButtonHeight*0, ButtonHeight*1);
			if ksButton["Event"] == 1 then
				ksButton["Event"] = 0;
				goPlotView();
			end
		end
	--��սģʽ��ť�¼�
	elseif DetectMousePos(tzButton) == 1 then
		NotReSetButton(2);
		Result = GetMouseStatus();
		if Result == MouseHover then --��������ͣ
			if tzButton["Hover"] == 0 then
				tzButton["Hover"] = 1;
				PlayMusic(SEDevice,"music/StartButtonMHover.wav");
			end
			tzButton:setImagePos(ButtonWidth, ButtonWidth*2, ButtonHeight*1, ButtonHeight*2);
		elseif Result == MouseLeftDown then --����������
			tzButton:setImagePos(ButtonWidth*2, ButtonWidth*3, ButtonHeight*1, ButtonHeight*2);

			tzButton["Event"] = 1;
		elseif Result == MouseLeftUp then --�������ɿ�
			tzButton:setImagePos(0, ButtonWidth, ButtonHeight*1, ButtonHeight*2);
			if tzButton["Event"] == 1 then
				tzButton["Event"] = 0;
				goChallengeView();
			end
		end
	--�����̳ǰ�ť�¼�
	elseif DetectMousePos(djButton) == 1 then
		NotReSetButton(3);
		Result = GetMouseStatus();
		if Result == MouseHover then --��������ͣ
			djButton:setImagePos(ButtonWidth, ButtonWidth*2, ButtonHeight*2, ButtonHeight*3);
		elseif Result == MouseLeftDown then --����������
			djButton:setImagePos(ButtonWidth*2, ButtonWidth*3, ButtonHeight*2, ButtonHeight*3);
			djButton["Event"] = 1;
		elseif Result == MouseLeftUp then --�������ɿ�
			djButton:setImagePos(0, ButtonWidth, ButtonHeight*2, ButtonHeight*3);
			if djButton["Event"] == 1 then
				djButton["Event"] = 0;
				
				goShopView();
			end
		end
	--��Ϸ�浵��ť�¼�
	elseif DetectMousePos(cdButton) == 1 then
		NotReSetButton(5);
		Result = GetMouseStatus();
		if Result == MouseHover then --��������ͣ
			cdButton:setImagePos(ButtonWidth, ButtonWidth*2, ButtonHeight*4, ButtonHeight*5);
		elseif Result == MouseLeftDown then --����������
			cdButton:setImagePos(ButtonWidth*2, ButtonWidth*3, ButtonHeight*4, ButtonHeight*5);
			cdButton["Event"] = 1;
		elseif Result == MouseLeftUp then --�������ɿ�
			cdButton:setImagePos(0, ButtonWidth, ButtonHeight*4, ButtonHeight*5);
			if cdButton["Event"] == 1 then
				cdButton["Event"] = 0;

				goSaveView()
			end
		end	
	--��Ϸ������ť�¼�
	elseif DetectMousePos(bzButton) == 1 then
		NotReSetButton(4);
		Result = GetMouseStatus();
		if Result == MouseHover then --��������ͣ
			bzButton:setImagePos(ButtonWidth, ButtonWidth*2, ButtonHeight*3, ButtonHeight*4);
		elseif Result == MouseLeftDown then --����������
			bzButton:setImagePos(ButtonWidth*2, ButtonWidth*3, ButtonHeight*3, ButtonHeight*4);
			bzButton["Event"] = 1;
		elseif Result == MouseLeftUp then --�������ɿ�
			bzButton:setImagePos(0, ButtonWidth, ButtonHeight*3, ButtonHeight*4);
			if bzButton["Event"] == 1 then
				bzButton["Event"] = 0;

				goHelpView();
			end
		end
	
	--
	elseif DetectMousePos(tcButton) == 1 then
		NotReSetButton(6);
		Result = GetMouseStatus();
		if Result == MouseHover then --��������ͣ
			tcButton:setImagePos(ButtonWidth, ButtonWidth*2, ButtonHeight*5, ButtonHeight*6);
		elseif Result == MouseLeftDown then --����������
			tcButton:setImagePos(ButtonWidth*2, ButtonWidth*3, ButtonHeight*5, ButtonHeight*6);
			tcButton["Event"] = 1;
		elseif Result == MouseLeftUp then --�������ɿ�
			tcButton:setImagePos(0, ButtonWidth, ButtonHeight*5, ButtonHeight*6);
			if tcButton["Event"] == 1 then
				tcButton["Event"] = 0;
				goEndView();
			end
		end
	elseif Result == 0 then
		
		
		GetMouseStatus();
		NotReSetButton(0);
	end
end

--��ת��ʼ����ҳ�沢����������õĺ���
function goStartView()
	
	ReleaseImageData();--���ͼƬ��Դ�Ա�Ŀ��ҳ�����
	LoadStartViewImageFile();--�����̳ǽ���
	NowView = StartV;--������ͼλ���̳�
end

--��ת����ģʽҳ�沢����������õĺ���
function goPlotView()
	
	--ReleaseImageData();--���ͼƬ��Դ�Ա�Ŀ��ҳ�����
	--�����̳ǽ����������
	--NowView = ShopV;--������ͼλ���̳�
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
		djButton:setImagePos(0, ButtonWidth, ButtonHeight*2, ButtonHeight*3);
	end
	
	if TempB ~= 4 then
		bzButton:setImagePos(0, ButtonWidth, ButtonHeight*3, ButtonHeight*4);
	end
	
	if TempB ~= 5 then
		cdButton:setImagePos(0, ButtonWidth, ButtonHeight*4, ButtonHeight*5);
	end
	
	if TempB ~= 6 then
		tcButton:setImagePos(0, ButtonWidth, ButtonHeight*5, ButtonHeight*6);
	end
end


