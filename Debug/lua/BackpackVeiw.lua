

bpPriorityBGI   = 20
bpPriorityRB = 19
bpPriorityGold = 18
bpPriorityNumber = 17
bpPriorityFont   = 16
bpPrioritySCB = 15
bpPriorityLottery = 14
bpPriorityBBP = 13
bpPriorityLR   = 12
------------------------
bpPriorityOne   = 11

bpReturnButton = ImageClass:new();
bpReturnButton:setImageFileSize(521, 172);
bpReturnButton:setscaling_ratio(0.3);
bpReturnButton:setImage(520, 590-174*0.3, 173.7, 172, 0, 173.7, 0, 172, bpPriorityRB+0.9);




function DrawbpReturn()
	bpReturnButton:DrawImage();
end

bpPropsImageW = 1720
bpPropsImageH = 2800
bpOnePropsImageW = 860
bpOnePropsImageH = 1392 
bpPropsW = 266
bpPropsH = 266


bpBigBombProps = ImageClass:new();
bpBigBombProps:setImageFileSize(bpPropsImageW, bpPropsImageH);
bpBigBombProps:setscaling_ratio(0.5);
bpBigBombProps:setImage(500, 510-bpPropsH*0.5, bpPropsW, bpPropsH, 0, 0, 0, 0, bpPriorityBBP+0.80);

bpBigBombPropsTemp = ImageClass:new();
bpBigBombPropsTemp:setImageFileSize(bpPropsImageW, bpPropsImageH);
bpBigBombPropsTemp:setscaling_ratio(0.25);
bpBigBombPropsTemp["DrawStatus"] = 0;
bpBigBombPropsTemp:setImage(0, 0, 237, 237, bpPropsW*2+10, 779, 0, 237, bpPriorityBBP+0.40);


bpAssistantPropsProps = ImageClass:new();
bpAssistantPropsProps:setImageFileSize(bpPropsImageW, bpPropsImageH);
bpAssistantPropsProps:setscaling_ratio(0.5);
bpAssistantPropsProps:setImage(500, 360-bpPropsH*0.5, bpPropsW, bpPropsH, 0, 0, 0, 0, bpPriorityBBP+0.80);

bpAssistantPropsPropsTemp = ImageClass:new();
bpAssistantPropsPropsTemp:setImageFileSize(bpPropsImageW, bpPropsImageH);
bpAssistantPropsPropsTemp:setscaling_ratio(0.25);
bpAssistantPropsPropsTemp["DrawStatus"] = 0;
bpAssistantPropsPropsTemp:setImage(0, 0, 237, 237, bpPropsW*2+10+bpOnePropsImageW*AssistantProps, 779+bpOnePropsImageW*AssistantProps, bpOnePropsImageH+16, 237+bpOnePropsImageH+16, bpPriorityBBP+0.40);


MovePropsMouseX = 0
MovePropsMouseY = 0

function DrawbpProps()
	bpBigBombProps:DrawImage();
	bpBigBombPropsSCB:DrawImage();
	bpAssistantPropsPropsSCB:DrawImage();
	if UserData["AssistantLock"] == 0 then
		bpAssistantPropsProps:DrawImage();
	end
	
	
	if UserData["BigBombPropsAmount"] >= 1 then
		MovePropsMouseX = MousePosX-bpBigBombPropsTemp["Width"]/2;
		MovePropsMouseY = 600.0 - MousePosY- bpBigBombPropsTemp["Height"]/2+10;
		if bpBigBombPropsTemp["DrawStatus"] == 1 then
			DetectMoveSCBPos(MovePropsMouseX, MovePropsMouseY);
		end
		
		bpBigBombPropsTemp:setAbsoluteStartPos(MovePropsMouseX,MovePropsMouseY);
		bpBigBombPropsTemp:DrawImage();
	end
	
	
	if UserData["AssistantLock"] == 0 and UserData["AssistantPropsAmount"] >= 1 then
		MovePropsMouseX = MousePosX-bpAssistantPropsPropsTemp["Width"]/2;
		MovePropsMouseY = 600.0 - MousePosY- bpAssistantPropsPropsTemp["Height"]/2+20;
		
		if bpAssistantPropsPropsTemp["DrawStatus"] == 1 then
			DetectMoveSCBPos(MovePropsMouseX, MovePropsMouseY);
		end
		
		bpAssistantPropsPropsTemp:setAbsoluteStartPos(MovePropsMouseX,MovePropsMouseY);
		bpAssistantPropsPropsTemp:DrawImage();
		
	end
	
