

ShopPriorityBGI   = 20
ShopPriorityRB = 19
ShopPriorityGold = 18
ShopPriorityNumber = 17
ShopPriorityFont   = 16
ShopPriorityBB  = 15
ShopPriorityBackPack = 14
ShopPriorityBBP = 13
-----------------------------------------
ShopPriorityTwo   = 12
ShopPriorityOne   = 11

ShopReturnButton = ImageClass:new();
ShopReturnButton:setImageFileSize(521, 172);
ShopReturnButton:setscaling_ratio(0.3);
ShopReturnButton:setImage(520, 590-174*0.3, 173.7, 172, 0, 173.7, 0, 172, ShopPriorityRB+0.9);




function DrawShopReturn()
	ShopReturnButton:DrawImage();
end

ShopPropsImageW = 1720
ShopPropsImageH = 2800
OnePropsImageW = 860
OnePropsImageH = 1392 
PropsW = 266
PropsH = 266




----------------------------------------------------------

--------------------------------------
ShopBigBombProps = ImageClass:new();
ShopBigBombProps:setImageFileSize(ShopPropsImageW, ShopPropsImageH);
ShopBigBombProps:setscaling_ratio(0.5);
ShopBigBombProps:setImage(500, 510-PropsH*0.5, PropsW, PropsH, 0, 0, 0, 0, ShopPriorityBBP+0.80);

ShopBigBombPropsTemp = ImageClass:new();
ShopBigBombPropsTemp:setImageFileSize(ShopPropsImageW, ShopPropsImageH);
ShopBigBombPropsTemp:setscaling_ratio(0.3);
ShopBigBombPropsTemp["DrawStatus"] = 0;
ShopBigBombPropsTemp:setImage(0, 0, 237, 237, PropsW*2+10, 779, 0, 237, ShopPriorityBBP+0.40);

ShopBigBombIntr = ImageClass:new();
ShopBigBombIntr:setImageFileSize(ShopPropsImageW, ShopPropsImageH);
ShopBigBombIntr:setscaling_ratio(0.52);
ShopBigBombIntr["DrawStatus"] = 0;
ShopBigBombIntr:setImage(30, 10, 860, 1123, 0, 860, 268, OnePropsImageH-1, ShopPriorityBBP+0.99);

-------------------------------------------------
--当前解锁助手标志
AssistantProps = UserData["AssistantProps"]
-------------------------------------------------


-------------------------------------------------
ShopAssistantPropsProps = ImageClass:new();
ShopAssistantPropsProps:setImageFileSize(ShopPropsImageW, ShopPropsImageH);
ShopAssistantPropsProps:setscaling_ratio(0.5);
ShopAssistantPropsProps:setImage(500, 360-PropsH*0.5, PropsW, PropsH, 0, 0, 0, 0, ShopPriorityBBP+0.80);

ShopAssistantPropsPropsTemp = ImageClass:new();
ShopAssistantPropsPropsTemp:setImageFileSize(ShopPropsImageW, ShopPropsImageH);
ShopAssistantPropsPropsTemp:setscaling_ratio(0.3);
ShopAssistantPropsPropsTemp["DrawStatus"] = 0;
ShopAssistantPropsPropsTemp:setImage(0, 0, 237, 237, PropsW*2+10+OnePropsImageW*AssistantProps, 779+OnePropsImageW*AssistantProps, OnePropsImageH+16, 237+OnePropsImageH+16, ShopPriorityBBP+0.40);

ShopAssistantPropsPropsIntr = ImageClass:new();
ShopAssistantPropsPropsIntr:setImageFileSize(ShopPropsImageW, ShopPropsImageH);
ShopAssistantPropsPropsIntr:setscaling_ratio(0.52);
ShopAssistantPropsPropsIntr["DrawStatus"] = 0;
ShopAssistantPropsPropsIntr:setImage(30, 10, 860, 1123, 0+OnePropsImageW*AssistantProps, 860+OnePropsImageW*AssistantProps, 268+OnePropsImageH+16, OnePropsImageH-1+OnePropsImageH+16, ShopPriorityBBP+0.99);

function DrawShopProps()
	ShopBigBombIntr:DrawImage();
	ShopBigBombProps:DrawImage();

	if UserData["AssistantLock"] == 0 then
		ShopAssistantPropsPropsIntr:DrawImage();
		ShopAssistantPropsProps:DrawImage();
	end
	
end


ShopBackGround = ImageClass:new();
ShopBackGround:setImageFileSize(1000, 1200);
ShopBackGround:setImage(0, 0, 1000, 600, 0, 1000, 0, 600, ShopPriorityBGI+0.99);

ShopIntroDefault = ImageClass:new();
ShopIntroDefault :setImageFileSize(1000, 1200);
ShopIntroDefault:setscaling_ratio(0.973);
ShopIntroDefault :setImage(30, 10, 461, 600, 0, 461, 601, 1200, ShopPriorityBGI+0.98);

function DrawShopBackGroundFunc()
	ShopBackGround:DrawImage();
	ShopIntroDefault:DrawImage();
