
ShopBackGround = ImageClass:new();
ShopBackGround:setImageFileSize(929, 624);
ShopBackGround:setImage(0, 0, 743, 499, 0, 929, 0, 624, 10.0);

ShopBackGround2 = ImageClass:new();
ShopBackGround2:setImageFileSize(929, 624);
ShopBackGround2:setImage(100, 100, 743, 499, 0, 929, 0, 624, 9.9);


function asdfasdasda()
	ShopBackGround:DrawImage();
	ShopBackGround2:DrawImage();
end

function LoadShopImageFile()
	ShopBackGround:LoadImage("Image/TEMP.png","asdfasdasda()", "Image_0");
end

--[[ShopBackGround = ImageClass:new();

ShopBackGround:setImageFileSize(929, 624);
ShopBackGround:setImage(0, 0, 743, 499, 0, 929, 0, 624, 10.0);

function DrawShopBGIfunc()
	ShopBackGround:DrawImage();
end

function LoadShopImageFile()
	ShopBackGround:LoadImage("Image/TEMP.png","DrawShopBGIfunc()", "Image_0");
end--]]



--[[ksButton = ImageClass:new();
ksButton:LoadImage(ButtonImagePath,"DrawButtonFunc()", "Image_1");
ksButton:setImageFileSize(ButtonImageWidth, ButtonImageHeight);
ksButton:setscaling_ratio(0.5);

tzButton = ImageClass:new();
tzButton:setImageFileSize(ButtonImageWidth, ButtonImageHeight);
tzButton:setscaling_ratio(0.5);

djButton = ImageClass:new();
djButton:setImageFileSize(ButtonImageWidth, ButtonImageHeight);
djButton:setscaling_ratio(0.5);

cdButton = ImageClass:new();
cdButton:setImageFileSize(ButtonImageWidth, ButtonImageHeight);
cdButton:setscaling_ratio(0.5);

bzButton = ImageClass:new();
bzButton:setImageFileSize(ButtonImageWidth, ButtonImageHeight);
bzButton:setscaling_ratio(0.5);

tcButton = ImageClass:new();
tcButton:setImageFileSize(ButtonImageWidth, ButtonImageHeight);
tcButton:setscaling_ratio(0.5);

ksButton:setImage(50.0, 550.0-1*ButtonHeight*0.5, ButtonWidth, ButtonHeight, 0,           ButtonWidth,   0,              ButtonHeight,   9.0);
tzButton:setImage(50.0, 550.0-2*ButtonHeight*0.5, ButtonWidth, ButtonHeight, ButtonWidth, ButtonWidth*2, 0,              ButtonHeight,   8.99);
djButton:setImage(50.0, 550.0-3*ButtonHeight*0.5, ButtonWidth, ButtonHeight, 0,           ButtonWidth,   ButtonHeight*2, ButtonHeight*3, 8.98);
cdButton:setImage(50.0, 550.0-4*ButtonHeight*0.5, ButtonWidth, ButtonHeight, ButtonWidth, ButtonWidth*2, ButtonHeight*2, ButtonHeight*3, 8.97);
bzButton:setImage(50.0, 550.0-5*ButtonHeight*0.5, ButtonWidth, ButtonHeight, 0,           ButtonWidth,   ButtonHeight*4, ButtonHeight*5, 8.96);
tcButton:setImage(50.0, 550.0-6*ButtonHeight*0.5, ButtonWidth, ButtonHeight, ButtonWidth, ButtonWidth*2, ButtonHeight*4, ButtonHeight*5, 8.95);


function DrawButtonFunc()
	ksButton:DrawImage();

	tzButton:DrawImage();
	
	djButton:DrawImage();
	
	cdButton:DrawImage();
	
	bzButton:DrawImage();
	
	tcButton:DrawImage();
end
--临时按钮移动动画
function Animation(functable)
	if functable["Status"] == 1 then 
		functable:setRelativelyStartPos(1.0, 0.0);
		if(functable["StartX"] >= 1000.0 - tzButton["Width"]) then functable["Status"] = 3 end
	elseif functable["Status"] == 2 then
		functable:setRelativelyStartPos(-1.0, 0.0);
		if(functable["StartX"] <= 0) then functable["Status"] = 4 end
	elseif functable["Status"] == 3 then 
		functable:setRelativelyStartPos(0.0, 1.0);
		if(functable["StartY"] >= 600.0 - tzButton["Height"]) then functable["Status"] = 2 end
	elseif functable["Status"] == 4 then
		functable:setRelativelyStartPos(0.0, -1.0);
		if(functable["StartY"] <= 0) then functable["Status"] = 1 end
	end
end



function Impact_checking()

	if Status == 1 then 
		tzButton:setRelativelyStartPos(1.0, 0.0);
		if(tzButton["StartX"] >= 1000.0 - tzButton["Width"]) then Status = 3 end
	elseif Status == 2 then
		tzButton:setRelativelyStartPos(-1.0, 0.0);
		if(tzButton["StartX"] <= 0) then Status = 4 end
	elseif Status == 3 then 
		tzButton:setRelativelyStartPos(0.0, 1.0);
		if(tzButton["StartY"] >= 600.0 - tzButton["Height"]) then Status = 2 end
	elseif Status == 4 then
		tzButton:setRelativelyStartPos(0.0, -1.0);
		if(tzButton["StartY"] <= 0) then Status = 1 end
	end
end
function PlayBackGroundMusic()
	PlayMusic("music/BackGroundMusic.wav");
end
PlayBackGroundMusic();
--]]





























