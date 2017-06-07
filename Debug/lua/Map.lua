--s行n列矩阵 maptype：地图类型 groundtype：地表类型 角色初始位置X,Y 相对与角色的视野位置
function initParams(s,n,maptype,groundtype,AcStPosX,AcStPosY,RelativeWindowPos)
	
	local i ;
	local j;
	local temp;
	
    --firstsettemp = 1;
	
	TotalRows = s;
	TotalLines = n;
	
	TotalWidthPixels = n*BlockSize;
	TotalHeightPixels = s*BlockSize;
	
	
	--可丢掷炸弹数量
	local BombNumAva = 1;
	--炸弹火力
	local FireLevel = 1;
	--block = {posX,posY,brick=nil,wall=nil}; --0为无，1为存在
	--brick = 砖；wall = 墙 
	mapTable = {};
	math.randomseed(os.time()); --设置时间种子

	--mapTable[i][j][k]	i,j代表行数，列数，
	--mapTable[i][j][1]代表位置X，mapTable[i][j][2]代表位置Y，
	--mapTable[i][j][3]代表砖，mapTable[i][j][4]代表墙，0为无，1为存在

	if maptype == 1 then   --1型地图
		for i=1,s do 
			mapTable[i] = {};	
			if i % 2 == 0 then
				temp = true;
			else temp = false;
			end
			for j=1,n do
				mapTable[i][j] = {};
				mapTable[i][j][1] = i;
				mapTable[i][j][2] = j;
				if j % 2 == 0 and temp then
					mapTable[i][j][3] = 1;
					mapTable[i][j][4] = 0;				
				else
					mapTable[i][j][3] = 0;
					mapTable[i][j][4] = math.random(0,5);				
				end	
				
			end
		end
	end
	if maptype == 2 then   --2型地图
		for i=1,s do
		mapTable[i] = {};
		
		for j=1,n do
			mapTable[i][j] = {};
			mapTable[i][j][1] = i;
			mapTable[i][j][2] = j;
			mapTable[i][j][3] = math.random(0,20);	
			if(mapTable[i][j][3] == 1)	then  --该位置有铁墙
			mapTable[i][j][4] = 0;
			else mapTable[i][j][4] = math.random(0,2);
			end
		
		end
	end
	end
	
	mapTable[s][1][4] = 0;
	mapTable[s-1][1][4] = 0;
	mapTable[s-1][2][4] = 0;
	mapTable[s-2][1][4] = 0;	
	
	--保存角色状态
	--actorBlock ={AcStPosX,AcStPosY,BombNumAva,FireLevel};
	
	actorinf = ActorClass:new(1,1);
	actorimg:setImage(0, 550, BlockSize, BlockSize, 0, ActorWidth, 0, ActorHeight, 9.0);
	
	originX=0;
	originY=-(TotalRows-12)*BlockSize;
end

	BlockSize = 50;
	UnitXOffset = UserData["SpeedX"];
	UnitYOffset = UserData["SpeedY"];				
    
	ActorWidth = 64;
	ActorHeight = 64;
	actorimg = ImageClass:new();
	actorimg:setImageFileSize(192, 384);
	

	
	ExitButtonWidth = 150;
	ExitButtonHeight = 64;
	
	
	movestatus = 0;
	releasestatus = 0;
	BrickWall = ImageClass:new();
	BrickWall:setImageFileSize(384, 256);
	BrickWall:setImage(0, 0, BlockSize, BlockSize, 0, 32, 0, 32, 10.0);
	
	ground = ImageClass:new();
	ground:setImageFileSize(1000, 100);
	--ground:setImage(0, 0, BlockSize, BlockSize, 200*(GroundTypeRandNum - 1), 200*GroundTypeRandNum, 0, 200, 11.0);
	
	ExitDialog = ImageClass:new();
	ExitDialog:setImageFileSize(1081, 820);
	ExitDialog:setImage(230, 95, 540, 410, 0, 1081, 0, 820, 8.0);
	
	ExitButton = ImageClass:new();
	ExitButton:setImageFileSize(ExitButtonWidth*3, ExitButtonHeight*2);
	ExitButton:setImage(325 ,185, ExitButtonWidth, ExitButtonHeight, 0, ExitButtonWidth, ExitButtonHeight*0, ExitButtonHeight*1, 6.0);
	CancelButton = ImageClass:new();
	CancelButton:setImageFileSize(ExitButtonWidth*3, ExitButtonHeight*2);
	CancelButton:setImage(300+1.5*ExitButtonWidth, 185, ExitButtonWidth, ExitButtonHeight, 0, ExitButtonWidth, ExitButtonHeight*1, ExitButtonHeight*2, 5.99);