end


function DetectMoveSCBPos(X, Y)
	if bpShortCutBar1["StartX"] < X and X  < (bpShortCutBar1["StartX"] + bpShortCutBar1["Width"]) and bpShortCutBar1["StartY"] < Y and Y < (bpShortCutBar1["StartY"] + bpShortCutBar1["Height"])   then
		
		
		bpShortCutBar1:setImagePos(0, ShortCutBarW,0, ShortCutBarH);
		
		if UserData["ShortCutBarBBP"] ~= 2 and UserData["ShortCutBarAP"] ~= 2 then
			bpShortCutBar2:setImagePos(ShortCutBarW*3, ShortCutBarW*4,0, ShortCutBarH);
		end

	elseif bpShortCutBar2["StartX"] < X and X < (bpShortCutBar2["StartX"] + bpShortCutBar2["Width"]) and bpShortCutBar2["StartY"] < Y and Y < (bpShortCutBar2["StartY"] + bpShortCutBar2["Height"])   then
		
		if UserData["ShortCutBarBBP"] ~= 1 and UserData["ShortCutBarAP"] ~= 1 then
			bpShortCutBar1:setImagePos(ShortCutBarW*1, ShortCutBarW*2,0, ShortCutBarH);
		end
		bpShortCutBar2:setImagePos(ShortCutBarW*2, ShortCutBarW*3,0, ShortCutBarH);
		
	end
end



bpBackGround = ImageClass:new();
bpBackGround:setImageFileSize(1000, 600);
bpBackGround:setImage(0, 0, 1000, 600, 0, 1000, 0, 600, bpPriorityBGI+0.99);

function DrawbpBackGroundFunc()
	bpBackGround:DrawImage();
end







-------------------------------------------------------画数字
bpNumberW = 76.5;
bpNumberH = 87.8;
bpPriceNumberPriority = 0.3




function DrawbpNumber()
	
	if UserData["BigBombPropsAmount"] >= 10 then
		DrawTwoNumber(740,420,GetBitNum(UserData["BigBombPropsAmount"],1), GetBitNum(UserData["BigBombPropsAmount"],2), 1);
	else
		DrawTwoNumber(740,420, 0, GetBitNum(UserData["BigBombPropsAmount"],1), 1);
	end
	--助手拥有个数
	if UserData["AssistantLock"] == 0 then
		if UserData["AssistantPropsAmount"] >= 10 then
			DrawTwoNumber(740,280,GetBitNum(UserData["AssistantPropsAmount"],1), GetBitNum(UserData["AssistantPropsAmount"],2), 1);
		else
			DrawTwoNumber(740,280, 0, GetBitNum(UserData["AssistantPropsAmount"],1), 1);
		end
	end
	
	
	if UserData["GoldCoins"] < 10 then
		DrawFourNumber(700, 140, 0, 0, 0, GetBitNum(UserData["GoldCoins"],1))
	elseif UserData["GoldCoins"] < 100 then
		DrawFourNumber(700, 140, 0, 0,GetBitNum(UserData["GoldCoins"],1), GetBitNum(UserData["GoldCoins"],2))
	elseif UserData["GoldCoins"] < 1000 then
		DrawFourNumber(700, 140, 0, GetBitNum(UserData["GoldCoins"],1),GetBitNum(UserData["GoldCoins"],2), GetBitNum(UserData["GoldCoins"],3))
	else
		DrawFourNumber(700, 140, GetBitNum(UserData["GoldCoins"],1), GetBitNum(UserData["GoldCoins"],2),GetBitNum(UserData["GoldCoins"],3), GetBitNum(UserData["GoldCoins"],4))
	end
	
	--画快捷键提示
	DrawNumberFunc(ShortcutPosX+40, ShortcutPosY - 30, 0.3, ShortcutKey1, 2);
	DrawNumberFunc(ShortcutPosX+140, ShortcutPosY - 30, 0.3, ShortcutKey2, 2);
	
	DrawTwoNumber(120,50,GetBitNum(LotteryGoldSpend,1), GetBitNum(LotteryGoldSpend,2), 1);
