
StartViewButtonSe = seMusicClass:new();
StartViewButtonSe:SetMusicData("music/ButtonSE2.wav");


function StartViewKC()
	
	Result = 0;
	--剧情模式按钮事件
	if DetectMousePos(ksButton) == 1 then
		ButtonEvent(1, ksButton, goPlotView);

	--挑战模式按钮事件
	elseif DetectMousePos(tzButton) == 1 then
		ButtonEvent(2, tzButton, goChallengeView);

	--道具商城按钮事件
	elseif DetectMousePos(djButton) == 1 then
		ButtonEvent(3, djButton, goShopView);

	
	--游戏帮助按钮事件
	elseif DetectMousePos(bzButton) == 1 then
		ButtonEvent(4, bzButton, goHelpView);
		
	--游戏存档按钮事件
	elseif DetectMousePos(cdButton) == 1 then
		ButtonEvent(5, cdButton, goSaveView);
		
	--退出游戏按钮事件
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
	if Result == MouseHover then --鼠标左键悬停
		if ButtonClass["Hover"] == 0 then
			ButtonClass["Hover"] = 1;
			StartViewButtonSe:Play();
		end
		ButtonClass:setImagePos(ButtonWidth, ButtonWidth*2, ButtonHeight*(Num - 1), ButtonHeight*Num);
	elseif Result == MouseLeftDown then --鼠标左键按下
		ButtonClass:setImagePos(ButtonWidth*2, ButtonWidth*3, ButtonHeight*(Num - 1), ButtonHeight*Num);
		ButtonClass["Event"] = 1;
	elseif Result == MouseLeftUp then --鼠标左键松开
		ButtonClass:setImagePos(0, ButtonWidth, ButtonHeight*(Num - 1), ButtonHeight*Num);
		if ButtonClass["Event"] == 1 then
			ButtonClass["Event"] = 0;
			Gamebgm:Play(ForcedSwitch);--强制切换背景音乐
			GoFunc();
		end
	end
end
--跳转开始画面页面并进行相关设置的函数
function goStartView()
	
	SetNowWindowView(StartV);
	NowView = StartV;--设置视图位于商城
end

--跳转剧情模式页面并进行相关设置的函数
function goPlotView()

	SetNowWindowView(PlotV);
	IintMapData();
	NowView = PlotV;--设置视图位于商城
end


--跳转挑战模式页面并进行相关设置的函数
function goChallengeView()
	
	---加载商城界面自行添加
	--NowView = ShopV;--设置视图位于商城
end


--跳转商城页面并进行相关设置的函数
function goShopView()
	SetNowWindowView(ShopV);
	NowView = ShopV;--设置视图位于商城
end


--跳转帮助页面并进行相关设置的函数
function goHelpView()
	
	--加载商城界面
	--NowView = ShopV;--设置视图位于商城
end


--跳转商城页面并进行相关设置的函数
function goSaveView()
	
	--加载商城界面
	--NowView = ShopV;--设置视图位于商城
end


--退出程序并进行相关设置的函数
function goEndView()
	Exit();
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


