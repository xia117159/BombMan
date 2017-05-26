




function StartViewKC()
	
	
	
	Result = 0;
	--剧情模式按钮事件
	if DetectMousePos(ksButton) == 1 then
		
		NotReSetButton(1);
		
		Result = GetMouseStatus();
		if Result == MouseHover then --鼠标左键悬停
			ksButton:setImagePos(ButtonWidth, ButtonWidth*2, ButtonHeight*0, ButtonHeight*1);
		elseif Result == MouseLeftDown then --鼠标左键按下
			ksButton:setImagePos(ButtonWidth*2, ButtonWidth*3, ButtonHeight*0, ButtonHeight*1);
		elseif Result == MouseLeftUp then --鼠标左键松开
			ksButton:setImagePos(0, ButtonWidth, ButtonHeight*0, ButtonHeight*1);
		end
	--挑战模式按钮事件
	elseif DetectMousePos(tzButton) == 1 then
		NotReSetButton(2);
		Result = GetMouseStatus();
		if Result == MouseHover then --鼠标左键悬停
			tzButton:setImagePos(ButtonWidth, ButtonWidth*2, ButtonHeight*1, ButtonHeight*2);
		elseif Result == MouseLeftDown then --鼠标左键按下
			tzButton:setImagePos(ButtonWidth*2, ButtonWidth*3, ButtonHeight*1, ButtonHeight*2);

			tzButton["Event"] = 1;
		elseif Result == MouseLeftUp then --鼠标左键松开
			tzButton:setImagePos(0, ButtonWidth, ButtonHeight*1, ButtonHeight*2);
			if tzButton["Event"] == 1 then
				tzButton["Event"] = 0;

			end
		end
	--道具商城按钮事件
	elseif DetectMousePos(djButton) == 1 then
		NotReSetButton(3);
		Result = GetMouseStatus();
		if Result == MouseHover then --鼠标左键悬停
			djButton:setImagePos(ButtonWidth, ButtonWidth*2, ButtonHeight*2, ButtonHeight*3);
		elseif Result == MouseLeftDown then --鼠标左键按下
			djButton:setImagePos(ButtonWidth*2, ButtonWidth*3, ButtonHeight*2, ButtonHeight*3);
			djButton["Event"] = 1;
		elseif Result == MouseLeftUp then --鼠标左键松开
			djButton:setImagePos(0, ButtonWidth, ButtonHeight*2, ButtonHeight*3);
			if djButton["Event"] == 1 then
				djButton["Event"] = 0;

				goShopView();
			end
		end
		
	--游戏帮助按钮事件
	elseif DetectMousePos(bzButton) == 1 then
		NotReSetButton(4);
		Result = GetMouseStatus();
		if Result == MouseHover then --鼠标左键悬停
			bzButton:setImagePos(ButtonWidth, ButtonWidth*2, ButtonHeight*3, ButtonHeight*4);
		elseif Result == MouseLeftDown then --鼠标左键按下
			bzButton:setImagePos(ButtonWidth*2, ButtonWidth*3, ButtonHeight*3, ButtonHeight*4);
			bzButton["Event"] = 1;
		elseif Result == MouseLeftUp then --鼠标左键松开
			bzButton:setImagePos(0, ButtonWidth, ButtonHeight*3, ButtonHeight*4);
			if bzButton["Event"] == 1 then
				bzButton["Event"] = 0;
				
			end
		end
	--
	elseif DetectMousePos(cdButton) == 1 then
		NotReSetButton(5);
		Result = GetMouseStatus();
		if Result == MouseHover then --鼠标左键悬停
			cdButton:setImagePos(ButtonWidth, ButtonWidth*2, ButtonHeight*4, ButtonHeight*5);
		elseif Result == MouseLeftDown then --鼠标左键按下
			cdButton:setImagePos(ButtonWidth*2, ButtonWidth*3, ButtonHeight*4, ButtonHeight*5);
			cdButton["Event"] = 1;
		elseif Result == MouseLeftUp then --鼠标左键松开
			cdButton:setImagePos(0, ButtonWidth, ButtonHeight*4, ButtonHeight*5);
			if cdButton["Event"] == 1 then
				cdButton["Event"] = 0;
				
			end
		end
	--
	elseif DetectMousePos(tcButton) == 1 then
		NotReSetButton(6);
		Result = GetMouseStatus();
		if Result == MouseHover then --鼠标左键悬停
			tcButton:setImagePos(ButtonWidth, ButtonWidth*2, ButtonHeight*5, ButtonHeight*6);
		elseif Result == MouseLeftDown then --鼠标左键按下
			tcButton:setImagePos(ButtonWidth*2, ButtonWidth*3, ButtonHeight*5, ButtonHeight*6);
			tcButton["Event"] = 1;
		elseif Result == MouseLeftUp then --鼠标左键松开
			tcButton:setImagePos(0, ButtonWidth, ButtonHeight*5, ButtonHeight*6);
			if tcButton["Event"] == 1 then
				tcButton["Event"] = 0;
				
			end
		end
	elseif Result == 0 then
		GetMouseStatus();
		NotReSetButton(0);
	end
end



--跳转商城页面并进行相关设置的函数
function goShopView()
	
	ReleaseImageData();--清除图片资源以便目标页面加载
	LoadShopImageFile();--加载商城界面
	NowView = ShopV;--设置视图位于商城
end

function NotReSetButton(TempB)
	if TempB ~= 1 then
		ksButton:setImagePos(0, ButtonWidth, ButtonHeight*0, ButtonHeight*1);
	end
	
	if TempB ~= 2 then
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