function DrawDialog()
	if ISGameNotPause == false  then
		ExitDialog:DrawImage();	
	end
	
end

function DrawButtons()
	if ISGameNotPause == false  then
		ExitButton:DrawImage();	
		CancelButton:DrawImage();	
			
	end
end

	
function DrawGround()
	
	Gx=originX;
	Gy=originY;
	for i=1,TotalRows,1 do
		for j=1,TotalLines,1 do
			ground:setAbsoluteStartPos(Gx, Gy);
			ground:DrawImage();
			Gx=Gx+BlockSize;		
		end
		Gx=originX;
		Gy=Gy+BlockSize;
	end			
end

function DrawMap()	
	x = originX;
	y = originY;
	for i=1,TotalRows,1 do		
		for j=1,TotalLines,1 do
			if mapTable[i][j][3] == 1 then						
				BrickWall:setImagePos(32*5, 32*6, 32, 32*2);
				BrickWall:setAbsoluteStartPos(x,y);															
				BrickWall:DrawImage();				
			end												
			if mapTable[i][j][4] == 1 then								
				BrickWall:setImagePos(32*BoxNum, 32*(BoxNum+1), 32, 32*2);	
				BrickWall:setAbsoluteStartPos(x,y);							
				BrickWall:DrawImage();								
			end		
			x=x+BlockSize;			
		end	
		x=originX;
		y=y+BlockSize;	
	end								
end

function ReleaseMoving()
	if releasestatus == 0 then
		
	elseif releasestatus == 1 then  --右键释放
		local RemainNum = (NowActorPosX+50) % BlockSize;
		if  40 < RemainNum and RemainNum < 50 then
			NeedISRevise = true;
		else NeedISRevise = false;			
		end
		if NeedISRevise then
			if originX>-BlockSize*(TotalLines-20) and actorinf:getWindowPosX()>=16*BlockSize then	--判断视野移动
				originX=originX-(BlockSize-RemainNum);
				actorinf:setRelativePos(BlockSize-RemainNum,0);			
			else 
				actorimg:setRelativelyStartPos(BlockSize-RemainNum,0);	
				actorinf:moveTOALL(BlockSize-RemainNum,0);
			end							
		end
		actorimg:setImagePos(ActorWidth*0, ActorWidth*1, ActorHeight*5, ActorHeight*6);
	
	elseif releasestatus == 2  then
		local RemainNum = NowActorPosY % BlockSize;
		--MessageBox(tostring(actorinf:getAbsolutePosX()),tostring(actorinf:getAbsolutePosY()) , MB_OK);
		if  40 < RemainNum and RemainNum < 50 then
			NeedISRevise = true;
		else NeedISRevise = false;			
		end
		if NeedISRevise  then
			if originY>-BlockSize*(TotalRows-12) and actorinf:getWindowPosY()>=9*BlockSize then			
				originY=originY-(BlockSize-RemainNum);
				actorinf:setRelativePos(0,(BlockSize-RemainNum));		
			else 			
				actorimg:setRelativelyStartPos(0,(BlockSize-RemainNum));	
				actorinf:moveTOALL(0,(BlockSize-RemainNum));											
			end	
					
		end	
					
		actorimg:setImagePos(ActorWidth*0, ActorWidth*1, ActorHeight, ActorHeight*2);			
		
	
	elseif releasestatus == 3 then
		local RemainNum = NowActorPosX % BlockSize;
		if  0 < RemainNum and RemainNum < 10 then
			NeedISRevise = true;
		else NeedISRevise = false;			
		end
		if NeedISRevise then
			if originX<0 and actorinf:getWindowPosX()<=3*BlockSize then
				originX=originX + RemainNum;
				actorinf:setRelativePos(-RemainNum,0);		
			else 
				actorimg:setRelativelyStartPos(-RemainNum,0);
				actorinf:moveTOALL(-RemainNum,0);
			end
		end	
		actorimg:setImagePos(ActorWidth*0, ActorWidth*1, ActorHeight*2, ActorHeight*3);								
	
	elseif releasestatus == 4 then
		local RemainNum = (NowActorPosY-50) % BlockSize;
		if  0 < RemainNum and RemainNum < 10 then
			NeedISRevise = true;
		else NeedISRevise = false;			
		end
		if NeedISRevise then
			if originY<0 and actorinf:getWindowPosY()<=4*BlockSize then
				originY=originY+ RemainNum;
				actorinf:setRelativePos(0,-RemainNum);	
			else	
				actorimg:setRelativelyStartPos(0,-RemainNum);
				actorinf:moveTOALL(0,-RemainNum);	
			end	
		end	
		actorimg:setImagePos(ActorWidth*0, ActorWidth*1, ActorHeight*0, ActorHeight*1);									
	end		