end



-------------------------------------------------------画字体

bpGoldFont = ImageClass:new();
bpGoldFont :setImageFileSize(FontImageW, FontImageH);
bpGoldFont :setscaling_ratio(0.3);
bpGoldFont :setImage(800, 140 ,180, FontImageH, 0, 180,0, FontImageH, ShopPriorityFont+0.9);

bpOverageFont = ImageClass:new();
bpOverageFont :setImageFileSize(FontImageW, FontImageH);
bpOverageFont :setscaling_ratio(0.3);
bpOverageFont :setImage(620, 140 ,212, FontImageH, 180, 392,0, FontImageH, ShopPriorityFont+0.9);

bpFontGE = ImageClass:new();
bpFontGE :setImageFileSize(FontImageW, FontImageH);
bpFontGE :setscaling_ratio(0.3);
bpFontGE :setImage(800, 420 ,93, FontImageH, 400, 493,0, FontImageH, ShopPriorityFont+0.9);

SpendFont = ImageClass:new();
SpendFont :setImageFileSize(FontImageW, FontImageH);
SpendFont :setscaling_ratio(0.3);
SpendFont :setImage(60, 50 ,190, FontImageH, 493, 683,0, FontImageH, ShopPriorityFont+0.9);



function DrawbpFont()
	bpFontGE:setAbsoluteStartPos(800,420);
	bpFontGE:DrawImage();
	bpOverageFont:setAbsoluteStartPos(620,140);
	bpOverageFont:DrawImage();
	bpOverageFont:setAbsoluteStartPos(660,420);
	bpOverageFont:DrawImage();
	
	if UserData["AssistantLock"] == 0 then
		bpFontGE:setAbsoluteStartPos(800,280);
		bpFontGE:DrawImage();
		bpOverageFont:setAbsoluteStartPos(660,280);
		bpOverageFont:DrawImage();
	end
	
	bpGoldFont:DrawImage();
	
	--
	SpendFont:DrawImage();
end






-------------------------------------------------------画金币

bpGoldA1 = AnimationRecord:new();
bpGoldA1:SetValue(550, 130, 20, 8);

bpGoldA2 = AnimationRecord:new();
bpGoldA2:SetValue(170, 40, 20, 8);

function DrawbpGold()
	DrawGoldFunc(bpGoldA1["StartX"], bpGoldA1["StartY"], bpGoldA1:TimerGo() );
	
	DrawGoldFunc(bpGoldA2["StartX"], bpGoldA2["StartY"], bpGoldA2:TimerGo() );
end

-------------------------------------------------------画快捷栏

ShortcutPosX = 650
ShortcutPosY = 40

ShortCutBarW = 200
ShortCutBarH = 162

bpShortCutBar1 = ImageClass:new();
bpShortCutBar1 :setImageFileSize(800, 162);
bpShortCutBar1 :setscaling_ratio(0.5);
bpShortCutBar1 :setImage(ShortcutPosX, ShortcutPosY ,ShortCutBarW, ShortCutBarH,  ShortCutBarW, ShortCutBarW*2,0, ShortCutBarH, bpPrioritySCB+0.9);

bpShortCutBar2 = ImageClass:new();
bpShortCutBar2 :setImageFileSize(800, 162);
bpShortCutBar2 :setscaling_ratio(0.5);
bpShortCutBar2 :setImage(ShortcutPosX+100, ShortcutPosY ,ShortCutBarW, ShortCutBarH, ShortCutBarW*3, ShortCutBarW*4,0, ShortCutBarH, bpPrioritySCB+0.9);


bpBigBombPropsSCB = ImageClass:new();
bpBigBombPropsSCB:setImageFileSize(bpPropsImageW, bpPropsImageH);
bpBigBombPropsSCB:setscaling_ratio(0.25);
bpBigBombPropsSCB["DrawStatus"] = 0;
bpBigBombPropsSCB:setImage(0, 0, 237, 237, bpPropsW*2+10, 779, 0, 237, bpPriorityBBP+0.50);


