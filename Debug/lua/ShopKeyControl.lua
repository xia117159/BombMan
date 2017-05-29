


ShoptViewRBse = seMusicClass:new();
ShoptViewRBse:SetMusicData("music/ButtonSE1.wav");
ShoptViewPropsse = seMusicClass:new();
ShoptViewPropsse:SetMusicData("music/ButtonSE3.wav");

function ShopViewKC()
	--[[if KeyDetect(Right) == KeepPressing then
		ksButton:setRelativelyStartPos(CharacterRate, 0.0);
	end--]]
	Result = 0;
	if DetectMousePos(ShopReturnButton) == 1 then
		
		NotReSetShopButton(1);
		
		Result = GetMouseStatus();
		if Result == MouseHover then --Êó±ê×ó¼üÐüÍ£
			ShopReturnButton:setImagePos(173.7, 173.7*2, 0, 172);
			if ShopReturnButton["Hover"] == 0 then
				ShopReturnButton["Hover"] = 1;
				ShoptViewRBse:Play();
			end
			
		elseif Result == MouseLeftDown then --Êó±ê×ó¼ü°´ÏÂ
			ShopReturnButton["Event"] = 1;
			ShopReturnButton:setImagePos(173.7*2, 173.7*3, 0, 172);
		elseif Result == MouseLeftUp then --Êó±ê×ó¼üËÉ¿ª
			ShopReturnButton:setImagePos(0, 173.7, 0, 172);
			if ShopReturnButton["Event"] == 1 then
				ShopReturnButton["Event"] = 0;
				Gamebgm:Play(ForcedSwitch);
				goStartView();
			end
		end
	elseif DetectMousePos(ShopBigBombProps) == 1 then
		
		NotReSetShopButton(2);
		
		Result = GetMouseStatus();
		if Result == MouseHover then --Êó±ê×ó¼üÐüÍ£
			ShopBigBombProps:setImagePos(BigBombPropsW*1+5, BigBombPropsW*2+5, 0, BigBombPropsH);
			
			if ShopBigBombProps["Hover"] == 0 then
				ShopBigBombProps["Hover"] = 1;
				ShopBigBombIntr["DrawStatus"] = 1;
				ShoptViewPropsse:Play();
			end
		elseif Result == MouseLeftDown then --Êó±ê×ó¼ü°´ÏÂ
			ShopBigBombProps["Event"] = 1;
			ShopBigBombPropsTemp["DrawStatus"] = 1;
			ShopBigBombIntr["DrawStatus"] = 0;
			ShopBigBombProps:setImagePos(BigBombPropsW*0, BigBombPropsW*1, 0, BigBombPropsH);
		elseif Result == MouseLeftUp then --Êó±ê×ó¼üËÉ¿ª
			ShopBigBombProps:setImagePos(BigBombPropsW*0, BigBombPropsW*1, 0, BigBombPropsH);
			ShopBigBombPropsTemp["DrawStatus"] = 0;
			if ShopBigBombProps["Event"] == 1 then
				ShopBigBombProps["Event"] = 0;
			end
		end
	else
		Result = GetMouseStatus();
		if Result == MouseLeftUp then
			ShopBigBombPropsTemp["DrawStatus"] = 0;
		end
		ShopBigBombIntr["DrawStatus"] = 0;
		GetMouseStatus();
		NotReSetShopButton(0);
	end
	--[[local RResult = KeyDetect(Right);
	local uResult = KeyDetect(Up);
	if RResult == KeepPressing then
		ShopReturnButton:setRelativelyStartPos(1, 0.0);
	end
	if uResult == KeepPressing then
		ShopReturnButton:setRelativelyStartPos(0.0, 1);
	end--]]
end	

function NotReSetShopButton(value)
	if value ~= 1 then
		ShopReturnButton:setImagePos(0, 173.7, 0, 172);
		ShopReturnButton["Hover"] = 0;
	end
	if value ~= 2 then
		ShopBigBombProps["Hover"] = 0;
		ShopBigBombProps:setImagePos(0, BigBombPropsW, 0, BigBombPropsH);
	end
end