end






ActorAnimationRecord = {
	ActorTimer = 0, 
	ActorNowTimer = 0,
	ActorFrameRate = 1,
	ActorNowFrameRate = 1
}
function ActorAnimationRecord:SetValue(t, fr)
	--[[self.ActorStartX = sx;
	self.ActorStartY = sy;--]]
	self.ActorTimer = t;
	self.ActorNowTimer = self.ActorTimer;
	self.ActorFrameRate = fr;
end

function ActorAnimationRecord:TimerGo(fr)
	self.ActorNowTimer = self.ActorNowTimer - 1;
	if self.ActorNowTimer  <= 0 then
		self.ActorNowFrameRate = self.ActorNowFrameRate + 1;
		if self.ActorNowFrameRate > self.ActorFrameRate then
			self.ActorNowFrameRate = 1;
		end
		self.ActorNowTimer = self.ActorTimer;
	end
	return self.ActorNowFrameRate;
end


function ActorAnimationRecord:new()
	o = {}
	setmetatable(o, {__index = self});
	return o;
end

Actor1 = ActorAnimationRecord:new();
Actor1:SetValue(10, 2);

function DrawActorGesture(sx, sy, fr, gesturetype ,actortype)
	--[[local ActorGesture = ImageClass:new();
	ActorGesture :setImageFileSize(785, 628);--]]
	actortype:setRelativelyStartPos(sx,sy);
	if gesturetype == 1 then	--方向向右
		--if keystatus == 1 then  --1代表按键按下 0代表按键松开
		if fr == 1 then  --第一帧图片		
			actortype:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*5, ActorHeight*6);						
		elseif fr == 2 then --第二帧图片
			actortype:setImagePos(ActorWidth*2, ActorWidth*3, ActorHeight*5, ActorHeight*6);
		end		
		--end
	elseif gesturetype == 2 then	--方向向上
		if fr == 1 then  	
			actortype:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*1, ActorHeight*2);										
		elseif fr == 2 then 		
			actortype:setImagePos(ActorWidth*2, ActorWidth*3, ActorHeight*1, ActorHeight*2);
		end		
	elseif gesturetype == 3 then	--方向向左
		if fr == 1 then  	
			actortype:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*2, ActorHeight*3);								
		elseif fr == 2 then 		
			actortype:setImagePos(ActorWidth*2, ActorWidth*3, ActorHeight*2, ActorHeight*3);
		end	
	elseif gesturetype == 4 then	--方向向下
		if fr == 1 then  	
			actorimg:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*0, ActorHeight*1);				
		elseif fr == 2 then 		
			actorimg:setImagePos(ActorWidth*2, ActorWidth*3, ActorHeight*0, ActorHeight*1);
		end	
	elseif gesturetype == 5 then	--欢呼
		if fr == 1 then  	
			actorimg:setImagePos(ActorWidth*0, ActorWidth*1, ActorHeight*3, ActorHeight*4);				
		elseif fr == 2 then 		
			actorimg:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*3, ActorHeight*4);
		end		
	end

end



