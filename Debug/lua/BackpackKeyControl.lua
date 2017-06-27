

MovePropsMem = 0


function bpViewKC()
	--[[if KeyDetect(Right) == KeepPressing then
		ksButton:setRelativelyStartPos(CharacterRate, 0.0);
	end--]]
	
	if bpLRWinStatus == false then
		
		local KeyResult_Esc = KeyDetect(0x01);
		if KeyResult_Esc == Press then
			Gamebgm:Play(ForcedSwitch);
			goShopView();
		end
		
		Result = 0;
		--返回键区域
		if DetectMousePos(bpReturnButton) == 1 then
			NotReSetbpButton(1);	
			Result = GetMouseStatus();
			if Result == MouseHover then --鼠标左键悬停
				bpReturnButton:setImagePos(173.7, 173.7*2, 0, 172);
				if bpReturnButton["Hover"] == 0 then
					bpReturnButton["Hover"] = 1;
					ShoptViewRBse:Play();
				end
				
			elseif Result == MouseLeftDown then --鼠标左键按下
				bpReturnButton["Event"] = 1;
				bpReturnButton:setImagePos(173.7*2, 173.7*3, 0, 172);
			elseif Result == MouseLeftUp then --鼠标左键松开
				bpReturnButton:setImagePos(0, 173.7, 0, 172);
				MovePropsMem = 0;
				bpBigBombPropsTemp["DrawStatus"] = 0;
				bpAssistantPropsPropsTemp["DrawStatus"] = 0;
				if bpReturnButton["Event"] == 1 then
					bpReturnButton["Event"] = 0;
					Gamebgm:Play(ForcedSwitch);
					goShopView();
				end
			end
		--超级炸弹图标区域
		elseif DetectMousePos(bpBigBombProps) == 1 then
			NotReSetbpButton(2);
			Result = GetMouseStatus();
			if Result == MouseHover then --鼠标左键悬停
				bpBigBombProps:setImagePos(PropsW*1+5, PropsW*2+5, 0, PropsH);
				
				if bpBigBombProps["Hover"] == 0 then
					bpBigBombProps["Hover"] = 1;
					ShoptViewPropsse:Play();
				end
			elseif Result == MouseLeftDown then --鼠标左键按下
				bpBigBombProps["Event"] = 1;
				bpBigBombPropsTemp["DrawStatus"] = 1;
				MovePropsMem = 1;
				bpBigBombProps:setImagePos(PropsW*0, PropsW*1, 0, PropsH);
			elseif Result == MouseLeftUp then --鼠标左键松开
				bpBigBombProps:setImagePos(PropsW*0, PropsW*1, 0, PropsH);
				MovePropsMem = 0;
				bpBigBombPropsTemp["DrawStatus"] = 0;
				bpAssistantPropsPropsTemp["DrawStatus"] = 0;
				if bpBigBombProps["Event"] == 1 then
					bpBigBombProps["Event"] = 0;
					
				end
			end
		--助手图标区域
		elseif DetectMousePos(bpAssistantPropsProps) == 1 then
			if UserData["AssistantLock"] == 0 then
				NotReSetbpButton(3);	
				Result = GetMouseStatus();
				if Result == MouseHover then --鼠标左键悬停
					bpAssistantPropsProps:setImagePos(PropsW*1+5+OnePropsImageW*AssistantProps, PropsW*2+5+OnePropsImageW*AssistantProps, OnePropsImageH+16, PropsH+OnePropsImageH+16);
					
					if bpAssistantPropsProps["Hover"] == 0 then
						bpAssistantPropsProps["Hover"] = 1;

						ShoptViewPropsse:Play();
					end
				elseif Result == MouseLeftDown then --鼠标左键按下
					bpAssistantPropsProps["Event"] = 1;
					bpAssistantPropsPropsTemp["DrawStatus"] = 1;
					MovePropsMem = 2;
					bpAssistantPropsProps:setImagePos(PropsW*0+OnePropsImageW*AssistantProps, PropsW*1+OnePropsImageW*AssistantProps, OnePropsImageH+16, PropsH+OnePropsImageH+16);
				elseif Result == MouseLeftUp then --鼠标左键松开
					bpAssistantPropsProps:setImagePos(PropsW*0+OnePropsImageW*AssistantProps, PropsW*1+OnePropsImageW*AssistantProps, OnePropsImageH+16, PropsH+OnePropsImageH+16);
					MovePropsMem = 0;
					bpBigBombPropsTemp["DrawStatus"] = 0;
					bpAssistantPropsPropsTemp["DrawStatus"] = 0;
					if bpAssistantPropsProps["Event"] == 1 then
						bpAssistantPropsProps["Event"] = 0;
						
					end
				end
			end
		--快捷键1区域
		elseif DetectMousePos(bpShortCutBar1) == 1 then
			NotReSetbpButton(3);
			Result = GetMouseStatus();
			if Result == MouseLeftDown then --鼠标左键按下
				bpShortCutBar1["Event"] = 1;
				
			elseif Result == MouseLeftUp then --鼠标左键松开
				bpBigBombPropsTemp["DrawStatus"] = 0;
				bpAssistantPropsPropsTemp["DrawStatus"] = 0;
				if bpShortCutBar1["Event"] == 1 then
					bpShortCutBar1["Event"] = 0;
					
				end
				
				if UserData["ShortCutBarBBP"] == 2 or UserData["ShortCutBarAP"] == 2 then
					bpShortCutBar2:setImagePos(ShortCutBarW*3, ShortCutBarW*4,0, ShortCutBarH);
				end
			
				if MovePropsMem == 1 and UserData["BigBombPropsAmount"] >= 1 then
					MovePropsMem = 0;

					UserData["ShortCutBarBBP"] = 1;
					if UserData["ShortCutBarAP"] == 1 then
						UserData["ShortCutBarAP"] = 0;
						bpAssistantPropsPropsSCB["DrawStatus"] = 0;
					end
				elseif  MovePropsMem == 2 and UserData["AssistantPropsAmount"] >= 1 then
					MovePropsMem = 0;

					UserData["ShortCutBarAP"] = 1;
					if UserData["ShortCutBarBBP"] == 1 then
						UserData["ShortCutBarBBP"] = 0;
						bpBigBombPropsSCB["DrawStatus"] = 0;
					end
				end
			end
		--快捷键2区域
		elseif DetectMousePos(bpShortCutBar2) == 1 then
			NotReSetbpButton(3);
			Result = GetMouseStatus();
			if Result == MouseLeftDown then --鼠标左键按下
				bpShortCutBar2["Event"] = 1;
			elseif Result == MouseLeftUp then --鼠标左键松开
				bpBigBombPropsTemp["DrawStatus"] = 0;
				bpAssistantPropsPropsTemp["DrawStatus"] = 0;
				if bpShortCutBar2["Event"] == 1 then
					bpShortCutBar2["Event"] = 0;
					
				end

				if UserData["ShortCutBarBBP"] == 1 or UserData["ShortCutBarAP"] == 1 then
					bpShortCutBar1:setImagePos(ShortCutBarW*3, ShortCutBarW*4,0, ShortCutBarH);
				end
				
				if MovePropsMem == 1 and UserData["BigBombPropsAmount"] >= 1 then
					MovePropsMem = 0;
					UserData["ShortCutBarBBP"] = 2;
					if UserData["ShortCutBarAP"] == 2 then
						UserData["ShortCutBarAP"] = 0;
						bpAssistantPropsPropsSCB["DrawStatus"] = 0;
					end
				elseif  MovePropsMem == 2  and UserData["AssistantPropsAmount"] >= 1 then
					MovePropsMem = 0;
					UserData["ShortCutBarAP"] = 2;
					if UserData["ShortCutBarBBP"] == 2 then
						UserData["ShortCutBarBBP"] = 0;
						bpBigBombPropsSCB["DrawStatus"] = 0;
					end
				end
			end
		--抽奖按钮
		elseif DetectMousePos(bpLotteryButton) == 1 then
			NotReSetbpButton(4);
			Result = GetMouseStatus();
			if Result == MouseHover then --鼠标左键悬停
				bpLotteryButton:setImagePos(200, 400,0, 200);
				
				if bpLotteryButton["Hover"] == 0 then
					bpLotteryButton["Hover"] = 1;

					ShoptViewPropsse:Play();
				end
			elseif Result == MouseLeftDown then --鼠标左键按下
				bpLotteryButton:setImagePos(400, 600,0, 200);
				BPLRotateRateMAX = math.random(5, 7);
				if UserData["GoldCoins"] >= LotteryGoldSpend then
					BPLRotateRateStatus = 1;
				end
				bpLotteryButton["Event"] = 1;
			elseif Result == MouseLeftUp then --鼠标左键松开
				bpLotteryButton:setImagePos(0, 200,0, 200);
				MovePropsMem = 0;
				bpBigBombPropsTemp["DrawStatus"] = 0;
				bpAssistantPropsPropsTemp["DrawStatus"] = 0;
				if bpLotteryButton["Event"] == 1 then
					bpLotteryButton["Event"] = 0;
					
					if UserData["AssistantLock"] == 0 then
						LotteryHAPResult();
					else
						LotteryNAPResult();
					end
				end
			end
		else
			Result = GetMouseStatus();
			if Result == MouseLeftUp then
				bpBigBombPropsTemp["DrawStatus"] = 0;
				bpAssistantPropsPropsTemp["DrawStatus"] = 0;
				if DetectMouseUpSCBPos(MovePropsMouseX, MovePropsMouseY) == 0 then
					
					bpShortCutBar1:setImagePos(ShortCutBarW*1, ShortCutBarW*2,0, ShortCutBarH);
					bpShortCutBar2:setImagePos(ShortCutBarW*3, ShortCutBarW*4,0, ShortCutBarH);
					
					if MovePropsMem == 1 then
						MovePropsMem = 0;
						UserData["ShortCutBarBBP"] = 0;
						bpBigBombPropsSCB["DrawStatus"] = 0;

					elseif  MovePropsMem == 2 then
						MovePropsMem = 0;
						UserData["ShortCutBarAP"] = 0;
						bpAssistantPropsPropsSCB["DrawStatus"] = 0;
					end
					
				end
			end
			NotReSetbpButton(0);
		end
	else
		
		local KeyResult_Esc = KeyDetect(0x01);
		if KeyResult_Esc == Release then
			bpLRWinStatus = false;
		end
		--关闭抽奖结果窗口按钮
		if DetectMousePos(bpLRCloseBtn) == 1 then
			Result = GetMouseStatus();
			if Result == MouseHover then --鼠标左键悬停
				
			elseif Result == MouseLeftDown then --鼠标左键按下
				
				if bpLRCloseBtn["Event"] == 0 then
					bpLRCloseBtn["Event"] = 1;
				end
			elseif Result == MouseLeftUp then --鼠标左键松开
				if bpLRCloseBtn["Event"] == 1 then
					bpLRCloseBtn["Event"] = 0;
					bpLRWinStatus = false;
					BPLRotateRate = 1.0
				end
			end
		elseif DetectMousePos(bpLRAgainBtn) == 1 then
			Result = GetMouseStatus();
			if Result == MouseHover then --鼠标左键悬停
				bpLRAgainBtn:setImagePos( bpLRWinWidth, bpLRWinWidth+bpLRAgainBtnW,bpLRWinHeight+3+bpLRAgainBtnH*1, bpLRWinHeight+3+bpLRAgainBtnH*2);
			elseif Result == MouseLeftDown then --鼠标左键按下
				bpLRAgainBtn:setImagePos( bpLRWinWidth, bpLRWinWidth+bpLRAgainBtnW,bpLRWinHeight+3+bpLRAgainBtnH*2, bpLRWinHeight+3+bpLRAgainBtnH*3);
				if bpLRAgainBtn["Event"] == 0 then
					bpLRAgainBtn["Event"] = 1;
				end
			elseif Result == MouseLeftUp then --鼠标左键松开
				bpLRAgainBtn:setImagePos( bpLRWinWidth, bpLRWinWidth+bpLRAgainBtnW,bpLRWinHeight+3+bpLRAgainBtnH*0, bpLRWinHeight+3+bpLRAgainBtnH*1);
				if bpLRAgainBtn["Event"] == 1 then
					bpLRAgainBtn["Event"] = 0;
					if UserData["AssistantLock"] == 0 then
						LotteryHAPEvent();
					else
						LotteryNAPEvent();
					end
				end
			end
		--抽奖结果窗口
		elseif DetectMousePos(bpLRWindow) == 1 then
			Result = GetMouseStatus();
			if Result == MouseHover then --鼠标左键悬停
				
			elseif Result == MouseLeftDown then --鼠标左键按下
				if bpLRWindow["Event"] == 0 then
					MouseStatus = MouseLeftDown;
					LastMouseDownPosX = MousePosX;
					LastMouseDownPosY = MousePosY;
					bpLRWindow["Event"] = 1;
				end
			elseif Result == MouseLeftUp then --鼠标左键松开
				if bpLRWindow["Event"] == 1 then
					bpLRWindow["Event"] = 0;
					MouseStatus = MouseLeftUp;
				end
			end
		end
		NotReSetbpButton(0);
	end
	
	