bpAssistantPropsPropsSCB = ImageClass:new();
bpAssistantPropsPropsSCB:setImageFileSize(bpPropsImageW, bpPropsImageH);
bpAssistantPropsPropsSCB:setscaling_ratio(0.25);
bpAssistantPropsPropsSCB["DrawStatus"] = 0;
bpAssistantPropsPropsSCB:setImage(0, 0, 237, 237, bpPropsW*2+10+bpOnePropsImageW*AssistantProps, 779+bpOnePropsImageW*AssistantProps, bpOnePropsImageH+16, 237+bpOnePropsImageH+16, bpPriorityBBP+0.50);


function bpDrawShortCutBar()
	
	if UserData["ShortCutBarBBP"] == 1 then
		bpBigBombPropsSCB["DrawStatus"] = 1;
		bpBigBombPropsSCB:setAbsoluteStartPos(ShortcutPosX+20, ShortcutPosY+10);
		bpShortCutBar1:setImagePos(0, ShortCutBarW,0, ShortCutBarH);
	elseif UserData["ShortCutBarBBP"] == 2 then
		bpBigBombPropsSCB["DrawStatus"] = 1;
		bpBigBombPropsSCB:setAbsoluteStartPos(ShortcutPosX+120, ShortcutPosY+10);
		bpShortCutBar2:setImagePos(ShortCutBarW*2, ShortCutBarW*3,0, ShortCutBarH);
	end
	
	if UserData["ShortCutBarAP"] == 1 then
		bpAssistantPropsPropsSCB["DrawStatus"] = 1;
		bpAssistantPropsPropsSCB:setAbsoluteStartPos(ShortcutPosX+20, ShortcutPosY+10);
		bpShortCutBar1:setImagePos(0, ShortCutBarW,0, ShortCutBarH);
	elseif UserData["ShortCutBarAP"] == 2 then
		bpAssistantPropsPropsSCB["DrawStatus"] = 1;
		bpAssistantPropsPropsSCB:setAbsoluteStartPos(ShortcutPosX+120, ShortcutPosY+10);
		bpShortCutBar2:setImagePos(ShortCutBarW*2, ShortCutBarW*3,0, ShortCutBarH);
	end
	
	bpShortCutBar1:DrawImage();
	bpShortCutBar2:DrawImage();
end

bpLottery = ImageClass:new();
bpLottery :setImageFileSize(600, 592);
bpLottery :setscaling_ratio(0.84);
bpLottery :setImage(0, 100 ,600, 592,  0, 600,0, 592, bpPriorityLottery+0.9);



function DrawbpLottery()
	bpLottery:DrawImage();
end


----------------------------------------------------------画抽奖按钮
bpLotteryButton = ImageClass:new();
bpLotteryButton :setImageFileSize(556, 506);
bpLotteryButton :setscaling_ratio(0.3);
bpLotteryButton :setImage(220, 40 ,556, 143,  0, 556,0, 143, bpPriorityLottery+0.9);


function DrawbpLotteryButton()
	bpLotteryButton:DrawImage();
end




----------------------------------------------------------画抽奖结果

--抽奖结果弹框状态量
bpLRWinStatus = false;


--抽奖结果素材图大小
bpLRWidth = 1600;
bpLRHeight = 829;
--抽奖弹框大小
bpLRWinWidth = 400;
bpLRWinHeight = 301;
--弹框位置,初始化位于中心！
bpLRPosX = 500 - bpLRWinWidth/2;
bpLRPosY = 300 - bpLRWinHeight/2;


--半透明背景
bpLRTransBGI = ImageClass:new();
bpLRTransBGI :setImageFileSize(bpLRWidth, bpLRHeight);
bpLRTransBGI :setImage(0, 0 ,1000, 600,  200, 300,500, 560, bpPriorityLR+0.99);
--窗口
bpLRWindow = ImageClass:new();
bpLRWindow :setImageFileSize(bpLRWidth, bpLRHeight);
bpLRWindow :setImage(bpLRPosX, bpLRPosY ,bpLRWinWidth, bpLRWinHeight,  0, bpLRWinWidth,0, bpLRWinHeight, bpPriorityLR+0.9);
--再来一次抽奖按钮
bpLRAgainBtnW = 160
bpLRAgainBtnH = 48
bpLRAgainBtn = ImageClass:new();
bpLRAgainBtn :setImageFileSize(bpLRWidth, bpLRHeight);
bpLRAgainBtn :setImage(bpLRPosX+120, bpLRPosY+20 ,bpLRAgainBtnW, bpLRAgainBtnH,  bpLRWinWidth, bpLRWinWidth+bpLRAgainBtnW,bpLRWinHeight+3, bpLRWinHeight+3+bpLRAgainBtnH, bpPriorityLR+0.7);