end







-------------------------------------------------------画数字
NumberW = 76.5;
NumberH = 87.8;
PriceNumberPriority = 0.3



function DrawNumber()
	
	if UserData["BigBombPropsAmount"] >= 10 then
		DrawTwoNumber(880,385,GetBitNum(UserData["BigBombPropsAmount"],1), GetBitNum(UserData["BigBombPropsAmount"],2),1);
	else
		DrawTwoNumber(880,385, 0, GetBitNum(UserData["BigBombPropsAmount"],1),1);
	end
	--助手拥有个数
	if UserData["AssistantLock"] == 0 then
		if UserData["AssistantPropsAmount"] >= 10 then
			DrawTwoNumber(880,235,GetBitNum(UserData["AssistantPropsAmount"],1), GetBitNum(UserData["AssistantPropsAmount"],2),1);
		else
			DrawTwoNumber(880,235, 0, GetBitNum(UserData["AssistantPropsAmount"],1),1);
		end
	end
	
	DrawTwoNumber(740,470,GetBitNum(BigBombNeeds,1), GetBitNum(BigBombNeeds,2),2)
	--助手价格
	if UserData["AssistantLock"] == 0 then
		DrawTwoNumber(740,320,GetBitNum(AssistantPropsNeeds,1), GetBitNum(AssistantPropsNeeds,2),2)
	end
	
	
	if UserData["GoldCoins"] < 10 then
		DrawFourNumber(600, 70, 0, 0, 0, GetBitNum(UserData["GoldCoins"],1))
	elseif UserData["GoldCoins"] < 100 then
		DrawFourNumber(600, 70, 0, 0,GetBitNum(UserData["GoldCoins"],1), GetBitNum(UserData["GoldCoins"],2))
	elseif UserData["GoldCoins"] < 1000 then
		DrawFourNumber(600, 70, 0, GetBitNum(UserData["GoldCoins"],1),GetBitNum(UserData["GoldCoins"],2), GetBitNum(UserData["GoldCoins"],3))
	else
		DrawFourNumber(600, 70, GetBitNum(UserData["GoldCoins"],1), GetBitNum(UserData["GoldCoins"],2),GetBitNum(UserData["GoldCoins"],3), GetBitNum(UserData["GoldCoins"],4))
	end
	
end



function DrawFourNumber(sx, sy, Tho, Hun, Ten, Bit)
	local Color = 1;
	if Tho ~= 0 then
		DrawNumberFunc(sx, sy, PriceNumberPriority, Tho, Color);
	end
	if Hun == 0 and Tho == 0  then
		
	else
		DrawNumberFunc(sx+NumberW*PriceNumberPriority, sy, PriceNumberPriority, Hun, Color);
	end
	if Hun == 0 and Tho == 0 and Ten == 0 then
		
	else
		DrawNumberFunc(sx+NumberW*PriceNumberPriority*2, sy, PriceNumberPriority, Ten, Color);
	end
	DrawNumberFunc(sx+NumberW*PriceNumberPriority*3, sy, PriceNumberPriority, Bit, Color);
end


function DrawTwoNumber(sx, sy, Ten, Bit,Color)
	if Ten ~= 0 then
		DrawNumberFunc(sx, sy, PriceNumberPriority, Ten, Color);
	end
	DrawNumberFunc(sx+NumberW*PriceNumberPriority, sy, PriceNumberPriority, Bit, Color);
	
end

function DrawNumberFunc(sx, sy, P, Num, Color)
	
	local NumberImage = ImageClass:new();
	NumberImage :setImageFileSize(765, 439);
	NumberImage :setImage(sx, sy ,NumberW*P, NumberH*P, NumberW*Num, NumberW*(Num+1), NumberH*(Color-1), NumberH*Color, ShopPriorityNumber+0.9);
	NumberImage :DrawImage();
end

-------------------------------------------------------画字体

FontImageW = 683
FontImageH = 100


GoldFont = ImageClass:new();
GoldFont :setImageFileSize(FontImageW, FontImageH);
GoldFont :setscaling_ratio(0.3);
GoldFont :setImage(800, 470 ,180, FontImageH, 0, 180,0, FontImageH, ShopPriorityFont+0.9);

OverageFont = ImageClass:new();
OverageFont :setImageFileSize(FontImageW, FontImageH);
OverageFont :setscaling_ratio(0.3);
OverageFont :setImage(520, 70 ,212, FontImageH, 180, 392,0, FontImageH, ShopPriorityFont+0.9);

FontGE = ImageClass:new();
FontGE :setImageFileSize(FontImageW, FontImageH);
FontGE :setscaling_ratio(0.3);
FontGE :setImage(800, 420 ,93, FontImageH, 400, 493,0, FontImageH, ShopPriorityFont+0.9);


