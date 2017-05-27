
ShopReturnButton = ImageClass:new();
ShopReturnButton:setImageFileSize(570, 421);
ShopReturnButton:setscaling_ratio(0.3);
ShopReturnButton:setImage(50, 580-174*0.3, 174, 174, 0, 174, 0, 174, 9.9);

ShopBigBombProps = ImageClass:new();
ShopBigBombProps:setImageFileSize(570, 421);
ShopBigBombProps:setscaling_ratio(0.6);
ShopBigBombProps:setImage(50, 450-247*0.6, 223, 247, 0, 223, 174, 421, 9.8);

ShopBigBombPropsTemp = ImageClass:new();
ShopBigBombPropsTemp:setImageFileSize(570, 421);
ShopBigBombPropsTemp:setscaling_ratio(0.3);
ShopBigBombPropsTemp["DrawStatus"] = 0;
ShopBigBombPropsTemp:setImage(50, 450-247*0.6, 223, 247, 0, 223, 174, 421, 8.0);


function DrawShopAllIamge()
	
	
	ShopReturnButton:DrawImage();
	ShopBigBombProps:DrawImage();
	if ShopBigBombPropsTemp["DrawStatus"] == 1 then
		ShopBigBombPropsTemp:setAbsoluteStartPos(MousePosX-ShopBigBombPropsTemp["Width"]/2,600.0 - MousePosY- ShopBigBombPropsTemp["Height"]/2);
		ShopBigBombPropsTemp:DrawImage();
	end
	
end

function LoadShopImageFile()
	local ShopBackGround = ImageClass:new();
	
	ShopBackGround:LoadImage("Image/BackGround.png","DrawBackGroundFunc()", "Image_0");
	ShopBackGround:LoadImage("Image/PropsBomb.png","DrawShopAllIamge()", "Image_1");
	PlayMusic(BGMDevice,"music/ShopVeiwBGM.wav");
end