--关闭按钮
bpLRCloseBtn = ImageClass:new();
bpLRCloseBtn :setImageFileSize(bpLRWidth, bpLRHeight);
bpLRCloseBtn :setImage(bpLRPosX+350, bpLRPosY+230 ,44, 44,  406, 406+44,456, 456+44, bpPriorityLR+0.7);



PrizeStatus = false;
--中奖提示
bpLRTile = ImageClass:new();
bpLRTile :setImageFileSize(bpLRWidth, bpLRHeight);
bpLRTile :setImage(bpLRPosX+125, bpLRPosY+220 ,150, 40,  0, 150, bpLRWinHeight+3, bpLRWinHeight+3+40, bpPriorityLR+0.7);
--未中奖提示
bpLRNotPrize = ImageClass:new();
bpLRNotPrize :setImageFileSize(bpLRWidth, bpLRHeight);
bpLRNotPrize :setImage(bpLRPosX+20, bpLRPosY+200 ,400, 40,  1200, 1600, 306, 346, bpPriorityLR+0.7);


GoldPropsStatus = false;

bpLRPromptPosX = 0;
--奖励道具
bpLRRewardProps = ImageClass:new();
bpLRRewardProps :setImageFileSize(bpLRWidth, bpLRHeight);
bpLRRewardProps :setImage(bpLRPosX+83+bpLRPromptPosX, bpLRPosY+95 ,100, 109,  0, 100, 611, 720, bpPriorityLR+0.7);
--金币的数据：setImage(bpLRPosX+113+bpLRPromptPosX, bpLRPosY+130 ,70, 40,  400, 470, 500, 540, bpPriorityLR+0.7);
--炸弹的数据：setImage(bpLRPosX+83+bpLRPromptPosX, bpLRPosY+100 ,100, 100,  0, 100, 500, 600, bpPriorityLR+0.7);
--男助手的数据：setImage(bpLRPosX+83+bpLRPromptPosX, bpLRPosY+95 ,100, 109,  0, 100, 611, 720, bpPriorityLR+0.7);
--女助手的数据：setImage(bpLRPosX+83+bpLRPromptPosX, bpLRPosY+95 ,100, 109,  0, 100, 720, 829, bpPriorityLR+0.7);
------------------------------------------------------------------------------------------

bpLRRewardGold = ImageClass:new();
bpLRRewardGold :setImageFileSize(bpLRWidth, bpLRHeight);
bpLRRewardGold :setImage(bpLRPosX+113+bpLRPromptPosX, bpLRPosY+130 ,70, 40,  400, 470, 500, 540, bpPriorityLR+0.7);


--数字
bpLRRewardNumberW = 23.6
bpLRRewardNumberH = 30

bpLRRewardNumberRed = 349
bpLRRewardNumberBlue = 380
bpLRRewardNumberGreen = 411
bpLRRewardNumberS = bpLRRewardNumberBlue -- 起始的Y位置

bpLRRewardNumber = ImageClass:new();
bpLRRewardNumber :setImageFileSize(bpLRWidth, bpLRHeight);
bpLRRewardNumber :setImage(bpLRPosX+217+bpLRPromptPosX, bpLRPosY+135 ,bpLRRewardNumberW, bpLRRewardNumberH,  0, 0, 0, 0, bpPriorityLR+0.7);

bpLRRewardPlus = ImageClass:new();
bpLRRewardPlus :setImageFileSize(bpLRWidth, bpLRHeight);
bpLRRewardPlus :setImage(bpLRPosX+188+bpLRPromptPosX, bpLRPosY+135 ,bpLRRewardNumberW, bpLRRewardNumberH,  0, bpLRRewardNumberW, bpLRRewardNumberS, bpLRRewardNumberS+bpLRRewardNumberH, bpPriorityLR+0.7);

