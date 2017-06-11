

LoadViewBGI = ImageClass:new();
LoadViewBGI:setImageFileSize(1000, 600);
LoadViewBGI:setImage(0, 0, 1000, 600, 0, 1000, 0, 600, 19.9);


function DrawLoadViewBGI()
	LoadViewBGI:DrawImage();
end
ProgressBarPosX = 250
ProgressBarPosY = 50

ProgressBarBGI = ImageClass:new();
ProgressBarBGI:setImageFileSize(500, 61);
ProgressBarBGI:setImage(ProgressBarPosX, ProgressBarPosY, 500, 34, 0, 500, 0, 34, 18.9);

ProgressBarW = 484

ProgressBar = ImageClass:new();
ProgressBar:setImageFileSize(500, 61);
ProgressBar:setImage(ProgressBarPosX+8, ProgressBarPosY+7, 0, 19, 0, 484, 41, 60, 18.8);


function DrawLVProgressBar()
	
	ProgressBar:DrawImage();
	ProgressBarBGI:DrawImage();
end

JumpPageDelay = 50

function LoadVKeyFunc()
	LoadStartViewImageFile();
	LoadShopImageFile();
	LoadBakcpackImageFile();
	LoadMapViewImageFile();
	if NowLoadPos == AllImageNum + 1 then
		JumpPageDelay = JumpPageDelay - 1;
		if JumpPageDelay == 0 then
			goStartView(); 
		end
	else
		ProgressBar:setImageShowSize(ProgressBarW*NowLoadPos/AllImageNum,19);
	end
end

function GoLoadView()
	SetNowWindowView(LoadV);
	NowView = LoadV;--设置视图位于商城
end





function LoadThisBackGroundImage()
	local ImageLoad = ImageClass:new();
	ImageLoad:LoadImage(LoadV,"Image/Load/LoadBackGroudImage.png","DrawLoadViewBGI()", "Image_0");
	ImageLoad:LoadImage(LoadV,"Image/Load/ProgressBar.png","DrawLVProgressBar()", "Image_1");
end