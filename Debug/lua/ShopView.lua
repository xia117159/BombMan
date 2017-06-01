

ShopPriorityBGI   = 10
ShopPriorityRB = 9
ShopPriorityGold = 8
ShopPriorityNumber = 7
ShopPriorityFont   = 6
ShopPriorityBB  = 5
ShopPriorityBackPack = 4
ShopPriorityBBP = 3
ShopPriorityTwo   = 2
ShopPriorityOne   = 1

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
BigBombNeeds = 15-- 需要的金币数量
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
AssistantPropsNeeds = 30 -- 需要的金币数量

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
ShopBackGround:setImageFileSize(1875, 2250);
ShopBackGround:setImage(0, 0, 1000, 600, 0, 1875, 0, 1125, ShopPriorityBGI+0.99);

ShopIntroDefault = ImageClass:new();
ShopIntroDefault :setImageFileSize(1875, 2250);
ShopIntroDefault:setscaling_ratio(0.52);

ShopIntroDefault :setImage(30, 10, 860, 1123, 0, 860, 1126, 2249, ShopPriorityBGI+0.98);

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

FontImageW = 493
FontImageH = 95


GoldFont = ImageClass:new();
GoldFont :setImageFileSize(FontImageW, FontImageH);
GoldFont :setscaling_ratio(0.3);
GoldFont :setImage(800, 470 ,180, 95, 0, 180,0, 95, ShopPriorityFont+0.9);

OverageFont = ImageClass:new();
OverageFont :setImageFileSize(FontImageW, FontImageH);
OverageFont :setscaling_ratio(0.3);
OverageFont :setImage(520, 70 ,212, 95, 180, 392,0, 95, ShopPriorityFont+0.9);

FontGE = ImageClass:new();
FontGE :setImageFileSize(FontImageW, FontImageH);
FontGE :setscaling_ratio(0.3);
FontGE :setImage(800, 420 ,93, 95, 400, 493,0, 95, ShopPriorityFont+0.9);



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
backpack :setImageFileSize(639, 410);
backpack :setscaling_ratio(0.2);
backpack :setImage(900, 50 ,300, 410, 0, 300, 0, 410, ShopPriorityBackPack+0.9);

function Drawbackpack()
	backpack:DrawImage();
end









function LoadShopImageFile()

	local ImageLoad = ImageClass:new();
	ImageLoad:LoadImage("Image/Shop/ShopBackGoundIMage.png","DrawShopBackGroundFunc()", "Image_0");
	ImageLoad:LoadImage("Image/Return.png","DrawShopReturn()", "Image_1");
	ImageLoad:LoadImage("Image/Gold.png","DrawGold()", "Image_2");
	ImageLoad:LoadImage("Image/Number.png","DrawNumber()", "Image_3");
	ImageLoad:LoadImage("Image/Font1.png","DrawFont()", "Image_4");
	ImageLoad:LoadImage("Image/Shop/BuyButton.png","DrawBuyButton()", "Image_5");
	ImageLoad:LoadImage("Image/Shop/backpack1.png","Drawbackpack()", "Image_6");
	ImageLoad:LoadImage("Image/Shop/ShopProps.png","DrawShopProps()", "Image_7");
	
	ShowPropsIntro(0);
end