--表情
bpLRExpreesion = ImageClass:new();
bpLRExpreesion :setImageFileSize(bpLRWidth, bpLRHeight);
bpLRExpreesion :setImage(bpLRPosX+280, bpLRPosY+100 ,110, 100,  800, 910, 346, 446, bpPriorityLR+0.89);
--未中奖表情
bpLRNPExpreesion = ImageClass:new();
bpLRNPExpreesion:setImageFileSize(bpLRWidth, bpLRHeight);
bpLRNPExpreesion:setImage(bpLRPosX+145, bpLRPosY+100 ,110, 100,  1200, 1310, 346, 446, bpPriorityLR+0.89);

bpLRNumberStatus = 0;
DrawNumberValue1 = 0;
DrawNumberValue2 = 0;
function DrawbpLotteryResult()
	
	if bpLRWinStatus then
		SetbpLRWinPos();
		
		
		bpLRTransBGI:DrawImage();
		
		

		bpLRWindow:DrawImage();
		bpLRAgainBtn:DrawImage();
		bpLRCloseBtn:DrawImage();
		
		if PrizeStatus == true then
			bpLRTile:DrawImage();
			bpLRExpreesion:DrawImage();
			bpLRRewardPlus:DrawImage();
			if GoldPropsStatus == false then
				bpLRRewardProps:DrawImage();
			else
				bpLRRewardGold:DrawImage();
			end
		else
			bpLRNotPrize:DrawImage();
			bpLRNPExpreesion:DrawImage();
		end
		
		if bpLRNumberStatus == 1 then
			DrawRewardOneNum(DrawNumberValue1)
		elseif bpLRNumberStatus == 2 then
			DrawRewardTwoNum(DrawNumberValue1, DrawNumberValue2);
		end
		
		
	end
end




function SetbpLRWinPos()
	if MouseStatus == MouseLeftDown then
		bpLRWindow:setRelativelyStartPos(MousePosX-LastMouseDownPosX , LastMouseDownPosY-MousePosY );
		bpLRAgainBtn:setRelativelyStartPos(MousePosX-LastMouseDownPosX , LastMouseDownPosY-MousePosY);
		bpLRCloseBtn:setRelativelyStartPos(MousePosX-LastMouseDownPosX , LastMouseDownPosY-MousePosY);
		
		bpLRTile:setRelativelyStartPos(MousePosX-LastMouseDownPosX , LastMouseDownPosY-MousePosY);
		bpLRRewardPlus:setRelativelyStartPos(MousePosX-LastMouseDownPosX , LastMouseDownPosY-MousePosY);
		bpLRRewardNumber:setRelativelyStartPos(MousePosX-LastMouseDownPosX , LastMouseDownPosY-MousePosY);
		bpLRExpreesion:setRelativelyStartPos(MousePosX-LastMouseDownPosX , LastMouseDownPosY-MousePosY);
		bpLRNotPrize:setRelativelyStartPos(MousePosX-LastMouseDownPosX , LastMouseDownPosY-MousePosY);
		bpLRRewardProps:setRelativelyStartPos(MousePosX-LastMouseDownPosX , LastMouseDownPosY-MousePosY);
		bpLRRewardGold:setRelativelyStartPos(MousePosX-LastMouseDownPosX , LastMouseDownPosY-MousePosY);
		bpLRNPExpreesion:setRelativelyStartPos(MousePosX-LastMouseDownPosX , LastMouseDownPosY-MousePosY);
		
		LastMouseDownPosX = MousePosX;
		LastMouseDownPosY = MousePosY;
	end
end




--奖励显示设置函数


bpLRMusic1 = seMusicClass:new();
bpLRMusic1:SetMusicData("music/LotteryResult1.wav");
bpLRMusic2 = seMusicClass:new();
bpLRMusic2:SetMusicData("music/LotteryResult2.wav");
bpLRMusic3 = seMusicClass:new();
bpLRMusic3:SetMusicData("music/LotteryResult3.wav");