end	

function NotReSetbpButton(value)

	if value ~= 1 then
		bpReturnButton:setImagePos(0, 173.7, 0, 172);
		bpReturnButton["Hover"] = 0;
		
	end
	if value ~= 2 then
		bpBigBombProps["Hover"] = 0;
		bpBigBombProps:setImagePos(0, bpPropsW, 0, bpPropsH);
	end

	if value ~= 3 then
		bpAssistantPropsProps["Hover"] = 0;
		bpAssistantPropsProps:setImagePos(0+bpOnePropsImageW*AssistantProps, bpPropsW+bpOnePropsImageW*AssistantProps, bpOnePropsImageH+16, bpPropsH+bpOnePropsImageH+16);
	end
	
	if value ~= 4 then
		bpLotteryButton["Hover"] = 0;
		bpLotteryButton:setImagePos(0, 200,0, 200);
	end
end


function DetectMouseUpSCBPos(X, Y)
	if bpShortCutBar1["StartX"] < X and X  < (bpShortCutBar1["StartX"] + bpShortCutBar1["Width"]) and bpShortCutBar1["StartY"] < Y and Y < (bpShortCutBar1["StartY"] + bpShortCutBar1["Height"])   then
		return 1;
	elseif bpShortCutBar2["StartX"] < X and X < (bpShortCutBar2["StartX"] + bpShortCutBar2["Width"]) and bpShortCutBar2["StartY"] < Y and Y < (bpShortCutBar2["StartY"] + bpShortCutBar2["Height"])   then
		
		return 2;
	end
	return 0;
