





function ShopViewKC()
	--[[if KeyDetect(Right) == KeepPressing then
		ksButton:setRelativelyStartPos(CharacterRate, 0.0);
	end--]]
	Result = 0;
	if DetectMousePos(ShopReturnButton) == 1 then
		
		NotReSetShopButton(1);
		
		Result = GetMouseStatus();
		if Result == MouseHover then --Êó±ê×ó¼üÐüÍ£
			ShopReturnButton:setImagePos(174, 174*2, 0, 174);
		elseif Result == MouseLeftDown then --Êó±ê×ó¼ü°´ÏÂ
			ShopReturnButton["Event"] = 1;
			ShopReturnButton:setImagePos(174*2, 174*3, 0, 174);
		elseif Result == MouseLeftUp then --Êó±ê×ó¼üËÉ¿ª
			ShopReturnButton:setImagePos(0, 174, 0, 174);
			if ShopReturnButton["Event"] == 1 then
				ShopReturnButton["Event"] = 0;
				goStartView();
			end
		end
	elseif DetectMousePos(ShopBigBombProps) == 1 then
		
		NotReSetShopButton(2);
		
		Result = GetMouseStatus();
		if Result == MouseHover then --Êó±ê×ó¼üÐüÍ£
			ShopBigBombProps:setImagePos(233, 223*2, 174, 421);
		elseif Result == MouseLeftDown then --Êó±ê×ó¼ü°´ÏÂ
			ShopBigBombProps["Event"] = 1;
			ShopBigBombPropsTemp["DrawStatus"] = 1;
			ShopBigBombProps:setImagePos(0, 210, 174, 421);
		elseif Result == MouseLeftUp then --Êó±ê×ó¼üËÉ¿ª
			ShopBigBombProps:setImagePos(0, 174, 0, 174);
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
		GetMouseStatus();
		NotReSetShopButton(0);
	end
end	

function NotReSetShopButton(value)
	if value ~= 1 then
		ShopReturnButton:setImagePos(0, 174, 0, 174);
	end
	if value ~= 2 then
		ShopBigBombProps:setImagePos(0, 210, 174, 421);
	end
end