function PrizeOfBigBomb(Bit)
	GoldPropsStatus = false;
	PrizeStatus = true;
	bpLRWinStatus = true;
	bpLRNumberStatus = 1;
	DrawNumberValue1 = Bit;
	if Bit == 1 then 
		bpLRPromptPosX = 0;
		bpLRRewardNumberS = bpLRRewardNumberBlue;
		bpLRExpreesion["DrawStatus"] = 0;
		bpLRTile:setImagePos(0, 150, bpLRWinHeight+3, bpLRWinHeight+3+40);
		bpLRMusic1:Play();
	elseif Bit == 2 then 
		bpLRPromptPosX = 0;
		bpLRRewardNumberS = bpLRRewardNumberGreen;
		bpLRExpreesion["DrawStatus"] = 0;
		bpLRTile:setImagePos(0, 150, bpLRWinHeight+3, bpLRWinHeight+3+40);
		bpLRMusic2:Play();
	elseif Bit == 3 then
		bpLRExpreesion["DrawStatus"] = 1;
		bpLRRewardNumberS = bpLRRewardNumberRed;
		bpLRTile:setImagePos(bpLRWinWidth*2, bpLRWinWidth*2+150, bpLRWinHeight+3, bpLRWinHeight+3+40);
		bpLRMusic3:Play();
	end
	bpLRRewardProps :setImagePos( 0, 100, 500, 600);
	bpLRWindow:setImagePos(bpLRWinWidth*(Bit-1), bpLRWinWidth*Bit,0, bpLRWinHeight);
end

function PrizeOfAssistant(Bit)
	GoldPropsStatus = false;
	PrizeStatus = true;
	bpLRWinStatus = true;
	bpLRWindow:setImagePos(bpLRWinWidth*(Bit-1), bpLRWinWidth*Bit,0, bpLRWinHeight);
	bpLRNumberStatus = 1;
	DrawNumberValue1 = Bit;
	if Bit == 1 then 
		bpLRPromptPosX = 0;
		bpLRRewardNumberS = bpLRRewardNumberBlue;
		bpLRExpreesion["DrawStatus"] = 0;
		bpLRTile:setImagePos(0, 150, bpLRWinHeight+3, bpLRWinHeight+3+40);
		bpLRMusic1:Play();
	elseif Bit == 2 then 
		bpLRPromptPosX = 0;
		bpLRRewardNumberS = bpLRRewardNumberGreen;
		bpLRExpreesion["DrawStatus"] = 0;
		bpLRTile:setImagePos(0, 150, bpLRWinHeight+3, bpLRWinHeight+3+40);
		bpLRMusic2:Play();
	elseif Bit == 3 then
		bpLRExpreesion["DrawStatus"] = 1;
		bpLRRewardNumberS = bpLRRewardNumberRed;
		bpLRTile:setImagePos(bpLRWinWidth*2, bpLRWinWidth*2+150, bpLRWinHeight+3, bpLRWinHeight+3+40);
		bpLRMusic3:Play();
	end
	
	if UserData["AssistantProps"] == GirlsAssistant then
		bpLRRewardProps:setImagePos(0, 100, 720, 829);
	elseif UserData["AssistantProps"] == BoysAssistant then
		bpLRRewardProps:setImagePos( 0, 100, 611, 720);
	end
	
	
end

function PrizeOfGoldCoins(Value)
	PrizeStatus = true;
	bpLRRewardGold["DrawStatus"] = 1;
	GoldPropsStatus = true;
	bpLRWinStatus = true;
	bpLRNumberStatus = 2;
	DrawNumberValue1 = GetBitNum(Value,1);
	DrawNumberValue2 = GetBitNum(Value,2);
	if Value <= 25 then
		bpLRWindow:setImagePos(bpLRWinWidth*(1-1), bpLRWinWidth*1,0, bpLRWinHeight);
		bpLRPromptPosX = 0;
		bpLRRewardNumberS = bpLRRewardNumberBlue;
		bpLRExpreesion["DrawStatus"] = 0;
		bpLRTile:setImagePos(0, 150, bpLRWinHeight+3, bpLRWinHeight+3+40);
		bpLRMusic1:Play();
	elseif 25 < Value and Value <= 35 then
		bpLRWindow:setImagePos(bpLRWinWidth*(2-1), bpLRWinWidth*2,0, bpLRWinHeight);
		bpLRPromptPosX = 0;
		bpLRRewardNumberS = bpLRRewardNumberGreen;
		bpLRExpreesion["DrawStatus"] = 0;
		bpLRTile:setImagePos(0, 150, bpLRWinHeight+3, bpLRWinHeight+3+40);
		bpLRMusic2:Play();
	elseif 35 < Value and Value <= 45 then
		bpLRExpreesion["DrawStatus"] = 1;
		bpLRWindow:setImagePos(bpLRWinWidth*(3-1), bpLRWinWidth*3,0, bpLRWinHeight);
		bpLRRewardNumberS = bpLRRewardNumberRed;
		bpLRTile:setImagePos(bpLRWinWidth*2, bpLRWinWidth*2+150, bpLRWinHeight+3, bpLRWinHeight+3+40);
		bpLRMusic3:Play();
	end
	