end


NAPProbability = {{0,30},{30,75},{75,100}} -- 没有解锁助手时的概率
HAPProbability = {{0,20},{20,60},{60,80},{80,100}} -- 解锁助手时的概率
BBPProbabilityA = {{0,60},{60,85},{85,100}} -- 各炸弹个数的概率
APProbabilityA = {{0,60},{60,85},{85,100}} -- 各助手个数的概率



function LotteryHAPEvent()
	if UserData["GoldCoins"] - LotteryGoldSpend < 0 then
		
	else
		
		UserData["GoldCoins"] = UserData["GoldCoins"] - LotteryGoldSpend;
		local RandNum = math.random(1,100);
		if HAPProbability[1][1]<= RandNum and RandNum < HAPProbability[1][2] then
			NoPrize();
		elseif HAPProbability[2][1]<= RandNum and RandNum < HAPProbability[2][2] then

			local GoldRandom = math.random(10,45);
			UserData["GoldCoins"] = UserData["GoldCoins"] + GoldRandom;
			if UserData["GoldCoins"] > 9999 then
				UserData["GoldCoins"] = 9999;
			end
			PrizeOfGoldCoins(GoldRandom);
		elseif HAPProbability[3][1]<= RandNum and RandNum < HAPProbability[3][2] then

			local bbpNum = 0;
			local bbpProbability = math.random(1,100);
			local temp = 0;
			if BBPProbabilityA[1][1] <= bbpProbability and  bbpProbability< BBPProbabilityA[1][2] then 
				bbpNum = 1;
				UserData["BigBombPropsAmount"] = UserData["BigBombPropsAmount"] + 1;
				if UserData["BigBombPropsAmount"] >= 99 then
					UserData["BigBombPropsAmount"] = 99;
					UserData["GoldCoins"] = UserData["GoldCoins"] + BigBombNeeds;
					if UserData["GoldCoins"] > 9999 then
						UserData["GoldCoins"] = 9999;
					end
				end
			elseif BBPProbabilityA[2][1] <= bbpProbability and  bbpProbability< BBPProbabilityA[2][2] then 
				bbpNum = 2;
				temp = UserData["AssistantPropsAmount"];
				UserData["BigBombPropsAmount"] = UserData["BigBombPropsAmount"] + 2;
				if UserData["BigBombPropsAmount"] >= 99 then
					UserData["BigBombPropsAmount"] = 99;
					UserData["GoldCoins"] = UserData["GoldCoins"] + (2-(99 - temp))*BigBombNeeds;
					if UserData["GoldCoins"] > 9999 then
						UserData["GoldCoins"] = 9999;
					end
				end
			elseif BBPProbabilityA[3][1] <= bbpProbability and  bbpProbability< BBPProbabilityA[3][2] then
				bbpNum = 3;
				temp = UserData["BigBombPropsAmount"];
				UserData["BigBombPropsAmount"] = UserData["BigBombPropsAmount"] + 3;
				if UserData["BigBombPropsAmount"] >= 99 then
					UserData["BigBombPropsAmount"] = 99;
					UserData["GoldCoins"] = UserData["GoldCoins"] + (3-(99 - temp))*BigBombNeeds;
					if UserData["GoldCoins"] > 9999 then
						UserData["GoldCoins"] = 9999;
					end
				end
			end
			PrizeOfBigBomb(bbpNum);
		elseif HAPProbability[4][1]<= RandNum and RandNum < HAPProbability[4][2] then
			
			local apNum = 0;
			local apProbability = math.random(1,100);
			local temp = 0;
			if APProbabilityA[1][1]<= apProbability and  apProbability< APProbabilityA[1][2] then  --ap+1为60%的概率
				apNum = 1;
				
				UserData["AssistantPropsAmount"] = UserData["AssistantPropsAmount"] + 1;
				if UserData["AssistantPropsAmount"] > 99 then
					UserData["AssistantPropsAmount"] = 99;
					UserData["GoldCoins"] = UserData["GoldCoins"] + AssistantPropsNeeds;
					if UserData["GoldCoins"] > 9999 then
						UserData["GoldCoins"] = 9999;
					end
					temp = 1;
				end
			elseif APProbabilityA[2][1]<= apProbability and  apProbability< APProbabilityA[2][2] then --ap+2为25%的概率
				apNum = 2;
				temp = UserData["AssistantPropsAmount"];
				UserData["AssistantPropsAmount"] = UserData["AssistantPropsAmount"] + 2;
				if UserData["AssistantPropsAmount"] > 99 then
					UserData["AssistantPropsAmount"] = 99;
					UserData["GoldCoins"] = UserData["GoldCoins"] + (2-(99 - temp))*AssistantPropsNeeds;
					if UserData["GoldCoins"] > 9999 then
						UserData["GoldCoins"] = 9999;
					end
					temp = 1;
				end
			elseif APProbabilityA[3][1]<= apProbability and  apProbability< APProbabilityA[3][2] then --ap+3为15%的概率
				apNum = 3;
				temp = UserData["AssistantPropsAmount"];
				UserData["AssistantPropsAmount"] = UserData["AssistantPropsAmount"] + 3;
				if UserData["AssistantPropsAmount"] > 99 then
					UserData["AssistantPropsAmount"] = 99;
					UserData["GoldCoins"] = UserData["GoldCoins"] + (3-(99 - temp))*AssistantPropsNeeds;
					if UserData["GoldCoins"] > 9999 then
						UserData["GoldCoins"] = 9999;
					end
					temp = 1;
				end
			end
			PrizeOfAssistant(apNum);
		end
		
	end
	
