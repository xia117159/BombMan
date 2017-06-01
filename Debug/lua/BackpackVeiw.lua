

bpPriorityBGI   = 10
bpPriorityRB = 9
bpPriorityGold = 8
bpPriorityNumber = 7
bpPriorityFont   = 6
bpPrioritySCB = 5
bpPriorityBBP  = 4

-------------
bpPriorityBBP = 3
bpPriorityTwo   = 2
bpPriorityOne   = 1

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
bpBackGround:setImageFileSize(1875, 1125);
bpBackGround:setImage(0, 0, 1000, 600, 0, 1875, 0, 1125, bpPriorityBGI+0.99);

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
end



-------------------------------------------------------画字体

bpGoldFont = ImageClass:new();
bpGoldFont :setImageFileSize(FontImageW, FontImageH);
bpGoldFont :setscaling_ratio(0.3);
bpGoldFont :setImage(800, 140 ,180, 95, 0, 180,0, 95, ShopPriorityFont+0.9);

bpOverageFont = ImageClass:new();
bpOverageFont :setImageFileSize(FontImageW, FontImageH);
bpOverageFont :setscaling_ratio(0.3);
bpOverageFont :setImage(620, 140 ,212, 95, 180, 392,0, 95, ShopPriorityFont+0.9);

bpFontGE = ImageClass:new();
bpFontGE :setImageFileSize(FontImageW, FontImageH);
bpFontGE :setscaling_ratio(0.3);
bpFontGE :setImage(800, 420 ,93, 95, 400, 493,0, 95, ShopPriorityFont+0.9);


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
	
	bpGoldFont :DrawImage();
	
end






-------------------------------------------------------画金币

bpGoldA1 = AnimationRecord:new();
bpGoldA1:SetValue(550, 130, 20, 8);

function DrawbpGold()
	DrawGoldFunc(bpGoldA1["StartX"], bpGoldA1["StartY"], bpGoldA1:TimerGo() );
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








function LoadBakcpackImageFile()

	local ImageLoad = ImageClass:new();
	ImageLoad:LoadImage("Image/Shop/BackpackBackGround.png","DrawbpBackGroundFunc()", "Image_0");
	ImageLoad:LoadImage("Image/Return.png","DrawbpReturn()", "Image_1");
	ImageLoad:LoadImage("Image/Gold.png","DrawbpGold()", "Image_2");
	ImageLoad:LoadImage("Image/Number.png","DrawbpNumber()", "Image_3");
	ImageLoad:LoadImage("Image/Font1.png","DrawbpFont()", "Image_4");
	ImageLoad:LoadImage("Image/ShortcutBar2.png","bpDrawShortCutBar()", "Image_5");
	ImageLoad:LoadImage("Image/Shop/ShopProps.png","DrawbpProps()", "Image_6");
	
	
	ShowPropsIntro(0);
end





function GoBackpackVeiw()
	
	ReleaseImageData();--清除图片资源以便目标页面加载
	LoadBakcpackImageFile();---加载商城界面自行添加
	NowView = BackpackV;--设置视图位于商城
end

























