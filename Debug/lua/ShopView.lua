
ShopReturnButton = ImageClass:new();
ShopReturnButton:setImageFileSize(521, 172);
ShopReturnButton:setscaling_ratio(0.3);
ShopReturnButton:setImage(50, 534-174*0.3, 173.7, 172, 0, 173.7, 0, 172, 6.9);




function DrawShopReturn()
	ShopReturnButton:DrawImage();
end

BigBombPropsImageW = 860
BigBombPropsImageH = 1392

BigBombPropsW = 266
BigBombPropsH = 266

ShopBigBombProps = ImageClass:new();
ShopBigBombProps:setImageFileSize(BigBombPropsImageW, BigBombPropsImageH);
ShopBigBombProps:setscaling_ratio(0.5);
ShopBigBombProps:setImage(500, 560-BigBombPropsH*0.5, BigBombPropsW, BigBombPropsH, 0, 0, 0, 0, 9.88);



ShopBigBombPropsTemp = ImageClass:new();
ShopBigBombPropsTemp:setImageFileSize(BigBombPropsImageW, BigBombPropsImageH);
ShopBigBombPropsTemp:setscaling_ratio(0.38);
ShopBigBombPropsTemp["DrawStatus"] = 0;
ShopBigBombPropsTemp:setImage(0, 0, 237, 237, BigBombPropsW*2+10, 779, 0, 237, 9.87);

ShopBigBombIntr = ImageClass:new();
ShopBigBombIntr:setImageFileSize(BigBombPropsImageW, BigBombPropsImageH);
ShopBigBombIntr:setscaling_ratio(0.52);
ShopBigBombIntr["DrawStatus"] = 0;
ShopBigBombIntr:setImage(30, 10, 860, 1126, 0, 859, 253, BigBombPropsImageH-2, 9.99);



function DrawShopBigBomb()
	ShopBigBombIntr:DrawImage();
	ShopBigBombProps:DrawImage();
	
	if ShopBigBombPropsTemp["DrawStatus"] == 1 then
		ShopBigBombPropsTemp:setAbsoluteStartPos(MousePosX-ShopBigBombPropsTemp["Width"]/2,600.0 - MousePosY- ShopBigBombPropsTemp["Height"]/2);
		ShopBigBombPropsTemp:DrawImage();
	end
	
	
end



function LoadShopImageFile()
	local ShopBackGround = ImageClass:new();
	
	ShopBackGround:LoadImage("Image/BackGround.png","DrawBackGroundFunc()", "Image_0");
	ShopBigBombProps:LoadImage("Image/BigBomb.png","DrawShopBigBomb()", "Image_1");
	ShopReturnButton:LoadImage("Image/Return.png","DrawShopReturn()", "Image_2");
end