function PressingMoving()
	if movestatus == 1 and BorderChecking(NowActorPosX,1) then		
		if ImpactChecking(NowActorPosX+UnitXOffset,NowActorPosY,1) then
			if originX>-BlockSize*(TotalLines-20) and actorinf:getWindowPosX()>=16*BlockSize then
				originX=originX-UnitXOffset;
				--actorimg:setRelativelyStartPos(0,0);
				--actorimg:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*5, ActorHeight*6);
				DrawActorGesture(0, 0, Actor1:TimerGo(), 1, actorimg);
				actorinf:setRelativePos(UnitXOffset,0);			
			else 
				--actorimg:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*5, ActorHeight*6);	
				--actorimg:setRelativelyStartPos(UnitXOffset,0);	
				DrawActorGesture(UnitXOffset, 0, Actor1:TimerGo(), 1, actorimg);
				actorinf:moveTOALL(UnitXOffset,0);
			end		
		else	DrawActorGesture(0, 0, Actor1:TimerGo(), 1, actorimg);			
		end			
			
	
	elseif movestatus == 2 and BorderChecking(NowActorPosY,2) then
		if ImpactChecking(NowActorPosX,NowActorPosY+UnitYOffset,2) then
			if originY>-BlockSize*(TotalRows-12) and actorinf:getWindowPosY()>=9*BlockSize then
				originY=originY-UnitYOffset;
				--actorimg:setRelativelyStartPos(0,0);	
				DrawActorGesture(0, 0, Actor1:TimerGo(), 2, actorimg);
				--actorimg:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*1, ActorHeight*2);	
				actorinf:setRelativePos(0,UnitYOffset);	
			else
				--[[actorimg:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*1, ActorHeight*2);
				actorimg:setRelativelyStartPos(0,UnitYOffset);	--]]
				DrawActorGesture(0, UnitYOffset, Actor1:TimerGo(), 2, actorimg);
				actorinf:moveTOALL(0,UnitYOffset);	
			end
		else	DrawActorGesture(0, 0, Actor1:TimerGo(), 2, actorimg);	
		end
		
		
			
	
	elseif movestatus == 3 and BorderChecking(NowActorPosX,3) then
		if ImpactChecking(NowActorPosX-UnitXOffset,NowActorPosY,3) then
			if originX<0 and actorinf:getWindowPosX()<=3*BlockSize then
				originX=originX+UnitXOffset;
			--	actorimg:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*2, ActorHeight*3);
				DrawActorGesture(0, 0, Actor1:TimerGo(), 3, actorimg);
				actorinf:setRelativePos(-UnitXOffset,0);		
			else 
				--[[actorimg:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*2, ActorHeight*3);
				actorimg:setRelativelyStartPos(-UnitXOffset,0);--]]
				DrawActorGesture(-UnitXOffset, 0, Actor1:TimerGo(), 3, actorimg);
				actorinf:moveTOALL(-UnitXOffset,0);
			end	
		else	DrawActorGesture(0, 0, Actor1:TimerGo(), 3, actorimg);	
		end
				
	
	elseif movestatus == 4 and BorderChecking(NowActorPosY,4) then
		if ImpactChecking(NowActorPosX,NowActorPosY-UnitYOffset,4) then
			if originY<0 and actorinf:getWindowPosY()<=4*BlockSize then
				originY=originY+UnitYOffset;
				--actorimg:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*0, ActorHeight*1);
				DrawActorGesture(0, 0, Actor1:TimerGo(), 4, actorimg);
				actorinf:setRelativePos(0,-UnitYOffset);	
			else
				--[[actorimg:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*0, ActorHeight*1);	
				actorimg:setRelativelyStartPos(0,-UnitYOffset);--]]
				DrawActorGesture(0, -UnitYOffset, Actor1:TimerGo(), 4, actorimg);
				actorinf:moveTOALL(0,-UnitYOffset);	
			end	
		else	DrawActorGesture(0, 0, Actor1:TimerGo(), 4, actorimg);	
		end				
	end
end

--1代表向右 2代表向上 3代表向左 4代表向下
function DrawActor()
	NowActorPosX = actorinf:getAbsolutePosX();
	NowActorPosY = actorinf:getAbsolutePosY();
	NeedISRevise = false;	
	if ISGameNotPause then
		ReleaseMoving();
		PressingMoving();
	end	
	actorimg:DrawImage();												
end
	
function BorderChecking(CheckingPosOne,Direction)
	if Direction == 1 then
		if CheckingPosOne+50+UnitYOffset < TotalWidthPixels then
			return true;
		else return false;
		end
	elseif Direction == 2 then
		if CheckingPosOne+UnitYOffset < TotalHeightPixels then
			return true;
		else return false;
		end	
	elseif Direction == 3 then
		if CheckingPosOne-UnitXOffset > 0 then
			return true;
		else return false;
		end	
	elseif Direction == 4 then
		if CheckingPosOne-50-UnitYOffset > 0 then
			return true;
		else return false;
		end	
	else return false;
	end		