end

function LotteryNAPEvent()
	if UserData["GoldCoins"] - LotteryGoldSpend < 0 then
		
	else
		UserData["GoldCoins"] = UserData["GoldCoins"] - LotteryGoldSpend;
		local RandNum = math.random(1,100);
		if NAPProbability[1][1]<= RandNum and RandNum < NAPProbability[1][2] then
			NoPrize();
		elseif NAPProbability[2][1]<= RandNum and RandNum < NAPProbability[2][2] then
		
			local GoldRandom = math.random(10,45);
			UserData["GoldCoins"] = UserData["GoldCoins"] + GoldRandom;
			if UserData["GoldCoins"] > 9999 then
				UserData["GoldCoins"] = 9999;
			end
			PrizeOfGoldCoins(GoldRandom);
		elseif NAPProbability[3][1]<= RandNum and RandNum < NAPProbability[3][2] then
			
			local bbpNum = 0;
			local bbpProbability = math.random(1,100);
			local temp = 0;
			if BBPProbabilityA[1][1] <= bbpProbability and  bbpProbability< BBPProbabilityA[1][2] then  --bbp+1为50%的概率
				bbpNum = 1;
				UserData["BigBombPropsAmount"] = UserData["BigBombPropsAmount"] + 1;
				if UserData["BigBombPropsAmount"] >= 99 then
					UserData["BigBombPropsAmount"] = 99;
					UserData["GoldCoins"] = UserData["GoldCoins"] + BigBombNeeds;
					if UserData["GoldCoins"] > 9999 then
						UserData["GoldCoins"] = 9999;
					end
				end
			elseif BBPProbabilityA[2][1] <= bbpProbability and  bbpProbability< BBPProbabilityA[2][2] then --bbp+2为30%的概率
				bbpNum = 2;
				temp = UserData["AssistantPropsAmount"];
				UserData["BigBombPropsAmount"] = UserData["BigBombPropsAmount"] + 2;
				if UserData["BigBombPropsAmount"] >= 99 then
					UserData["BigBombPropsAmount"] = 99;
					UserData["GoldCoins"] = UserData["GoldCoins"] + (2-(99 - temp))*BigBombNeeds;
					if UserData["GoldCoins"] > 9999 then
						UserData["GoldCoins"] = 9999;
					end
				end
			elseif BBPProbabilityA[3][1] <= bbpProbability and  bbpProbability< BBPProbabilityA[3][2] then --bbp+3为20%的概率
				bbpNum = 3;
				temp = UserData["BigBombPropsAmount"];
				UserData["BigBombPropsAmount"] = UserData["BigBombPropsAmount"] + 3;
				if UserData["BigBombPropsAmount"] >= 99 then
					UserData["BigBombPropsAmount"] = 99;
					UserData["GoldCoins"] = UserData["GoldCoins"] + (3-(99 - temp))*BigBombNeeds;
					if UserData["GoldCoins"] > 9999 then
						UserData["GoldCoins"] = 9999;
					end
				end
			end
			PrizeOfBigBomb(bbpNum);
		end
		
	end