function DrawFont()
	
	
	OverageFont:setAbsoluteStartPos(800,385);
	OverageFont:DrawImage();
	FontGE:setAbsoluteStartPos(930,385);
	FontGE:DrawImage();
	
	GoldFont :setAbsoluteStartPos(800,470);
	GoldFont :DrawImage();
	
	if UserData["AssistantLock"] == 0 then
		GoldFont :setAbsoluteStartPos(800,320);
		GoldFont :DrawImage();
		
		OverageFont:setAbsoluteStartPos(800,235);
		OverageFont:DrawImage();
		FontGE:setAbsoluteStartPos(930,235);
		FontGE:DrawImage();
	end
	
	
	OverageFont:setAbsoluteStartPos(520,70);
	OverageFont:DrawImage();
	GoldFont :setAbsoluteStartPos(700,70);
	GoldFont :DrawImage();
	
	
end






-------------------------------------------------------画金币

GoldA1 = AnimationRecord:new();
GoldA1:SetValue(660, 460, 20, 8);

GoldA2 = AnimationRecord:new();
GoldA2:SetValue(660, 310, 20, 8);
function DrawGold()

	DrawGoldFunc(GoldA1["StartX"], GoldA1["StartY"], GoldA1:TimerGo() );
	if UserData["AssistantLock"] == 0 then
		DrawGoldFunc(GoldA2["StartX"], GoldA2["StartY"], GoldA2:TimerGo() );
	end
end



function DrawGoldFunc(sx, sy, fr)
	local GoldAnimation = ImageClass:new();
	GoldAnimation :setImageFileSize(785, 628);
	if fr == 1 then
		GoldAnimation:setImage(sx+0, sy, 50, 50, 0,   302, 0,   314,  ShopPriorityGold+0.9);
	elseif fr == 2 then
		GoldAnimation:setImage(sx+6, sy, 42, 50, 310, 520, 0,   314,  ShopPriorityGold+0.9);
	elseif fr == 3 or fr == 7 then
		GoldAnimation:setImage(sx+22,sy, 10, 50, 730, 785, 0,   302,  ShopPriorityGold+0.9);
	elseif fr == 4 then
		GoldAnimation:setImage(sx+6, sy, 42, 50, 520, 730, 0,   314,  ShopPriorityGold+0.9);
	elseif fr == 5 then
		GoldAnimation:setImage(sx+0, sy, 50, 50, 0,   302, 318, 632,  ShopPriorityGold+0.9);
	elseif fr == 6 then
		GoldAnimation:setImage(sx+6, sy, 42, 50, 310, 520, 318, 632,  ShopPriorityGold+0.9);
	elseif fr == 8 then
		GoldAnimation:setImage(sx+6, sy, 42, 50, 520, 730, 318, 632,  ShopPriorityGold+0.9);
	end
	GoldAnimation:DrawImage();
end

-------------------------------------------------画购买按钮

BuyBigBombButton = ImageClass:new();
BuyBigBombButton :setImageFileSize(320, 438);
BuyBigBombButton :setscaling_ratio(0.4);
BuyBigBombButton :setImage(650, 370 ,320, 146, 0, 320, 0, 146, ShopPriorityBB+0.9);

BuyAssistantButton = ImageClass:new();
BuyAssistantButton :setImageFileSize(320, 438);
BuyAssistantButton :setscaling_ratio(0.4);
BuyAssistantButton :setImage(650, 220 ,320, 146, 0, 320, 0, 146, ShopPriorityBB+0.9);
function DrawBuyButton()
	
	BuyBigBombButton:DrawImage();
	if UserData["AssistantLock"] == 0 then
		BuyAssistantButton:DrawImage();
	end
	
end
-------------------------------------------------画背包
backpack = ImageClass:new();
backpack :setImageFileSize(535, 184);
backpack :setscaling_ratio(0.5);
backpack :setImage(900, 50 ,178, 184, 0, 178, 0, 184, ShopPriorityBackPack+0.9);


function Drawbackpack()
	backpack:DrawImage();
end









function LoadShopImageFile()

	local ImageLoad = ImageClass:new();
	if NowLoadPos == 3 then
		ImageLoad:LoadImage(ShopV,"Image/Shop/ShopBackGoundIMage.png","DrawShopBackGroundFunc()", "Image_0");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 4 then
		ImageLoad:LoadImage(ShopV,"Image/Return.png","DrawShopReturn()", "Image_1");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 5 then
		ImageLoad:LoadImage(ShopV,"Image/Gold.png","DrawGold()", "Image_2");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 6 then
		ImageLoad:LoadImage(ShopV,"Image/Number.png","DrawNumber()", "Image_3");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 7 then
		ImageLoad:LoadImage(ShopV,"Image/Font.png","DrawFont()", "Image_4");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 8 then
		ImageLoad:LoadImage(ShopV,"Image/Shop/BuyButton.png","DrawBuyButton()", "Image_5");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 9 then
		ImageLoad:LoadImage(ShopV,"Image/Shop/backpack.png","Drawbackpack()", "Image_6");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 10 then
		ImageLoad:LoadImage(ShopV,"Image/Shop/ShopProps.png","DrawShopProps()", "Image_7");
		NowLoadPos = NowLoadPos + 1;
	end
	
	ShowPropsIntro(0);
end































