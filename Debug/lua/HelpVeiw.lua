function LoadHelpVeiwImagePath()
	local ImageLoad = ImageClass:new();
	if NowLoadPos == 34 then
		ImageLoad:LoadImage(HelpV,"Image/Help.jpg","DrawHelpBGIFunc()", "Image_0");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 35 then
		ImageLoad:LoadImage(HelpV,"Image/Return.png","DrawReturnButtonFunc()", "Image_1");
		NowLoadPos = NowLoadPos + 1;
	end
end
 

HelpBGI = ImageClass:new();
HelpBGI :setImageFileSize(1000, 600);
HelpBGI :setImage(0, 0 ,1000, 600,  0, 1000,0, 600, 5.5);

function DrawHelpBGIFunc()
	HelpBGI:DrawImage();
end


HelpReturnButton = ImageClass:new();
HelpReturnButton:setImageFileSize(521, 172);
HelpReturnButton:setscaling_ratio(0.3);
HelpReturnButton:setImage(90, 530-174*0.3, 173.7, 172, 0, 173.7, 0, 172, 4.9);


function DrawReturnButtonFunc()
	HelpReturnButton:DrawImage();
end


HelpReturnButtonSE = seMusicClass:new();
HelpReturnButtonSE:SetMusicData("music/ButtonSE1.wav");
function HelpKeyControlFunc()
	--返回键区域
	if DetectMousePos(HelpReturnButton) == 1 then
		Result = GetMouseStatus();
		if Result == MouseHover then --鼠标左键悬停
			HelpReturnButton:setImagePos(173.7, 173.7*2, 0, 172);
			if HelpReturnButton["Hover"] == 0 then
				HelpReturnButton["Hover"] = 1;
				HelpReturnButtonSE:Play();
			end
			
		elseif Result == MouseLeftDown then --鼠标左键按下
			HelpReturnButton["Event"] = 1;
			HelpReturnButton:setImagePos(173.7*2, 173.7*3, 0, 172);
		elseif Result == MouseLeftUp then --鼠标左键松开
			HelpReturnButton:setImagePos(0, 173.7, 0, 172);
			if HelpReturnButton["Event"] == 1 then
				HelpReturnButton["Event"] = 0;
				Gamebgm:Play(ForcedSwitch);
				goStartView();
			end
		end
	else
		HelpReturnButton:setImagePos(0, 173.7, 0, 172);
	end
	
	local ESC_Result = KeyDetect(0x01);
	
	if ESC_Result == Press then
		goStartView();
	end
end