end

bbpNum = 0;
apNum = 0;
GoldRandom = 0;
PrizeStatus = 0;


function LotteryNAPResult()
	if UserData["GoldCoins"] - LotteryGoldSpend < 0 then
		
	else
		UserData["GoldCoins"] = UserData["GoldCoins"] - LotteryGoldSpend;
		local RandNum = math.random(1,100);
		if NAPProbability[1][1]<= RandNum and RandNum < NAPProbability[1][2] then
			PrizeStatus = 1;
		elseif NAPProbability[2][1]<= RandNum and RandNum < NAPProbability[2][2] then
			PrizeStatus = 2;
			GoldRandom = math.random(10,45);
		elseif NAPProbability[3][1]<= RandNum and RandNum < NAPProbability[3][2] then
			PrizeStatus = 3;
			bbpNum = 0;
			local bbpProbability = math.random(1,100);
			if BBPProbabilityA[1][1] <= bbpProbability and  bbpProbability< BBPProbabilityA[1][2] then  --bbp+1为50%的概率
				bbpNum = 1;
			elseif BBPProbabilityA[2][1] <= bbpProbability and  bbpProbability< BBPProbabilityA[2][2] then --bbp+2为30%的概率
				bbpNum = 2;
			elseif BBPProbabilityA[3][1] <= bbpProbability and  bbpProbability< BBPProbabilityA[3][2] then --bbp+3为20%的概率
				bbpNum = 3;
			end
		end
		
	end
end

function LotteryHAPResult()
	if UserData["GoldCoins"] - LotteryGoldSpend < 0 then
		
	else
		UserData["GoldCoins"] = UserData["GoldCoins"] - LotteryGoldSpend;
		local RandNum = math.random(1,100);
		if HAPProbability[1][1]<= RandNum and RandNum < HAPProbability[1][2] then
			PrizeStatus = 1;
		elseif HAPProbability[2][1]<= RandNum and RandNum < HAPProbability[2][2] then
			PrizeStatus = 2;
			GoldRandom = math.random(10,45);
		elseif HAPProbability[3][1]<= RandNum and RandNum < HAPProbability[3][2] then
			PrizeStatus = 3;
			bbpNum = 0;
			local bbpProbability = math.random(1,100);
			if BBPProbabilityA[1][1] <= bbpProbability and  bbpProbability< BBPProbabilityA[1][2] then  --bbp+1为50%的概率
				bbpNum = 1;
			elseif BBPProbabilityA[2][1] <= bbpProbability and  bbpProbability< BBPProbabilityA[2][2] then --bbp+2为30%的概率
				bbpNum = 2;
			elseif BBPProbabilityA[3][1] <= bbpProbability and  bbpProbability< BBPProbabilityA[3][2] then --bbp+3为20%的概率
				bbpNum = 3;
			end
		elseif HAPProbability[4][1]<= RandNum and RandNum < HAPProbability[4][2] then
			PrizeStatus = 4;
			apNum = 0;
			local apProbability = math.random(1,100);
			if APProbabilityA[1][1]<= apProbability and  apProbability< APProbabilityA[1][2] then  --ap+1为60%的概率
				apNum = 1;

			elseif APProbabilityA[2][1]<= apProbability and  apProbability< APProbabilityA[2][2] then --ap+2为25%的概率
				apNum = 2;

			elseif APProbabilityA[3][1]<= apProbability and  apProbability< APProbabilityA[3][2] then --ap+3为15%的概率
				apNum = 3;

			end
		end
		
	end