end
	
	
function ImpactChecking(CheckingPosX,CheckingPosY,Direction)	
	
	local CheckingX1;
	local CheckingY1;
	local CheckingX2;
	local CheckingY2;
	local CheckingXRemainder;
	local CheckingYRemainder;
	if Direction == 1 then
		CheckingPosX = CheckingPosX+50;
		CheckingXRemainder = CheckingPosX % BlockSize;		
		CheckingX1 = math.ceil(CheckingPosY/BlockSize);
		CheckingY1 = math.ceil(CheckingPosX/BlockSize);
		CheckingYRemainder = CheckingPosY % BlockSize;
		if  CheckingYRemainder == 0 then  --判断人物是否在一个方格内
			if mapTable[CheckingX1][CheckingY1][3] == 1 or  mapTable[CheckingX1][CheckingY1][4] == 1 then
				return false;
			else return true;			
			end	
			return true;				
		else 
			CheckingX2 = CheckingX1-1;
			if mapTable[CheckingX1][CheckingY1][3] == 1 or mapTable[CheckingX1][CheckingY1][4] == 1 then
				return false;
			elseif mapTable[CheckingX2][CheckingY1][3] == 1 or mapTable[CheckingX2][CheckingY1][4] == 1 then
				return false;			
			else return true;
			end
		end			
		
	elseif Direction == 2 then	
		CheckingX1 = math.ceil(CheckingPosY/BlockSize);	
		CheckingXRemainder = CheckingPosX % BlockSize;
		if CheckingXRemainder == 0 then
			CheckingY1 = math.ceil(CheckingPosX/BlockSize)+1;
			if mapTable[CheckingX1][CheckingY1][3] == 1 or  mapTable[CheckingX1][CheckingY1][4] == 1 then
				return false;
			else return true;			
			end	
		else
			CheckingY1 = math.ceil(CheckingPosX/BlockSize);
			CheckingY2 = CheckingY1+1;
			if mapTable[CheckingX1][CheckingY1][3] == 1 or mapTable[CheckingX1][CheckingY1][4] == 1 then
				return false;
			elseif mapTable[CheckingX1][CheckingY2][3] == 1 or mapTable[CheckingX1][CheckingY2][4] == 1 then
				return false;			
			else return true;
			end		
		end
		
	elseif Direction == 3 then
		CheckingXRemainder = CheckingPosX % BlockSize;
		if  CheckingXRemainder == 0 then
			CheckingY1 = math.ceil(CheckingPosX/BlockSize)+1;	
		else CheckingY1 = math.ceil(CheckingPosX/BlockSize);
		end					
		CheckingYRemainder = CheckingPosY % BlockSize;
		if CheckingYRemainder == 0 then
			CheckingX1 = math.ceil(CheckingPosY/BlockSize);	
			if mapTable[CheckingX1][CheckingY1][3] == 1 or  mapTable[CheckingX1][CheckingY1][4] == 1 then
				return false;
			else return true;			
			end	
		else 
			CheckingX1 = math.ceil(CheckingPosY/BlockSize);
			CheckingX2 = CheckingX1-1;
			if mapTable[CheckingX1][CheckingY1][3] == 1 or mapTable[CheckingX1][CheckingY1][4] == 1 then
				return false;
			elseif mapTable[CheckingX2][CheckingY1][3] == 1 or mapTable[CheckingX2][CheckingY1][4] == 1 then
				return false;			
			else return true;
			end
		end
		
	elseif Direction == 4 then
		CheckingPosY = CheckingPosY-50;			
		CheckingYRemainder = CheckingPosY % BlockSize;
		if CheckingYRemainder == 0 then
			CheckingX1 = math.ceil(CheckingPosY/BlockSize)+1;
		else CheckingX1 = math.ceil(CheckingPosY/BlockSize);
		end
		CheckingXRemainder = CheckingPosX % BlockSize;
		if CheckingXRemainder == 0 then
			CheckingY1 = math.ceil(CheckingPosX/BlockSize)+1;
			if mapTable[CheckingX1][CheckingY1][3] == 1 or  mapTable[CheckingX1][CheckingY1][4] == 1 then
				return false;
			else return true;			
			end
		else
			CheckingY1 = math.ceil(CheckingPosX/BlockSize);
			CheckingY2 = CheckingY1+1;
			if mapTable[CheckingX1][CheckingY1][3] == 1 or mapTable[CheckingX1][CheckingY1][4] == 1 then
				return false;
			elseif mapTable[CheckingX1][CheckingY2][3] == 1 or mapTable[CheckingX1][CheckingY2][4] == 1 then
				return false;			
			else return true;
			end		
		end			
	end
			
		
end	
	
