


ShoptViewRBse = seMusicClass:new();
ShoptViewRBse:SetMusicData("music/ButtonSE1.wav");
ShoptViewPropsse = seMusicClass:new();
ShoptViewPropsse:SetMusicData("music/ButtonSE3.wav");

ShopViewBuy = seMusicClass:new();
ShopViewBuy:SetMusicData("music/ButtonSE4.wav");
function ShopViewKC()
	--[[if KeyDetect(Right) == KeepPressing then
		ksButton:setRelativelyStartPos(CharacterRate, 0.0);
	end--]]
	Result = 0;
	
	--返回键区域
	if DetectMousePos(ShopReturnButton) == 1 then
		
		NotReSetShopButton(1);
		
		Result = GetMouseStatus();
		if Result == MouseHover then --鼠标左键悬停
			ShopReturnButton:setImagePos(173.7, 173.7*2, 0, 172);
			if ShopReturnButton["Hover"] == 0 then
				ShopReturnButton["Hover"] = 1;
				ShoptViewRBse:Play();
			end
			
		elseif Result == MouseLeftDown then --鼠标左键按下
			ShopReturnButton["Event"] = 1;
			ShopReturnButton:setImagePos(173.7*2, 173.7*3, 0, 172);
		elseif Result == MouseLeftUp then --鼠标左键松开
			ShopReturnButton:setImagePos(0, 173.7, 0, 172);
			if ShopReturnButton["Event"] == 1 then
				ShopReturnButton["Event"] = 0;
				Gamebgm:Play(ForcedSwitch);
				goStartView();
			end
		end
		
	--超级炸弹图标区域
	elseif DetectMousePos(ShopBigBombProps) == 1 then
		
		NotReSetShopButton(2);
		
		Result = GetMouseStatus();
		if Result == MouseHover then --鼠标左键悬停
			ShopBigBombProps:setImagePos(PropsW*1+5, PropsW*2+5, 0, PropsH);
			
			if ShopBigBombProps["Hover"] == 0 then
				ShopBigBombProps["Hover"] = 1;
				ShowPropsIntro(2);
				ShoptViewPropsse:Play();
			end
		elseif Result == MouseLeftDown then --鼠标左键按下
			ShopBigBombProps["Event"] = 1;
			ShopBigBombProps:setImagePos(PropsW*0, PropsW*1, 0, PropsH);
		elseif Result == MouseLeftUp then --鼠标左键松开
			ShopBigBombProps:setImagePos(PropsW*0, PropsW*1, 0, PropsH);
			ShopBigBombPropsTemp["DrawStatus"] = 0;
			if ShopBigBombProps["Event"] == 1 then
				ShopBigBombProps["Event"] = 0;
			end
		end
	--超级炸弹购买按钮
	elseif DetectMousePos(BuyBigBombButton) == 1 then
		NotReSetShopButton(3);
		Result = GetMouseStatus();
		if Result == MouseHover then --鼠标左键悬停
			BuyBigBombButton:setImagePos(0, 320, 146, 146*2);
			
			if BuyBigBombButton["Hover"] == 0 then
				BuyBigBombButton["Hover"] = 1;
				ShopViewBuy:Play();
			end
		elseif Result == MouseLeftDown then --鼠标左键按下
			BuyBigBombButton["Event"] = 1;
			BuyBigBombButton:setImagePos(0, 320, 146*2, 146*3);
		elseif Result == MouseLeftUp then --鼠标左键松开
			BuyBigBombButton:setImagePos(0, 320, 0, 146);
			if BuyBigBombButton["Event"] == 1 then
				BuyBigBombButton["Event"] = 0;
				BuyBigBombEvent();
			end
		end
	--助手图标区域
	elseif DetectMousePos(ShopAssistantPropsProps) == 1 then
		if UserData["AssistantLock"] == 0 then
			NotReSetShopButton(4);
			
			Result = GetMouseStatus();
			if Result == MouseHover then --鼠标左键悬停
				ShopAssistantPropsProps:setImagePos(PropsW*1+5+OnePropsImageW*AssistantProps, PropsW*2+5+OnePropsImageW*AssistantProps, OnePropsImageH+16, PropsH+OnePropsImageH+16);
				
				if ShopAssistantPropsProps["Hover"] == 0 then
					ShopAssistantPropsProps["Hover"] = 1;

					ShowPropsIntro(3);
					ShoptViewPropsse:Play();
				end
			elseif Result == MouseLeftDown then --鼠标左键按下
				ShopAssistantPropsProps["Event"] = 1;
				ShopAssistantPropsProps:setImagePos(PropsW*0+OnePropsImageW*AssistantProps, PropsW*1+OnePropsImageW*AssistantProps, OnePropsImageH+16, PropsH+OnePropsImageH+16);
			elseif Result == MouseLeftUp then --鼠标左键松开
				ShopAssistantPropsProps:setImagePos(PropsW*0+OnePropsImageW*AssistantProps, PropsW*1+OnePropsImageW*AssistantProps, OnePropsImageH+16, PropsH+OnePropsImageH+16);
				ShopAssistantPropsPropsTemp["DrawStatus"] = 0;
				if ShopAssistantPropsProps["Event"] == 1 then
					ShopAssistantPropsProps["Event"] = 0;
				end
			end
		end
	--购买助手按钮区域
	elseif DetectMousePos(BuyAssistantButton) == 1 then
		if UserData["AssistantLock"] == 0 then
			NotReSetShopButton(5);
			Result = GetMouseStatus();
			if Result == MouseHover then --鼠标左键悬停
				BuyAssistantButton:setImagePos(0, 320, 146, 146*2);
				
				if BuyAssistantButton["Hover"] == 0 then
					BuyAssistantButton["Hover"] = 1;
					ShopViewBuy:Play();
				end
			elseif Result == MouseLeftDown then --鼠标左键按下
				BuyAssistantButton["Event"] = 1;
				BuyAssistantButton:setImagePos(0, 320, 146*2, 146*3);
			elseif Result == MouseLeftUp then --鼠标左键松开
				BuyAssistantButton:setImagePos(0, 320, 0, 146);
				if BuyAssistantButton["Event"] == 1 then
					BuyAssistantButton["Event"] = 0;
					BuyAssistantPropsEvent();
				end
			end
		end
	--背包区域
	elseif DetectMousePos(backpack) == 1 then
		NotReSetShopButton(6);
		Result = GetMouseStatus();
		if Result == MouseHover then --鼠标左键悬停
			
			if backpack["Hover"] == 0 then
				backpack["Hover"] = 1;
				backpack :setscaling_ratio(0.23);
				backpack:setImage(890, 45 ,339, 410, 300, 639, 0, 410, ShopPriorityBackPack+0.9);
				ShoptViewPropsse:Play();
			end
		elseif Result == MouseLeftDown then --鼠标左键按下
			backpack["Event"] = 1;
			backpack :setscaling_ratio(0.2);
			backpack:setImage(900, 50 ,300, 410, 0, 300, 0, 410, ShopPriorityBackPack+0.9);
		elseif Result == MouseLeftUp then --鼠标左键松开
			backpack :setscaling_ratio(0.2);
			backpack:setImage(900, 50 ,300, 410, 0, 300, 0, 410, ShopPriorityBackPack+0.9);
			if backpack["Event"] == 1 then
				backpack["Event"] = 0;
				GoBackpackVeiw();
			end
		end
	else
		Result = GetMouseStatus();
		if Result == MouseLeftUp then
			ShopBigBombPropsTemp["DrawStatus"] = 0;
			ShopAssistantPropsPropsTemp["DrawStatus"] = 0;
		end
		GetMouseStatus();
		NotReSetShopButton(0);
	end
	