end


function NAPStopPos()
	if PrizeStatus == 1 then
		if 0.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 45.0 or 270.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 315.0 then
			local RandRate = math.random(1,10);
			BPLRotateRate = BPLRotateRate - RandRate/200;
			if BPLRotateRate <= 0.0 then
				BPLRotateRate = 0.0;
				BPLRotateRateStatus = 0;
				
				
				NoPrize();
			end
		end
	elseif PrizeStatus == 2 then
		if 45.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 90.0 or 225.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 270.0 then
			local RandRate = math.random(1,10);
			BPLRotateRate = BPLRotateRate - RandRate/200;
			if BPLRotateRate <= 0.0 then
				BPLRotateRate = 0.0;
				BPLRotateRateStatus = 0;
				
				
				UserData["GoldCoins"] = UserData["GoldCoins"] + GoldRandom;
				if UserData["GoldCoins"] > 9999 then
					UserData["GoldCoins"] = 9999;
				end
				PrizeOfGoldCoins(GoldRandom);
			end
		end
	elseif PrizeStatus == 3 then
		if bbpNum == 1 then
			if 90.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 180.0 then
				local RandRate = math.random(1,10);
				BPLRotateRate = BPLRotateRate - RandRate/200;
				if BPLRotateRate <= 0.0 then
					BPLRotateRate = 0.0;
					BPLRotateRateStatus = 0;
					
					UserData["BigBombPropsAmount"] = UserData["BigBombPropsAmount"] + 1;
					if UserData["BigBombPropsAmount"] >= 99 then
						UserData["BigBombPropsAmount"] = 99;
						UserData["GoldCoins"] = UserData["GoldCoins"] + BigBombNeeds;
						if UserData["GoldCoins"] > 9999 then
							UserData["GoldCoins"] = 9999;
						end
					end
					PrizeOfBigBomb(bbpNum);
				end
			end
		elseif bbpNum == 2 then
			if 180.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 225.0 then
				local RandRate = math.random(1,10);
				BPLRotateRate = BPLRotateRate - RandRate/200;
				if BPLRotateRate <= 0.0 then
					BPLRotateRate = 0.0;
					BPLRotateRateStatus = 0;
					
					local temp = UserData["AssistantPropsAmount"];
					UserData["BigBombPropsAmount"] = UserData["BigBombPropsAmount"] + 2;
					if UserData["BigBombPropsAmount"] >= 99 then
						UserData["BigBombPropsAmount"] = 99;
						UserData["GoldCoins"] = UserData["GoldCoins"] + (2-(99 - temp))*BigBombNeeds;
						if UserData["GoldCoins"] > 9999 then
							UserData["GoldCoins"] = 9999;
						end
					end
					PrizeOfBigBomb(bbpNum);
				end
			end
		elseif bbpNum == 3 then
			if 315.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 360.0 then
				local RandRate = math.random(1,10);
				BPLRotateRate = BPLRotateRate - RandRate/200;
				if BPLRotateRate <= 0.0 then
					BPLRotateRate = 0.0;
					BPLRotateRateStatus = 0;
					
					
					local temp = UserData["BigBombPropsAmount"];
					UserData["BigBombPropsAmount"] = UserData["BigBombPropsAmount"] + 3;
					if UserData["BigBombPropsAmount"] >= 99 then
						UserData["BigBombPropsAmount"] = 99;
						UserData["GoldCoins"] = UserData["GoldCoins"] + (3-(99 - temp))*BigBombNeeds;
						if UserData["GoldCoins"] > 9999 then
							UserData["GoldCoins"] = 9999;
						end
					end
					PrizeOfBigBomb(bbpNum);
				end
			end
		end
	end
end