function ExitButtonEvent(Num, ButtonClass, GoFunc)
	ExitNotReSetButton(Num);
	ExitResult = GetMouseStatus();
	if ExitResult == MouseHover then --鼠标左键悬停
		if ButtonClass["Hover"] == 0 then
			ButtonClass["Hover"] = 1;
			StartViewButtonSe:Play();
		end
		ButtonClass:setImagePos(ExitButtonWidth, ExitButtonWidth*2, ExitButtonHeight*(Num-1), ExitButtonHeight*Num);
	elseif ExitResult == MouseLeftDown then --鼠标左键按下
		ButtonClass:setImagePos(ExitButtonWidth*2, ExitButtonWidth*3, ExitButtonHeight*(Num-1), ExitButtonHeight*Num);
		ButtonClass["Event"] = 1;
	elseif ExitResult == MouseLeftUp then --鼠标左键松开
		ButtonClass:setImagePos(0, ExitButtonWidth, ExitButtonHeight*(Num-1), ExitButtonHeight*Num);
		if ButtonClass["Event"] == 1 then
			ButtonClass["Event"] = 0;
			Gamebgm:Play(ForcedSwitch);--强制切换背景音乐
			GoFunc();
		end
	end
end

function ExitNotReSetButton(TempB)
	if TempB ~= 1 then
		ExitButton["Hover"] = 0;
		ExitButton:setImagePos(ExitButtonWidth*0 ,ExitButtonWidth*1, ExitButtonHeight*0, ExitButtonHeight*1);
	end
	
	if TempB ~= 2 then
		CancelButton["Hover"] = 0;
		CancelButton:setImagePos(ExitButtonWidth*0, ExitButtonWidth*1, ExitButtonHeight*1, ExitButtonHeight*2);
	end
end
	
function GoToMainMenu()
	ReleaseImageData();--清除图片资源以便目标页面加载
	LoadStartViewImageFile();--加载主页面
	NowView = StartV;--设置视图位于主页面
end	

function CancelBack()
	ISGameNotPause = true;
end	



function LoadMapViewImageFile()
	initParams(24,40,1,0,0,550,200); --初始化地图参数
	ISGameNotPause = true;	--判断游戏是否没有暂停
	GroundTypeRandNum = math.random(1,5);
	BoxNum = math.random(1,32);
	ground:setImage(0, 0, BlockSize, BlockSize, 200*(GroundTypeRandNum - 1), 200*GroundTypeRandNum, 0, 100, 11.0);
	ground:LoadImage("Image/Map/ground2.png","DrawGround()", "Image_0");
	BrickWall:LoadImage("Image/Map/material.png","DrawMap()", "Image_1");
	actorimg:LoadImage("Image/Map/actor.png","DrawActor()", "Image_2");
	ExitDialog:LoadImage("Image/Map/ExitShowDialog.png","DrawDialog()", "Image_3");
	ExitButton:LoadImage("Image/Map/ExitButtons.png","DrawButtons()", "Image_4");
end



function ActorKey()
	
	local KeyResult_right = KeyDetect(Right);
	local KeyResult_Up = KeyDetect(Up);
	local KeyResult_Left = KeyDetect(Left);
	local KeyResult_Down = KeyDetect(Down);
	local KeyResult_Esc = KeyDetect(0x01);
	if KeyResult_Esc == Release then
		if ISGameNotPause == true then
			ISGameNotPause = false;
						
		else ISGameNotPause = true;
		end	
	end
	if KeyResult_right == KeepPressing then
		releasestatus = 0;
		movestatus = 1;
	elseif KeyResult_right == Release then
		releasestatus = 1;			
		movestatus = 0;		
	elseif KeyResult_Up == KeepPressing then
		releasestatus = 0;
		movestatus = 2;	
	elseif KeyResult_Up == Release then	
		releasestatus = 2;	
		movestatus = 0;	
	elseif KeyResult_Left == KeepPressing then
		releasestatus = 0;	
		movestatus = 3;
	elseif KeyResult_Left == Release then	
		movestatus = 0;
		releasestatus = 3;		
	elseif KeyResult_Down == KeepPressing then
		releasestatus = 0;
		movestatus = 4;			
	elseif KeyResult_Down == Release then	
		movestatus = 0;
		releasestatus = 4;		
	else
		releasestatus = 0;
		movestatus = 0;
	end
	
	ExitResult = 0;
	if DetectMousePos(ExitButton) == 1 then
		ExitButtonEvent(1,ExitButton, GoToMainMenu);
	elseif DetectMousePos(CancelButton) == 1 then
		ExitButtonEvent(2,CancelButton, CancelBack);
	elseif ExitResult == 0 then
		GetMouseStatus();
		ExitNotReSetButton(0);
	end
	
	
end	