end
bpLRMusic4 = seMusicClass:new();
bpLRMusic4:SetMusicData("music/LotteryResult4.wav");
function NoPrize()
	PrizeStatus = false;
	GoldPropsStatus = true;
	bpLRWinStatus = true;
	bpLRNumberStatus = 0;
	bpLRWindow:setImagePos(bpLRWinWidth*(4-1), bpLRWinWidth*4,0, bpLRWinHeight);
	bpLRMusic4:Play();
end
-----------------------------------------

function DrawRewardOneNum(Bit)
	bpLRRewardNumber:setImagePos( bpLRRewardNumberW*(Bit+1), bpLRRewardNumberW*(Bit+2), bpLRRewardNumberS, bpLRRewardNumberS+bpLRRewardNumberH);
	bpLRRewardNumber:DrawImage();
end

function DrawRewardTwoNum(Ten, Bit)
	bpLRRewardNumber:setRelativelyStartPos(24,0);
	bpLRRewardNumber:setImagePos( bpLRRewardNumberW*(Bit+1), bpLRRewardNumberW*(Bit+2), bpLRRewardNumberS, bpLRRewardNumberS+bpLRRewardNumberH);
	bpLRRewardNumber:DrawImage();
	bpLRRewardNumber:setRelativelyStartPos(-24,0);
	bpLRRewardNumber :setImagePos( bpLRRewardNumberW*(Ten+1), bpLRRewardNumberW*(Ten+2), bpLRRewardNumberS, bpLRRewardNumberS+bpLRRewardNumberH);
	bpLRRewardNumber:DrawImage();
	
end


function SetBackPackData()
	ShowPropsIntro(0);
end
function LoadBakcpackImageFile()

	local ImageLoad = ImageClass:new();
	if NowLoadPos == 11 then
		ImageLoad:LoadImage(BackpackV,"Image/Shop/BackpackBackGround.png","DrawbpBackGroundFunc()", "Image_0");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 12 then
		ImageLoad:LoadImage(BackpackV,"Image/Return.png","DrawbpReturn()", "Image_1");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 13 then
		ImageLoad:LoadImage(BackpackV,"Image/Gold.png","DrawbpGold()", "Image_2");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 14 then
		ImageLoad:LoadImage(BackpackV,"Image/Number.png","DrawbpNumber()", "Image_3");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 15 then
		ImageLoad:LoadImage(BackpackV,"Image/Font.png","DrawbpFont()", "Image_4");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 16 then
		ImageLoad:LoadImage(BackpackV,"Image/ShortcutBar2.png","bpDrawShortCutBar()", "Image_5");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 17 then
		ImageLoad:LoadImage(BackpackV,"Image/Shop/LotteryBackGround.png","DrawbpLottery()", "Image_6");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 18 then
		ImageLoad:LoadImage(BackpackV,"Image/Shop/LotteryButton.png","DrawbpLotteryButton()", "Image_7");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 19 then
		ImageLoad:LoadImage(BackpackV,"Image/Shop/ShopProps.png","DrawbpProps()", "Image_8");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 20 then
		ImageLoad:LoadImage(BackpackV,"Image/Shop/LotteryResult.png","DrawbpLotteryResult()", "Image_9");
		NowLoadPos = NowLoadPos + 1;
	end
end





function GoBackpackVeiw()
	SetNowWindowView(BackpackV);
	SetBackPackData();
	NowView = BackpackV;--设置视图位于商城
end

