function GAPStopPos()
	if PrizeStatus == 1 then
		if 0.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 45.0 then
			local RandRate = math.random(1,10);
			BPLRotateRate = BPLRotateRate - RandRate/200;
			if BPLRotateRate <= 0.0 then
				BPLRotateRate = 0.0;
				BPLRotateRateStatus = 0;
				
				
				NoPrize();
			end
		end
	elseif PrizeStatus == 2 then
		if 135.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 180.0 then
			local RandRate = math.random(1,10);
			BPLRotateRate = BPLRotateRate - RandRate/200;
			if BPLRotateRate <= 0.0 then
				BPLRotateRate = 0.0;
				BPLRotateRateStatus = 0;
				
				
				UserData["GoldCoins"] = UserData["GoldCoins"] + GoldRandom;
				if UserData["GoldCoins"] > 9999 then
					UserData["GoldCoins"] = 9999;
				end
				PrizeOfGoldCoins(GoldRandom);
			end
		end
	elseif PrizeStatus == 3 then
		if bbpNum == 1 then
			if 225.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 270.0 then
				local RandRate = math.random(1,10);
				BPLRotateRate = BPLRotateRate - RandRate/200;
				if BPLRotateRate <= 0.0 then
					BPLRotateRate = 0.0;
					BPLRotateRateStatus = 0;
					
					UserData["BigBombPropsAmount"] = UserData["BigBombPropsAmount"] + 1;
					if UserData["BigBombPropsAmount"] >= 99 then
						UserData["BigBombPropsAmount"] = 99;
						UserData["GoldCoins"] = UserData["GoldCoins"] + BigBombNeeds;
						if UserData["GoldCoins"] > 9999 then
							UserData["GoldCoins"] = 9999;
						end
					end
					PrizeOfBigBomb(bbpNum);
				end
			end
		elseif bbpNum == 2 then
			if 270.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 315.0 then
				local RandRate = math.random(1,10);
				BPLRotateRate = BPLRotateRate - RandRate/200;
				if BPLRotateRate <= 0.0 then
					BPLRotateRate = 0.0;
					BPLRotateRateStatus = 0;
					
					local temp = UserData["AssistantPropsAmount"];
					UserData["BigBombPropsAmount"] = UserData["BigBombPropsAmount"] + 2;
					if UserData["BigBombPropsAmount"] >= 99 then
						UserData["BigBombPropsAmount"] = 99;
						UserData["GoldCoins"] = UserData["GoldCoins"] + (2-(99 - temp))*BigBombNeeds;
						if UserData["GoldCoins"] > 9999 then
							UserData["GoldCoins"] = 9999;
						end
					end
					PrizeOfBigBomb(bbpNum);
				end
			end
		elseif bbpNum == 3 then
			if 45.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 90.0 then
				local RandRate = math.random(1,10);
				BPLRotateRate = BPLRotateRate - RandRate/200;
				if BPLRotateRate <= 0.0 then
					BPLRotateRate = 0.0;
					BPLRotateRateStatus = 0;
					
					
					local temp = UserData["BigBombPropsAmount"];
					UserData["BigBombPropsAmount"] = UserData["BigBombPropsAmount"] + 3;
					if UserData["BigBombPropsAmount"] >= 99 then
						UserData["BigBombPropsAmount"] = 99;
						UserData["GoldCoins"] = UserData["GoldCoins"] + (3-(99 - temp))*BigBombNeeds;
						if UserData["GoldCoins"] > 9999 then
							UserData["GoldCoins"] = 9999;
						end
					end
					PrizeOfBigBomb(bbpNum);
				end
			end
		end
	elseif PrizeStatus == 4 then
		if apNum == 1 then
			if 315.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 360.0 then
				local RandRate = math.random(1,10);
				BPLRotateRate = BPLRotateRate - RandRate/200;
				if BPLRotateRate <= 0.0 then
					BPLRotateRate = 0.0;
					BPLRotateRateStatus = 0;
					
					UserData["AssistantPropsAmount"] = UserData["AssistantPropsAmount"] + 1;
					if UserData["AssistantPropsAmount"] > 99 then
						UserData["AssistantPropsAmount"] = 99;
						UserData["GoldCoins"] = UserData["GoldCoins"] + AssistantPropsNeeds;
						if UserData["GoldCoins"] > 9999 then
							UserData["GoldCoins"] = 9999;
						end
					end
					PrizeOfAssistant(apNum);
				end
			end
		elseif apNum == 2 then
			if 90.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 135.0 then
				local RandRate = math.random(1,10);
				BPLRotateRate = BPLRotateRate - RandRate/200;
				if BPLRotateRate <= 0.0 then
					BPLRotateRate = 0.0;
					BPLRotateRateStatus = 0;
					
					local temp = UserData["AssistantPropsAmount"];
					UserData["AssistantPropsAmount"] = UserData["AssistantPropsAmount"] + 2;
					if UserData["AssistantPropsAmount"] > 99 then
						UserData["AssistantPropsAmount"] = 99;
						UserData["GoldCoins"] = UserData["GoldCoins"] + (2-(99 - temp))*AssistantPropsNeeds;
						if UserData["GoldCoins"] > 9999 then
							UserData["GoldCoins"] = 9999;
						end
					end
					PrizeOfAssistant(apNum);
				end
			end
		elseif apNum == 3 then
			if 180.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 225.0 then
				local RandRate = math.random(1,10);
				BPLRotateRate = BPLRotateRate - RandRate/200;
				if BPLRotateRate <= 0.0 then
					BPLRotateRate = 0.0;
					BPLRotateRateStatus = 0;
					
					local temp = UserData["AssistantPropsAmount"];
					UserData["AssistantPropsAmount"] = UserData["AssistantPropsAmount"] + 3;
					if UserData["AssistantPropsAmount"] > 99 then
						UserData["AssistantPropsAmount"] = 99;
						UserData["GoldCoins"] = UserData["GoldCoins"] + (3-(99 - temp))*AssistantPropsNeeds;
						if UserData["GoldCoins"] > 9999 then
							UserData["GoldCoins"] = 9999;
						end
					end
					PrizeOfAssistant(apNum);
				end
			end
		end
	end
end