end	

function NotReSetShopButton(value)

	if value ~= 1 then
		ShopReturnButton:setImagePos(0, 173.7, 0, 172);
		ShopReturnButton["Hover"] = 0;
		
	end
	if value ~= 2 then
		ShopBigBombProps["Hover"] = 0;
		ShopBigBombProps:setImagePos(0, PropsW, 0, PropsH);
	end
	if value ~= 3 then
		BuyBigBombButton["Hover"] = 0;
		BuyBigBombButton:setImagePos(0, 320, 0, 146);
	end
	
	if value ~= 4 then
		ShopAssistantPropsProps["Hover"] = 0;
		ShopAssistantPropsProps:setImagePos(0+OnePropsImageW*AssistantProps, PropsW+OnePropsImageW*AssistantProps, OnePropsImageH+16, PropsH+OnePropsImageH+16);
	end
	if value ~= 5 then
		BuyAssistantButton["Hover"] = 0;
		BuyAssistantButton:setImagePos(0, 320, 0, 146);
	end
	if value ~= 6 then
		backpack["Hover"] = 0;
		backpack :setscaling_ratio(0.2);
		backpack:setImage(900, 50 ,300, 410, 0, 300, 0, 410, ShopPriorityBackPack+0.9);
	end
end



function ShowPropsIntro(value)
	if value == 0 then
		ShopIntroDefault["DrawStatus"] = 1;
		ShopBigBombIntr["DrawStatus"] = 0;
		ShopAssistantPropsPropsIntr["DrawStatus"] = 0;
	elseif value == 2 then
		ShopIntroDefault["DrawStatus"] = 0;
		ShopBigBombIntr["DrawStatus"] = 1;
		ShopAssistantPropsPropsIntr["DrawStatus"] = 0;
	elseif value == 3 then
		ShopIntroDefault["DrawStatus"] = 0;
		ShopBigBombIntr["DrawStatus"] = 0;
		ShopAssistantPropsPropsIntr["DrawStatus"] = 1;
	end
end










function BuyBigBombEvent()
	
	if UserData["GoldCoins"] - BigBombNeeds < 0 then
		
	else
		if UserData["BigBombPropsAmount"]<99 then
			UserData["BigBombPropsAmount"] = UserData["BigBombPropsAmount"] + 1;
			UserData["GoldCoins"] = UserData["GoldCoins"] - BigBombNeeds;
		end
	end
end



function BuyAssistantPropsEvent()
	if UserData["GoldCoins"] - AssistantPropsNeeds < 0 then
		
	else
		if UserData["AssistantPropsAmount"]<99 then
			UserData["AssistantPropsAmount"] = UserData["AssistantPropsAmount"] + 1;
			
			UserData["GoldCoins"] = UserData["GoldCoins"] - AssistantPropsNeeds;
		end
	end
	
end

