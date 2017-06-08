


--程序框大小设定，改变无用！
ButtonImagePath  = "Image/StartButton.png"
ButtonImageWidth = 600.0
ButtonImageHeight= 513.0
ButtonWidth      = 200.0
ButtonHeight     = 85.5
ButtonSR         = 0.95

BackGround = ImageClass:new();
BackGround:setImageFileSize(1800, 1080);
BackGround:setImage(0, 0, 1000, 600, 0, 1800, 0, 1080, 10.0);

function DrawBackGroundFunc()
	BackGround:DrawImage();
end

ksButton = ImageClass:new();
ksButton:setImageFileSize(ButtonImageWidth, ButtonImageHeight);
ksButton:setscaling_ratio(ButtonSR);

tzButton = ImageClass:new();
tzButton:setImageFileSize(ButtonImageWidth, ButtonImageHeight);
tzButton:setscaling_ratio(ButtonSR);

djButton = ImageClass:new();
djButton:setImageFileSize(ButtonImageWidth, ButtonImageHeight);
djButton:setscaling_ratio(ButtonSR);

cdButton = ImageClass:new();
cdButton:setImageFileSize(ButtonImageWidth, ButtonImageHeight);
cdButton:setscaling_ratio(ButtonSR);

bzButton = ImageClass:new();
bzButton:setImageFileSize(ButtonImageWidth, ButtonImageHeight);
bzButton:setscaling_ratio(ButtonSR);

tcButton = ImageClass:new();
tcButton:setImageFileSize(ButtonImageWidth, ButtonImageHeight);
tcButton:setscaling_ratio(ButtonSR);

ksButton:setImage(50.0, 550.0-1*ButtonHeight*ButtonSR, ButtonWidth, ButtonHeight, 0, ButtonWidth, ButtonHeight*0, ButtonHeight*1, 9.0);
tzButton:setImage(50.0, 550.0-2*ButtonHeight*ButtonSR, ButtonWidth, ButtonHeight, 0, ButtonWidth, ButtonHeight*1, ButtonHeight*2, 8.99);
djButton:setImage(50.0, 550.0-3*ButtonHeight*ButtonSR, ButtonWidth, ButtonHeight, 0, ButtonWidth, ButtonHeight*2, ButtonHeight*3, 8.98);
bzButton:setImage(50.0, 550.0-5*ButtonHeight*ButtonSR, ButtonWidth, ButtonHeight, 0, ButtonWidth, ButtonHeight*3, ButtonHeight*4, 8.96);
cdButton:setImage(50.0, 550.0-4*ButtonHeight*ButtonSR, ButtonWidth, ButtonHeight, 0, ButtonWidth, ButtonHeight*4, ButtonHeight*5, 8.97);
tcButton:setImage(50.0, 550.0-6*ButtonHeight*ButtonSR, ButtonWidth, ButtonHeight, 0, ButtonWidth, ButtonHeight*5, ButtonHeight*6, 8.95);


function DrawButtonFunc()

	ksButton:DrawImage();
	tzButton:DrawImage();
	djButton:DrawImage();
	bzButton:DrawImage();
	cdButton:DrawImage();
	tcButton:DrawImage();
end




function LoadStartViewImageFile()
	local ImageLoad = ImageClass:new();
	ImageLoad:LoadImage(StartV,"Image/BackGround.png","DrawBackGroundFunc()", "Image_0");
	ImageLoad:LoadImage(StartV,ButtonImagePath,"DrawButtonFunc()", "Image_1");
end



