function BAPStopPos()
	if PrizeStatus == 1 then
		if 0.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 45.0 then
			local RandRate = math.random(1,10);
			BPLRotateRate = BPLRotateRate - RandRate/200;
			if BPLRotateRate <= 0.0 then
				BPLRotateRate = 0.0;
				BPLRotateRateStatus = 0;
				
				
				NoPrize();
			end
		end
	elseif PrizeStatus == 2 then
		if 135.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 180.0 then
			local RandRate = math.random(1,10);
			BPLRotateRate = BPLRotateRate - RandRate/200;
			if BPLRotateRate <= 0.0 then
				BPLRotateRate = 0.0;
				BPLRotateRateStatus = 0;
				
				
				UserData["GoldCoins"] = UserData["GoldCoins"] + GoldRandom;
				if UserData["GoldCoins"] > 9999 then
					UserData["GoldCoins"] = 9999;
				end
				PrizeOfGoldCoins(GoldRandom);
			end
		end
	elseif PrizeStatus == 3 then
		if bbpNum == 1 then
			if 225.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 270.0 then
				local RandRate = math.random(1,10);
				BPLRotateRate = BPLRotateRate - RandRate/200;
				if BPLRotateRate <= 0.0 then
					BPLRotateRate = 0.0;
					BPLRotateRateStatus = 0;
					
					UserData["BigBombPropsAmount"] = UserData["BigBombPropsAmount"] + 1;
					if UserData["BigBombPropsAmount"] >= 99 then
						UserData["BigBombPropsAmount"] = 99;
						UserData["GoldCoins"] = UserData["GoldCoins"] + BigBombNeeds;
						if UserData["GoldCoins"] > 9999 then
							UserData["GoldCoins"] = 9999;
						end
					end
					PrizeOfBigBomb(bbpNum);
				end
			end
		elseif bbpNum == 2 then
			if 270.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 315.0 then
				local RandRate = math.random(1,10);
				BPLRotateRate = BPLRotateRate - RandRate/200;
				if BPLRotateRate <= 0.0 then
					BPLRotateRate = 0.0;
					BPLRotateRateStatus = 0;
					
					local temp = UserData["AssistantPropsAmount"];
					UserData["BigBombPropsAmount"] = UserData["BigBombPropsAmount"] + 2;
					if UserData["BigBombPropsAmount"] >= 99 then
						UserData["BigBombPropsAmount"] = 99;
						UserData["GoldCoins"] = UserData["GoldCoins"] + (2-(99 - temp))*BigBombNeeds;
						if UserData["GoldCoins"] > 9999 then
							UserData["GoldCoins"] = 9999;
						end
					end
					PrizeOfBigBomb(bbpNum);
				end
			end
		elseif bbpNum == 3 then
			if 45.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 90.0 then
				local RandRate = math.random(1,10);
				BPLRotateRate = BPLRotateRate - RandRate/200;
				if BPLRotateRate <= 0.0 then
					BPLRotateRate = 0.0;
					BPLRotateRateStatus = 0;
					
					
					local temp = UserData["BigBombPropsAmount"];
					UserData["BigBombPropsAmount"] = UserData["BigBombPropsAmount"] + 3;
					if UserData["BigBombPropsAmount"] >= 99 then
						UserData["BigBombPropsAmount"] = 99;
						UserData["GoldCoins"] = UserData["GoldCoins"] + (3-(99 - temp))*BigBombNeeds;
						if UserData["GoldCoins"] > 9999 then
							UserData["GoldCoins"] = 9999;
						end
					end
					PrizeOfBigBomb(bbpNum);
				end
			end
		end
	elseif PrizeStatus == 4 then
		if apNum == 1 then
			if 315.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 360.0 then
				local RandRate = math.random(1,10);
				BPLRotateRate = BPLRotateRate - RandRate/200;
				if BPLRotateRate <= 0.0 then
					BPLRotateRate = 0.0;
					BPLRotateRateStatus = 0;
					
					UserData["AssistantPropsAmount"] = UserData["AssistantPropsAmount"] + 1;
					if UserData["AssistantPropsAmount"] > 99 then
						UserData["AssistantPropsAmount"] = 99;
						UserData["GoldCoins"] = UserData["GoldCoins"] + AssistantPropsNeeds;
						if UserData["GoldCoins"] > 9999 then
							UserData["GoldCoins"] = 9999;
						end
					end
					PrizeOfAssistant(apNum);
				end
			end
		elseif apNum == 2 then
			if 180.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 225.0 then
				local RandRate = math.random(1,10);
				BPLRotateRate = BPLRotateRate - RandRate/200;
				if BPLRotateRate <= 0.0 then
					BPLRotateRate = 0.0;
					BPLRotateRateStatus = 0;
					
					local temp = UserData["AssistantPropsAmount"];
					UserData["AssistantPropsAmount"] = UserData["AssistantPropsAmount"] + 2;
					if UserData["AssistantPropsAmount"] > 99 then
						UserData["AssistantPropsAmount"] = 99;
						UserData["GoldCoins"] = UserData["GoldCoins"] + (2-(99 - temp))*AssistantPropsNeeds;
						if UserData["GoldCoins"] > 9999 then
							UserData["GoldCoins"] = 9999;
						end
					end
					PrizeOfAssistant(apNum);
				end
			end
		elseif apNum == 3 then
			if 90.0 < bpLotteryTB["Angle"] and bpLotteryTB["Angle"] < 135.0 then
				local RandRate = math.random(1,10);
				BPLRotateRate = BPLRotateRate - RandRate/200;
				if BPLRotateRate <= 0.0 then
					BPLRotateRate = 0.0;
					BPLRotateRateStatus = 0;
					
					local temp = UserData["AssistantPropsAmount"];
					UserData["AssistantPropsAmount"] = UserData["AssistantPropsAmount"] + 3;
					if UserData["AssistantPropsAmount"] > 99 then
						UserData["AssistantPropsAmount"] = 99;
						UserData["GoldCoins"] = UserData["GoldCoins"] + (3-(99 - temp))*AssistantPropsNeeds;
						if UserData["GoldCoins"] > 9999 then
							UserData["GoldCoins"] = 9999;
						end
					end
					PrizeOfAssistant(apNum);
				end
			end
		end
	end
end






