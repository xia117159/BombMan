--s行n列矩阵 maptype：地图类型 Randrate：箱子随机概率 角色初始位置X,Y Boss开启/关闭 Assistant开启/关闭 助手放炸弹的随机概率
function initParams(s,n,maptype,Randrate,AcStPosX,AcStPosY,BossSwitchSetting,AssistantSwitchSetting,AssistantRandRate)
	
	local i ;
	local j;
	local temp;
	
    --firstsettemp = 1;
	
	TotalRows = s;
	TotalLines = n;
	
	TotalWidthPixels = n*BlockSize;
	TotalHeightPixels = s*BlockSize;
	
	BoxRandRate = Randrate;
   	AssistantPutBombRate = AssistantRandRate;
	BossSwitch = BossSwitchSetting;
        AssistantSwitch = AssistantSwitchSetting;
	--block = {posX,posY,brick=nil,wall=nil}; --0为无，1为存在
	--brick = 砖；wall = 墙 
	mapTable = {};
	

	--mapTable[i][j][k]	i,j代表行数，列数，
	--mapTable[i][j][1]代表位置X，mapTable[i][j][2]代表位置Y，
	--mapTable[i][j][3]代表砖，mapTable[i][j][4]代表墙，0为无，1至BoxRandRate为存在 mapTable[i][j][5]代表墙的类型X轴标号 mapTable[i][j][6]代表墙的类型Y轴标号
	--mapTable[i][j][7]代表炸弹 mapTable[i][j][8]代表BUFF mapTable[i][j][9]代表该位置是否将会受到火焰波及 0代表未受波及 >0代表受到波及并且代表受到波及的火焰数目
	--mapTable[i][j][10]火焰已经覆盖地区 mapTable[i][j][11]代表离助手的可到达距离，即没有障碍物（砖、铁墙、炸弹）无穷远（未初始化，不在距离数组中）则为100

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
				mapTable[i][j][7] = 0;
				mapTable[i][j][8] = 0;
				mapTable[i][j][9] = 0;
				mapTable[i][j][10] = 0;
				mapTable[i][j][11] = 100;
				if j % 2 == 0 and temp then
					mapTable[i][j][3] = 1;
					mapTable[i][j][4] = 0;				
				else
					mapTable[i][j][3] = 0;
					mapTable[i][j][4] = math.random(0,100);	
					if  mapTable[i][j][4] <= BoxRandRate then
						mapTable[i][j][5] = math.random(0,11);
						mapTable[i][j][6] = math.random(0,3);
						if mapTable[i][j][5] == 5 and mapTable[i][j][6] == 1 then
							mapTable[i][j][4] = 0;
						end
					end			
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
			else 
				mapTable[i][j][4] = math.random(0,2);
				if mapTable[i][j][4] == 1 then
					mapTable[i][j][5] = math.random(0,11);
					mapTable[i][j][6] = math.random(0,3);
					if mapTable[i][j][5] == 5 and mapTable[i][j][6] == 1 then
						mapTable[i][j][4] = 0;
					end
				end			
			end
		
		end
	end
	end
	
	mapTable[s][1][4] = 0;
	mapTable[s-1][1][4] = 0;
	mapTable[s-1][2][4] = 0;
	mapTable[s-2][1][4] = 0;	
	
	actorinf = ActorClass:new();
	actorimg:setImage(0, 550, BlockSize, BlockSize, 0, ActorWidth, 0, ActorHeight, 9.0);

	assistantinf = AssistantClass:new();
	assistantinf:setAbsolutePos(500,1000);
	Assistantimg:setImage(500, 350, BlockSize, BlockSize, 0, AssistantWidth, 0, AssistantHeight, 7.9);
	
	Bossinf = BossClass:new();
	Bossinf:setBossAbsolutePos(500,1100);
	
	Bossimg:setImage(500,450,BlockSize,BlockSize,0,32,0,64,8.9);
	Bossimg:setAbsoluteStartPos(500,450);
	
	originX=0;
	originY=-(TotalRows-12)*BlockSize;
    -- ActorHaveUnitStatus = 1;
    -- ActorRow1 = 24;
    -- ActorColumn1 = 1;
    -- ActorRow2 = nil;
    -- ActorColumn2 = nil;
    BossCountDown = 1000; --Boss倒计时
   -- ActorHaveUnitStatus,ActorRow1,ActorColumn1,ActorRow2,ActorColumn2 = GetObjectHaveBlock(actorinf:getAbsolutePosX(),actorinf:getAbsolutePosY());

end

	BlockSize = 50;
	UnitXOffset = UserData["SpeedX"];
	UnitYOffset = UserData["SpeedY"];				
    BossUnitXOffset = 2;
	BossUnitYOffset = 2;
    AssistantUnitXOffset = 2;
    AssistantUnitYOffset = 2;
	ActorWidth = 64;
	ActorHeight = 64;
	AssistantWidth = 64;
	AssistantHeight = 64;
	BossWidth = 32;
	BossHeight = 48;
	actorimg = ImageClass:new();
	actorimg:setImageFileSize(192, 384);
	Assistantimg = ImageClass:new();
	Assistantimg:setImageFileSize(192, 384);
	Bossimg = ImageClass:new();
	Bossimg:setImageFileSize(96,192);
	
	ChallengeOrStory = 0; --0代表剧情模式 1代表挑战模式
	
	ExitButtonWidth = 150;
	ExitButtonHeight = 64;
	
	
	movestatus = 0;
	releasestatus = 0;
	BrickWall = ImageClass:new();
	BrickWall:setImageFileSize(384, 302);
	BrickWall:setImage(0, 0, BlockSize, BlockSize, 0, 32, 0, 32, 10.0);
	
	ground = ImageClass:new();
	ground:setImageFileSize(1000, 100);
	--ground:setImage(0, 0, BlockSize, BlockSize, 200*(GroundTypeRandNum - 1), 200*GroundTypeRandNum, 0, 200, 11.0);
	
	ExitDialog = ImageClass:new();
	ExitDialog:setImageFileSize(1081, 410);
	ExitDialog:setImage(230, 95, 540, 410, 0, 540, 0, 410, 2.0);
	BackGroundColor = ImageClass:new();
	BackGroundColor:setImageFileSize(1081, 410);
	BackGroundColor:setImage(0,0,1000,600,540,1081,0,410,2.1);
	
	ExitButton = ImageClass:new();
	ExitButton:setImageFileSize(ExitButtonWidth*3, ExitButtonHeight*2);
	ExitButton:setImage(325 ,185, ExitButtonWidth, ExitButtonHeight, 0, ExitButtonWidth, ExitButtonHeight*0, ExitButtonHeight*1, 1.99);
	CancelButton = ImageClass:new();
	CancelButton:setImageFileSize(ExitButtonWidth*3, ExitButtonHeight*2);
	CancelButton:setImage(300+1.5*ExitButtonWidth, 185, ExitButtonWidth, ExitButtonHeight, 0, ExitButtonWidth, ExitButtonHeight*1, ExitButtonHeight*2, 1.99);
	
DialogStatus = false;--退出游戏弹框是否能显示和操作状态。


function DrawDialog()
	if DialogStatus then
		ExitDialog:DrawImage();	
		BackGroundColor:DrawImage();
	end
	
end

function DrawButtons()
	if DialogStatus then
		ExitButton:DrawImage();	
		CancelButton:DrawImage();	
			
	end
end

	
function DrawGround()
	local i;
	local j;
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
	local i;
	local j;
	x = originX;
	y = originY;
	for i=1,TotalRows,1 do		
		for j=1,TotalLines,1 do
			if mapTable[i][j][3] == 1 then						
				BrickWall:setImagePos(32*5, 32*6, 32, 32*2);
				BrickWall:setAbsoluteStartPos(x,y);															
				BrickWall:DrawImage();				
			end												
			if 0 < mapTable[i][j][4] and mapTable[i][j][4] <= BoxRandRate then								
				BrickWall:setImagePos(32*mapTable[i][j][5], 32*(mapTable[i][j][5]+1), 32*mapTable[i][j][6], 32*(mapTable[i][j][6]+1));	
				BrickWall:setAbsoluteStartPos(x,y);							
				BrickWall:DrawImage();								
			end
			if 0 < mapTable[i][j][8] and mapTable[i][j][8] <= 7 then				
				BrickWall:setImagePos(46*(mapTable[i][j][8] - 1),46*mapTable[i][j][8],256,302);	
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
	local ReviseNum = 0;
	if releasestatus == 0 then
		
	elseif releasestatus == 1 then  --右键释放
		local RemainNum = (NowActorPosX+50) % BlockSize;
		if  35 < RemainNum and RemainNum < 50 then
			NeedISRevise = true;
			ReviseNum = BlockSize-RemainNum;
		elseif 0 < RemainNum and RemainNum < 15 then
			NeedISRevise = true;
			ReviseNum = -RemainNum;
		else NeedISRevise = false;			
		end
		if NeedISRevise then
			if WindowMoveChecking(1) then	--判断视野移动
				originX=originX-ReviseNum;
				actorinf:setRelativePos(ReviseNum,0);			
			else 
				actorimg:setRelativelyStartPos(ReviseNum,0);	
				actorinf:moveTOALL(ReviseNum,0);
			end							
		end
		actorimg:setImagePos(ActorWidth*0, ActorWidth*1, ActorHeight*5, ActorHeight*6);
	
	elseif releasestatus == 2  then
		local RemainNum = NowActorPosY % BlockSize;
		if  35 < RemainNum and RemainNum < 50 then
			NeedISRevise = true;
			ReviseNum = BlockSize-RemainNum;
		elseif 0 < RemainNum and RemainNum < 15 then
			NeedISRevise = true;
			ReviseNum = -RemainNum;
		else NeedISRevise = false;			
		end
		if NeedISRevise  then
			if WindowMoveChecking(2) then			
				originY=originY-ReviseNum;
				actorinf:setRelativePos(0,ReviseNum);		
			else 			
				actorimg:setRelativelyStartPos(0,ReviseNum);	
				actorinf:moveTOALL(0,ReviseNum);											
			end	
					
		end	
					
		actorimg:setImagePos(ActorWidth*0, ActorWidth*1, ActorHeight, ActorHeight*2);			
		
	
	elseif releasestatus == 3 then
		local RemainNum = NowActorPosX % BlockSize;
		if  0 < RemainNum and RemainNum < 15 then
			NeedISRevise = true;
			ReviseNum = RemainNum;
		elseif 35 < RemainNum and RemainNum < 50 then
			NeedISRevise = true;
			ReviseNum = RemainNum-BlockSize;
		else NeedISRevise = false;			
		end
		if NeedISRevise then
			if WindowMoveChecking(3) then
				originX=originX + ReviseNum;
				actorinf:setRelativePos(-ReviseNum,0);		
			else 
				actorimg:setRelativelyStartPos(-ReviseNum,0);
				actorinf:moveTOALL(-ReviseNum,0);
			end
		end	
		actorimg:setImagePos(ActorWidth*0, ActorWidth*1, ActorHeight*2, ActorHeight*3);								
	
	elseif releasestatus == 4 then
		local RemainNum = (NowActorPosY-50) % BlockSize;
		if  0 < RemainNum and RemainNum < 15 then
			NeedISRevise = true;
			ReviseNum = RemainNum;
		elseif 35 < RemainNum and RemainNum < 50 then
			NeedISRevise = true;
			ReviseNum = RemainNum-BlockSize;
		else NeedISRevise = false;			
		end
		if NeedISRevise then
			if WindowMoveChecking(4) then
				originY=originY+ ReviseNum;
				actorinf:setRelativePos(0,-ReviseNum);	
			else	
				actorimg:setRelativelyStartPos(0,-ReviseNum);
				actorinf:moveTOALL(0,-ReviseNum);	
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


function ActorAnimationRecord:TimerGo(DeathStatus)
	self.ActorNowTimer = self.ActorNowTimer - 1;
	if self.ActorNowTimer  <= 0 then
		self.ActorNowFrameRate = self.ActorNowFrameRate + 1;
		if self.ActorNowFrameRate > self.ActorFrameRate then
            if DeathStatus  then
                self.ActorNowFrameRate = self.ActorNowFrameRate - 1;
                self.ActorNowTimer = 0;
            return self.ActorNowFrameRate;
            else	self.ActorNowFrameRate = 1;
            end
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
Actor1:SetValue(14, 2);
Boss1 = ActorAnimationRecord:new();
Boss1:SetValue(14,3);
Actor2 = ActorAnimationRecord:new();
Actor2:SetValue(14, 2);

function DrawActorGesture(sx, sy, fr, gesturetype ,actortype)
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
			actortype:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*0, ActorHeight*1);				
		elseif fr == 2 then 		
			actortype:setImagePos(ActorWidth*2, ActorWidth*3, ActorHeight*0, ActorHeight*1);
		end	
	elseif gesturetype == 5 then	--欢呼
		if fr == 1 then  	
			actortype:setImagePos(ActorWidth*0, ActorWidth*1, ActorHeight*3, ActorHeight*4);				
		elseif fr == 2 then 		
			actortype:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*3, ActorHeight*4);
		end	
	elseif 	gesturetype == 6 then	--倒地
		if fr == 1 then  	
			actortype:setImagePos(ActorWidth*0, ActorWidth*1, ActorHeight*4, ActorHeight*5);				
		elseif fr == 2 then 		
			actortype:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*4, ActorHeight*5);
            		if actortype == actorimg and WinBossStatus then
					 UserDie();
					 WinBossStatus = false;
			elseif  actortype == Assistantimg then
				assistantinf["assistantDeath"] = true;
				AssistantSwitch = false;	
			end
		end
	end

end

function SetActorPos()
	

end

function DrawBossGesture(sx, sy, fr, gesturetype ,actortype)
	actortype:setRelativelyStartPos(sx,sy);
	if gesturetype == 1 then	--方向向右
		if fr == 1 then  --第一帧图片		
			actortype:setImagePos(BossWidth*0, BossWidth*1, BossHeight*2, BossHeight*3);
		elseif fr == 2 then  --第二帧图片		
			actortype:setImagePos(BossWidth*1, BossWidth*2, BossHeight*2, BossHeight*3);							
		elseif fr == 3 then --第三帧图片
			actortype:setImagePos(BossWidth*2, BossWidth*3, BossHeight*2, BossHeight*3);
		end		
	elseif gesturetype == 2 then	--方向向上
		if fr == 1 then  --第一帧图片		
			actortype:setImagePos(BossWidth*0, BossWidth*1, BossHeight*3, BossHeight*4);
		elseif fr == 2 then  --第二帧图片		
			actortype:setImagePos(BossWidth*1, BossWidth*2, BossHeight*3, BossHeight*4);							
		elseif fr == 3 then --第三帧图片
			actortype:setImagePos(BossWidth*2, BossWidth*3, BossHeight*3, BossHeight*4);
		end		
	elseif gesturetype == 3 then	--方向向左
		if fr == 1 then  --第一帧图片		
			actortype:setImagePos(BossWidth*0, BossWidth*1, BossHeight*1, BossHeight*2);
		elseif fr == 2 then  --第二帧图片		
			actortype:setImagePos(BossWidth*1, BossWidth*2, BossHeight*1, BossHeight*2);							
		elseif fr == 3 then --第三帧图片
			actortype:setImagePos(BossWidth*2, BossWidth*3, BossHeight*1, BossHeight*2);
		end	
	elseif gesturetype == 4 then	--方向向下
		if fr == 1 then  --第一帧图片		
			actortype:setImagePos(BossWidth*0, BossWidth*1, BossHeight*0, BossHeight*1);
		elseif fr == 2 then  --第二帧图片		
			actortype:setImagePos(BossWidth*1, BossWidth*2, BossHeight*0, BossHeight*1);							
		elseif fr == 3 then --第三帧图片
			actortype:setImagePos(BossWidth*2, BossWidth*3, BossHeight*0, BossHeight*1);
		end	
	end

end







function PressingMoving()
	if movestatus == 1 then
		if BorderChecking(NowActorPosX,1) then		
			if ImpactChecking(NowActorPosX+UnitXOffset,NowActorPosY,1,1) then
				if WindowMoveChecking(1) then
					originX=originX-UnitXOffset;					
					DrawActorGesture(0, 0, Actor1:TimerGo(), 1, actorimg);
					actorinf:setRelativePos(UnitXOffset,0);			
				else 	
					DrawActorGesture(UnitXOffset, 0, Actor1:TimerGo(), 1, actorimg);
					actorinf:moveTOALL(UnitXOffset,0);
				end	
			else		DrawActorGesture(0, 0, Actor1:TimerGo(), 1, actorimg);				
			end	
		else	DrawActorGesture(0, 0, Actor1:TimerGo(), 1, actorimg);
		end
		ActorKeyBgm:Play();
					
	
	elseif movestatus == 2  then
		if  BorderChecking(NowActorPosY,2) then
			if ImpactChecking(NowActorPosX,NowActorPosY+UnitYOffset,2,1) then
				if WindowMoveChecking(2) then
					originY=originY-UnitYOffset;
					DrawActorGesture(0, 0, Actor1:TimerGo(), 2, actorimg);			
					actorinf:setRelativePos(0,UnitYOffset);	
				else			
					DrawActorGesture(0, UnitYOffset, Actor1:TimerGo(), 2, actorimg);
					actorinf:moveTOALL(0,UnitYOffset);	
				end
			else	DrawActorGesture(0, 0, Actor1:TimerGo(), 2, actorimg);	
			end	
		else	DrawActorGesture(0, 0, Actor1:TimerGo(), 2, actorimg);	
		end
		ActorKeyBgm:Play();
		
		
		
			
	
	elseif movestatus == 3  then
		if BorderChecking(NowActorPosX,3) then
			if ImpactChecking(NowActorPosX-UnitXOffset,NowActorPosY,3,1) then
				if WindowMoveChecking(3) then
					originX=originX+UnitXOffset;
					DrawActorGesture(0, 0, Actor1:TimerGo(), 3, actorimg);
					actorinf:setRelativePos(-UnitXOffset,0);		
				else 
					DrawActorGesture(-UnitXOffset, 0, Actor1:TimerGo(), 3, actorimg);
					actorinf:moveTOALL(-UnitXOffset,0);
				end	
			else	DrawActorGesture(0, 0, Actor1:TimerGo(), 3, actorimg);
			end
		else	DrawActorGesture(0, 0, Actor1:TimerGo(), 3, actorimg);
		end
		ActorKeyBgm:Play();	
				
	
	elseif movestatus == 4  then
		if BorderChecking(NowActorPosY,4) then
			if ImpactChecking(NowActorPosX,NowActorPosY-UnitYOffset,4,1) then
				if WindowMoveChecking(4) then
					originY=originY+UnitYOffset;
					DrawActorGesture(0, 0, Actor1:TimerGo(), 4, actorimg);
					actorinf:setRelativePos(0,-UnitYOffset);	
				else
					DrawActorGesture(0, -UnitYOffset, Actor1:TimerGo(), 4, actorimg);
					actorinf:moveTOALL(0,-UnitYOffset);	
				end	
			else	DrawActorGesture(0, 0, Actor1:TimerGo(), 4, actorimg);			
			end	
		else	DrawActorGesture(0, 0, Actor1:TimerGo(), 4, actorimg);	
		end
		ActorKeyBgm:Play();				
	end
end

ActorReviveLag = 200;


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
	
function CanPassBombOrWallChecking(i)	--检测炸弹或者墙是否可以穿过
	if i == 1 and UserData["CanPassWall"] == 1 or i == 2 and UserData["CanPassBomb"] == 1 then
		return true;
	else return false;
	end
end	
	
    --CheckingPosX代表需要检查的X像素 CheckingPosY代表需要检查的Y像素 Direction代表移动方向 actortype代表角色类型 1为人，2为助手
function ImpactChecking(CheckingPosX,CheckingPosY,Direction,actortype)	
	
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
			if mapTable[CheckingX1][CheckingY1][3] == 1 then
				return false;
			elseif 0 < mapTable[CheckingX1][CheckingY1][4] and mapTable[CheckingX1][CheckingY1][4] <= BoxRandRate then
                if actortype == 1 then
                    return CanPassBombOrWallChecking(1);
                else return false;
                end			
			elseif mapTable[CheckingX1][CheckingY1][7] == 1 and CheckingY1*BlockSize-CheckingPosX >= BlockSize-UnitXOffset then	--检测人物未嵌入在炸弹内 即人物未放炸弹
                if actortype == 1 then
                     return CanPassBombOrWallChecking(2);
                else return false;
			   	end			
			elseif mapTable[CheckingX1][CheckingY1][8] <= 7 and 0 < mapTable[CheckingX1][CheckingY1][8] and actortype == 1 then
				GetBuff(mapTable[CheckingX1][CheckingY1][8]);
				mapTable[CheckingX1][CheckingY1][8] = 0;
				return true;
			else return true;			
			end	
			return true;				
		else 
			CheckingX2 = CheckingX1-1;
			if mapTable[CheckingX1][CheckingY1][3] == 1 or 0 < mapTable[CheckingX1][CheckingY1][4] and mapTable[CheckingX1][CheckingY1][4] <= BoxRandRate or mapTable[CheckingX1][CheckingY1][7] == 1 then
				return false;
			elseif mapTable[CheckingX2][CheckingY1][3] == 1 or 0 < mapTable[CheckingX2][CheckingY1][4] and mapTable[CheckingX2][CheckingY1][4] <= BoxRandRate or mapTable[CheckingX2][CheckingY1][7] == 1 then
				return false;			
			else return true;
			end
		end			
		
	elseif Direction == 2 then	
		CheckingX1 = math.ceil(CheckingPosY/BlockSize);	
		CheckingXRemainder = CheckingPosX % BlockSize;
		CheckingYRemainder = CheckingPosY % BlockSize;
		if CheckingXRemainder == 0 then
			CheckingY1 = math.ceil(CheckingPosX/BlockSize)+1;
			if mapTable[CheckingX1][CheckingY1][3] == 1 then
				return false;
			elseif 0 < mapTable[CheckingX1][CheckingY1][4] and mapTable[CheckingX1][CheckingY1][4] <= BoxRandRate then
                if actortype == 1 then
                    return CanPassBombOrWallChecking(1);
                else return false;
                end	
			elseif mapTable[CheckingX1][CheckingY1][7] == 1 and CheckingX1*BlockSize-CheckingPosY >= BlockSize-UnitYOffset then	--检测人物未嵌入在炸弹内 即人物未放炸弹
				if actortype == 1 then
                    return CanPassBombOrWallChecking(2);
                else return false;
                end	              
			elseif mapTable[CheckingX1][CheckingY1][8] <= 7 and 0 < mapTable[CheckingX1][CheckingY1][8] and actortype == 1 then
				GetBuff(mapTable[CheckingX1][CheckingY1][8]);
				mapTable[CheckingX1][CheckingY1][8] = 0;
				return true;
			else return true;			
			end	
		else
			CheckingY1 = math.ceil(CheckingPosX/BlockSize);
			CheckingY2 = CheckingY1+1;
			if mapTable[CheckingX1][CheckingY1][3] == 1 or 0 < mapTable[CheckingX1][CheckingY1][4] and mapTable[CheckingX1][CheckingY1][4] <= BoxRandRate or mapTable[CheckingX1][CheckingY1][7] == 1 then
				return false;
			elseif mapTable[CheckingX1][CheckingY2][3] == 1 or 0 < mapTable[CheckingX1][CheckingY2][4] and mapTable[CheckingX1][CheckingY2][4] <= BoxRandRate or mapTable[CheckingX1][CheckingY2][7] == 1 then
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
			if mapTable[CheckingX1][CheckingY1][3] == 1 then
				return false;
			elseif 0 < mapTable[CheckingX1][CheckingY1][4] and mapTable[CheckingX1][CheckingY1][4] <= BoxRandRate then
                if actortype == 1 then
                    return CanPassBombOrWallChecking(1);
                else return false;
				end
			elseif mapTable[CheckingX1][CheckingY1][7] == 1 and CheckingPosX-CheckingY1*BlockSize >= -UnitXOffset then	--检测人物未嵌入在炸弹内 即人物未放炸弹
				if actortype == 1 then
                    return CanPassBombOrWallChecking(2);
                else return false;
				end          
			elseif mapTable[CheckingX1][CheckingY1][8] <= 7 and 0 < mapTable[CheckingX1][CheckingY1][8] and actortype == 1 then
				GetBuff(mapTable[CheckingX1][CheckingY1][8]);
				mapTable[CheckingX1][CheckingY1][8] = 0;
				return true;
			else return true;			
			end	
		else 
			CheckingX1 = math.ceil(CheckingPosY/BlockSize);
			CheckingX2 = CheckingX1-1;
			if mapTable[CheckingX1][CheckingY1][3] == 1 or 0 < mapTable[CheckingX1][CheckingY1][4] and mapTable[CheckingX1][CheckingY1][4] <= BoxRandRate or mapTable[CheckingX1][CheckingY1][7] == 1 then
				return false;
			elseif mapTable[CheckingX2][CheckingY1][3] == 1 or 0 < mapTable[CheckingX2][CheckingY1][4] and mapTable[CheckingX2][CheckingY1][4] <= BoxRandRate or mapTable[CheckingX2][CheckingY1][7] == 1 then
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
			if mapTable[CheckingX1][CheckingY1][3] == 1 then
				return false;
			elseif 0 < mapTable[CheckingX1][CheckingY1][4] and mapTable[CheckingX1][CheckingY1][4] <= BoxRandRate then
                if actortype == 1 then
                    return CanPassBombOrWallChecking(1);
                else return false;
				end
			elseif mapTable[CheckingX1][CheckingY1][7] == 1 and CheckingPosY-CheckingX1*BlockSize >= (-UnitYOffset) then		--检测人物未嵌入在炸弹内 即人物未放炸弹
				 if actortype == 1 then
                    return CanPassBombOrWallChecking(2);
                else return false;
				end             
			elseif mapTable[CheckingX1][CheckingY1][8] <= 7 and 0 < mapTable[CheckingX1][CheckingY1][8] and actortype == 1 then
				GetBuff(mapTable[CheckingX1][CheckingY1][8]);
				mapTable[CheckingX1][CheckingY1][8] = 0;
				return true;
			else return true;			
			end
		else
			CheckingY1 = math.ceil(CheckingPosX/BlockSize);
			CheckingY2 = CheckingY1+1;
			if mapTable[CheckingX1][CheckingY1][3] == 1 or 0 < mapTable[CheckingX1][CheckingY1][4] and mapTable[CheckingX1][CheckingY1][4] <= BoxRandRate or mapTable[CheckingX1][CheckingY1][7] == 1 then
				return false;
			elseif mapTable[CheckingX1][CheckingY2][3] == 1 or 0 < mapTable[CheckingX1][CheckingY2][4] and mapTable[CheckingX1][CheckingY2][4] <= BoxRandRate or mapTable[CheckingX1][CheckingY2][7] == 1 then
				return false;			
			else return true;
			end		
		end			
	end
			
		
end	

function WindowMoveChecking(Direction)
	if originX>-BlockSize*(TotalLines-20) and actorinf:getWindowPosX()>=16*BlockSize and Direction == 1 then					
		return true;		
	elseif  originY>-BlockSize*(TotalRows-12) and actorinf:getWindowPosY()>=9*BlockSize and Direction == 2 then	
		return true;
	elseif originX<0 and actorinf:getWindowPosX()<=3*BlockSize and Direction == 3 then	
		return true;
	elseif originY<0 and actorinf:getWindowPosY()<=4*BlockSize and Direction == 4 then
		return true;
	else return false;
	end	
end
gold = 0;
WinBossStatus = true;
function BOSSCountDown()
    if BossCountDown > 0 then
        BossCountDown = BossCountDown - 1;
    else
		if WinBossStatus then
			WinBossStatus = false;
			CheckingStoryModeOrChallengeMode(1);
		end
    end
end




SettlementStatus = true;


function DrawBoss()
    
	if BossSwitch then
		if ISGameNotPause then
            BOSSCountDown();
			Bossimg:setAbsoluteStartPos(Bossinf:getBossAbsolutePosX()+originX,Bossinf:getBossAbsolutePosY()+originY-BlockSize);
			if BossMoveDirection() == 1 then
				if WindowMoveChecking(1) then	
					DrawBossGesture(0, 0, Boss1:TimerGo(), 1, Bossimg);				
				else 	
					DrawBossGesture(BossUnitXOffset, 0, Boss1:TimerGo(), 1, Bossimg);			
				end	
			Bossinf:setBossRelativePos(BossUnitXOffset,0);		
			elseif BossMoveDirection() == 2 then
				if WindowMoveChecking(2) then					
					DrawBossGesture(0, 0, Boss1:TimerGo(), 2, Bossimg);		
				else 	
					DrawBossGesture(0, BossUnitYOffset, Boss1:TimerGo(), 2, Bossimg);		
				end	
			Bossinf:setBossRelativePos(0,BossUnitYOffset);		
			elseif BossMoveDirection() == 3 then
				if WindowMoveChecking(3) then					
					DrawBossGesture(0, 0, Boss1:TimerGo(), 3, Bossimg);			
				else 	
					DrawBossGesture(-BossUnitXOffset, 0, Boss1:TimerGo(), 3, Bossimg);		
				end			
			Bossinf:setBossRelativePos(-BossUnitXOffset,0);		
			elseif BossMoveDirection() == 4 then
				if WindowMoveChecking(4) then					
					DrawBossGesture(0, 0, Boss1:TimerGo(), 4, Bossimg);			
				else 	
					DrawBossGesture(0, -BossUnitYOffset, Boss1:TimerGo(), 4, Bossimg);		
				end		
			Bossinf:setBossRelativePos(0,-BossUnitYOffset);	
			elseif  BossMoveDirection() == 0 then 
				DrawActorGesture(0, 0, Actor1:TimerGo(true), 6, actorimg);  --人物死亡
	--			AcoterDeathFromBoss = true;--DrawBossGesture(0, 0, Boss1:TimerGo(), 4, Bossimg);	
				if SettlementStatus then
					CheckingStoryModeOrChallengeMode(0);       --跳到结算页面
					SettlementStatus = false;
				end
			end	
		end
		Bossimg:DrawImage();	
	--DrawActorGesture(0, 0, Actor1:TimerGo(), 5, actorimg);
			
	end
	
end

function CheckingStoryModeOrChallengeMode(WinStatus)	-- WinStatus : 0代表被Boss抓住 1代表成功躲过Boss
	if ChallengeOrStory == 0 then	--剧情模式
		if Glife >= 0 then
			UserData["IsPassGame"] = 3;
		end
	elseif ChallengeOrStory == 1 then	--挑战模式
		WinAndGoToEnd(WinStatus);
	
	end
end

function WinAndGoToEnd(WinStatus)   -- WinStatus : 0代表被Boss抓住 1代表成功躲过Boss
    for i = 1,AllEnemy.n do
        if(AllEnemy[i]["IsSurvival"] == 0) then
            if(AllEnemy[i]["EnemyType"] == 1) then
                 gold = gold + 2
            elseif(AllEnemy[i]["EnemyType"] == 2 or AllEnemy[i]["EnemyType"] == 3) then
                 gold = gold + 4
            elseif(AllEnemy[i]["EnemyType"] == 4 or AllEnemy[i]["EnemyType"] == 5) then
                 gold = gold + 5
            end
        end                 
    end
    if WinStatus == 1 then  
        gold = gold + 10;
    end
	
    EnableEndBG(gold);                                                                                                
end


function GetObjectHaveBlock(NowPosX,NowPosY)
	local ObjectRow1;	--人物或助手所占第一个位置的地图X坐标
	local ObjectRow2;	--人物或助手所占第二个位置的地图X坐标
	local ObjectColumn1;	--人物或助手所占第一个位置的地图Y坐标
	local ObjectColumn2;	--人物或助手所占第二个位置的地图Y坐标
	local ObjectHaveUnitStatus;
	--计算角色所占格子
	local ActorXRemain = NowPosX%BlockSize;
	local ActorYRemain = NowPosY%BlockSize;
	if ActorXRemain == 0 and ActorYRemain == 0 then
		ObjectColumn1 = NowPosX/BlockSize + 1;
		ObjectRow1 = NowPosY/BlockSize;
		ObjectHaveUnitStatus = 1; 	--人物所占位置mapTable[ObjectRow1][ObjectColumn1]
	elseif ActorXRemain ~= 0 then
		ObjectColumn1 = math.ceil(NowPosX/BlockSize);
		ObjectColumn2 = ObjectColumn1+1;
		ObjectRow1 = NowPosY/BlockSize;
		ObjectHaveUnitStatus = 2;  --人物所占位置mapTable[ObjectRow1][ObjectColumn1]，mapTable[ObjectRow1][ObjectColumn2]
	elseif ActorYRemain ~= 0 then
		ObjectRow1 = math.ceil(NowPosY/BlockSize);
		ObjectRow2 = ObjectRow1-1;
		ObjectColumn1 = NowPosX/BlockSize + 1;	--人物所占位置mapTable[ObjectRow1][ObjectColumn1]，mapTable[ObjectRow2][ObjectColumn1]
		ObjectHaveUnitStatus = 3;
	end
	return ObjectHaveUnitStatus,ObjectRow1,ObjectColumn1,ObjectRow2,ObjectColumn2;
end

function BossMoveDirection()
	local ActorRow1;	--人物所占第一个位置的地图X坐标
	local ActorRow2;	--人物所占第二个位置的地图X坐标
	local ActorColumn1;	--人物所占第一个位置的地图Y坐标
	local ActorColumn2;	--人物所占第二个位置的地图Y坐标
	local BossCouldMoveDirection;	--Boss可以移动的方向
    local ActorHaveUnitStatus;	--人物所占格数状况 1代表所占一格
	-- 2代表所占水平方向两格且位置为mapTable[ActorRow1][ActorColumn1]，mapTable[ActorRow1][ActorColumn2]
	-- 3代表所占竖直方向两格且位置为mapTable[ActorRow1][ActorColumn1]，mapTable[ActorRow2][ActorColumn1]
	local ActorPosX = actorinf:getAbsolutePosX();	--人物X方向的像素坐标
	local ActorPosY = actorinf:getAbsolutePosY();	--人物Y方向的像素坐标
	local ActorXRemain;
	local ActorYRemain;
	local BossRandDirectionNum1;
	DistanceX = ActorPosX-Bossinf:getBossAbsolutePosX();  --人物与Boss的水平差
	DistanceY = ActorPosY-Bossinf:getBossAbsolutePosY();   --人物与Boss的垂直差
	BossDerterminationMove = 0;
	
	
	ActorHaveUnitStatus,ActorRow1,ActorColumn1,ActorRow2,ActorColumn2 = GetObjectHaveBlock(ActorPosX,ActorPosY);
	--MessageBox(tostring(ActorRow2),tostring(ActorColumn2), MB_OK);
--[[	ActorXRemain = ActorPosX%BlockSize;
	ActorYRemain = ActorPosY%BlockSize;
	if ActorXRemain == 0 and ActorYRemain == 0 then
		ActorColumn1 = ActorPosX/BlockSize + 1;
		ActorRow1 = ActorPosY/BlockSize;
		ActorHaveUnitStatus = 1; 	--人物所占位置mapTable[ActorRow1][ActorColumn1]
	elseif ActorXRemain ~= 0 then
		ActorColumn1 = math.ceil(ActorPosX/BlockSize);
		ActorColumn2 = ActorColumn1+1;
		ActorRow1 = ActorPosY/BlockSize;
		ActorHaveUnitStatus = 2;  --人物所占位置mapTable[ActorRow1][ActorColumn1]，mapTable[ActorRow1][ActorColumn2]
	elseif ActorYRemain ~= 0 then
		ActorRow1 = math.ceil(ActorPosY/BlockSize);
		ActorRow2 = ActorRow1-1;
		ActorColumn1 = ActorPosX/BlockSize + 1;	--人物所占位置mapTable[ActorRow1][ActorColumn1]，mapTable[ActorRow2][ActorColumn1]
		ActorHaveUnitStatus = 3;
	end--]]
	
	if	math.abs(DistanceX) >= 50 or math.abs(DistanceY) >= 50 then		--未发生碰撞
		BossCouldMoveDirection = BossImpactChecking();
		local TargetBlockX;
		local TargetBlockY;
		if ActorHaveUnitStatus == 2 then	--人物占水平方向两格
			TargetBlockX = (ActorHaveNoIronCaculate1(ActorColumn1)-1)*BlockSize;
			TargetBlockY = ActorPosY;
			return GetBossDerterminationMove(BossCouldMoveDirection,TargetBlockX,TargetBlockY);
		elseif	ActorHaveUnitStatus == 3 then	--人物占竖直方向两格
			TargetBlockX = ActorPosX;
			TargetBlockY = 	ActorHaveNoIronCaculate2(ActorRow1)*BlockSize;
			return GetBossDerterminationMove(BossCouldMoveDirection,TargetBlockX,TargetBlockY);
		elseif	ActorHaveUnitStatus == 1 then	--人物只占一格
			if ActorHOneBoxNoIronCaculate(ActorRow1,ActorColumn1) == 1 then	--人物只能竖直移动	
				if Bossinf:getBossAbsolutePosX() == ActorPosX then	--Boss与人物X像素相同
					TargetBlockY = ActorPosY;
					return TargetYMove(TargetBlockY);	--Boss朝缩小Y像素方向移动
				elseif	BossCouldMoveDirection == 2 or BossCouldMoveDirection == 3 then --Boss只能竖直移动
					if Bossinf:getBossAbsolutePosY() <= ActorPosY then
						TargetBlockY = ActorPosY-BlockSize;						
					else 
						TargetBlockY = ActorPosY+BlockSize;
					end	
					return TargetYMove(TargetBlockY);	--Boss朝缩小Y像素方向移动
			    elseif BossCouldMoveDirection == 0 or BossCouldMoveDirection == 1 then	--Boss可以水平移动
					TargetBlockX = ActorPosX;
					return TargetXMove(TargetBlockX);
				end
			elseif	ActorHOneBoxNoIronCaculate(ActorRow1,ActorColumn1) == 2 then --人物只能水平移动	
				if Bossinf:getBossAbsolutePosY() == ActorPosY then	--Boss与人物Y像素相同
					TargetBlockX = ActorPosX;
					return TargetXMove(TargetBlockX);	--Boss朝缩小X像素方向移动
				elseif	BossCouldMoveDirection == 1 then --Boss只能水平移动
					if Bossinf:getBossAbsolutePosX() <= ActorPosX then
						TargetBlockX = ActorPosX - BlockSize;
					else	
						TargetBlockX = ActorPosX + BlockSize;
					end
					return TargetXMove(TargetBlockX);	--Boss朝缩小X像素方向移动
				elseif BossCouldMoveDirection == 0 or BossCouldMoveDirection == 2 or BossCouldMoveDirection == 3 then	--Boss可以竖直移动
					TargetBlockY = ActorPosY;
					return TargetYMove(TargetBlockY);
				end
			elseif	ActorHOneBoxNoIronCaculate(ActorRow1,ActorColumn1) == 3 then --人物可任意移动
				if BossCouldMoveDirection == 1 then	--Boss只能水平移动
					TargetBlockX = ActorPosX;
					return TargetXMove(TargetBlockX);
				elseif	BossCouldMoveDirection == 2 or BossCouldMoveDirection == 3 then --Boss只能竖直移动
					TargetBlockY = ActorPosY ;
					return TargetYMove(TargetBlockY);
				else --Boss朝水平方向竖直方向移动皆可
					if Bossinf:getBossAbsolutePosX() == ActorPosX then
						TargetBlockY = ActorPosY;
						return TargetYMove(TargetBlockY);
					elseif	Bossinf:getBossAbsolutePosY() == ActorPosY then
						TargetBlockX = ActorPosX;
						return TargetXMove(TargetBlockX);
					else	
						BossRandDirectionNum1 = math.random(1,2);	--1朝水平方向移动 --2朝竖直方向移动
						if BossRandDirectionNum1 == 1 then
							TargetBlockX = ActorPosX;
							return TargetXMove(TargetBlockX);
						else	
							TargetBlockY = ActorPosY;
							return TargetYMove(TargetBlockY);
						end			
					end						
				end		
			end					
		end		
	else  
	return 0;	 
	end
	
end	

function ActorHOneBoxNoIronCaculate(ActorRow,ActorColumn)
	if ActorRow % 2 == 0 and ActorColumn % 2 ~= 0 then  --行为偶数，列为奇数，人物只能竖直移动		
		return 1;
	elseif	ActorRow % 2 ~= 0 and ActorColumn % 2 == 0 then  --行为奇数，列为偶数，人物只能水平移动	
		return 2;
	else return 3; --人物可任意移动
	end
end


function GetBossDerterminationMove(BossCouldMoveDirection,TargetBlockX,TargetBlockY)
	local BossRandDirectionNum2;
	if BossCouldMoveDirection == 1 then --Boss只能水平移动
		BossDerterminationMove = TargetXMove(TargetBlockX);
	elseif	BossCouldMoveDirection == 2 then --Boss只能竖直移动
		BossDerterminationMove = TargetYMove(TargetBlockY);
	elseif	BossCouldMoveDirection == 3 then --Boss只能竖直向下移动	
		BossDerterminationMove = 4;
	else	--Boss可以朝目标距离减少的两个方向移动
		if Bossinf:getBossAbsolutePosX() == TargetBlockX then
			BossDerterminationMove =  TargetYMove(TargetBlockY);
		elseif	Bossinf:getBossAbsolutePosY() == TargetBlockY then
			BossDerterminationMove =  TargetXMove(TargetBlockX);
		else	
			BossRandDirectionNum2 = math.random(1,2);	--1朝水平方向移动 --2朝竖直方向移动
			if BossRandDirectionNum2 == 1 then
				BossDerterminationMove = TargetXMove(TargetBlockX);
			else	
				BossDerterminationMove =  TargetYMove(TargetBlockY);
			end			
		end
					
					
		--[[BossRandDirectionNum2 = math.random(1,2);	--1朝水平方向移动 --2朝竖直方向移动
		if BossRandDirectionNum2 == 1 and Bossinf:getBossAbsolutePosX() ~= TargetBlockX then
			BossDerterminationMove = TargetXMove(TargetBlockX);
		else BossDerterminationMove =  TargetYMove(TargetBlockY);
		end
		if BossRandDirectionNum2 == 2 and  Bossinf:getBossAbsolutePosY() ~= TargetBlockY then	
			BossDerterminationMove =  TargetYMove(TargetBlockY);
		else BossDerterminationMove =  TargetXMove(TargetBlockX);
		end	--]]
		--[[if Bossinf:getBossAbsolutePosX() ~= TargetBlockX then
			BossDerterminationMove = TargetXMove(TargetBlockX);
		else
			BossDerterminationMove = TargetYMove(TargetBlockY);
		end--]]
	end
	return BossDerterminationMove;		
	
end


function TargetXMove(TargetBlockX)
	if Bossinf:getBossAbsolutePosX() > TargetBlockX  then
		return 3;  --Boss该往左移
	else
		return 1; -- Boss该往右移
	end				
end

function TargetYMove(TargetBlockY)
	if Bossinf:getBossAbsolutePosY() > TargetBlockY  then
		return 4; --Boss该往下移
	else	
		return 2; --Boss该往上移
	end			
end



function ActorHaveNoIronCaculate1(ActorColumn)	--角色列的分量
	if ActorColumn % 2 == 0 then  --人物占水平方向前一列为偶数，即上下有铁墙，则无铁墙的为向右一格（后一列）
			--mapTable[ActorRow1][ActorColumn2]
		return ActorColumn+1
	else	--人物占水平方向前一列为奇数，即上下无铁墙
		return ActorColumn;
	end
end

function ActorHaveNoIronCaculate2(ActorRow)	--角色行的分量
	if ActorRow % 2 == 0 then  --人物占竖直方向上面一行为偶数，即左右有铁墙，则无铁墙的为下面一行
			--mapTable[ActorRow1][ActorColumn2]
		return ActorRow-1;
	else	--人物占竖直方向上面一行为奇数，即左右无铁墙
		return ActorRow;
	end
end


function BossImpactChecking()
	BossPosX = Bossinf:getBossAbsolutePosX();
	BossPosY = Bossinf:getBossAbsolutePosY();
	BossLastX = BossPosX % BlockSize;
	BossLastY = BossPosY % BlockSize;
	local BossCheckingLine;
	local BossCheckingRow;
	--0代表可以向水平或竖直方向移动 1代表只能水平移动 2代表只能竖直移动 3代表只能竖直向下移动 
	if BossLastX ~= 0 then
		return 1;
	elseif BossLastY ~= 0 then
		return 2;
	else 								--Boss只占一个格子
		BossCheckingLine = BossPosX/BlockSize;
		BossCheckingRow = BossPosY/BlockSize;
		if 	BossCheckingLine == 0 then 
			if mapTable[BossCheckingRow][BossCheckingLine+2][3] == 1 then	--Boss位于最左边	
				return 2;
			else return 0;
			end
		elseif 	BossCheckingRow == TotalRows then --Boss位于最上边
			return 3;
		elseif 	mapTable[BossCheckingRow][BossCheckingLine][3] == 1 then  --检查Boss左边是否有铁墙 
			return 2;
		elseif	 mapTable[BossCheckingRow+1][BossCheckingLine+1][3] == 1 then  --检查Boss上边是否有铁墙	
			return 1;
		else 
			return 0;
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
	for i = 1,7 do
		UserBomb[i]["IsWrite"] = 0
		UserBomb[i]["IsBlast"] = 0
	end
	for i = 1,15 do
		BombBlaze[i]["IsWrite"] = 0
		BombBlaze[i]["IsEnd"] = 0
	end
	for i = 1,15 do
		DynamiteWall[i]["IsWrite"] = 0
		DynamiteWall[i]["IsEnd"] = 0
	end
	goStartView();
end	

function CancelBack()
	DialogStatus = false;
	ISGameNotPause = true;
end	




function IintMapData(Modestatus)
	initParams(24,40,1,math.random(20,30),0,550,false,false,math.random(20,100)); --初始化地图参数	
	ISGameNotPause = false;	--判断游戏是否没有暂停
	DialogStatus = false;
	GroundTypeRandNum = math.random(1,5); --地表随机
	EnemyInit();
	Glife = 3;
	GlifeStatus = true;
	-- InitStartBG();--挑战模式，倒计时
	SettlementStatus = true;--结算状态
	WinBossStatus = true;
	SettlementStatus = true;
	gold = 0;
	
	if Modestatus == 0 and UserData["IsPassGame"] ~= 4 then	
		ChallengeOrStory = 0;
		EnableJustBG();
		UserData["IsPassGame"] = 1 --剧情模式
	else
		ChallengeOrStory = 1;
		InitStartBG();--挑战模式，倒计时
	-- elseif	Modestatus == 4 or Modestatus == 1 then
		-- UserData["IsPassGame"] = 0;	--挑战模式
	end
    
	
	ground:setImage(0, 0, BlockSize, BlockSize, 200*(GroundTypeRandNum - 1), 200*GroundTypeRandNum, 0, 100, 11.0);
end

--[[function DrawAssistant()
	Assistantimg:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*5, ActorHeight*6);
	Assistantimg:DrawImage();
end
--]]
function LoadMapViewImageFile()
	local ImageLoad = ImageClass:new();
	if NowLoadPos == 21 then
		ImageLoad:LoadImage(PlotV,"Image/Map/ground2.png","DrawGround()", "Image_0");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 22 then
		ImageLoad:LoadImage(PlotV,"Image/Map/material.png","DrawMap()", "Image_1");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 23 then
		ImageLoad:LoadImage(PlotV,"Image/Map/actor.png","DrawActor()", "Image_2");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 24 then
		ImageLoad:LoadImage(PlotV,"Image/Map/Boss.png","DrawBoss()", "Image_3");
		NowLoadPos = NowLoadPos + 1;	
	elseif NowLoadPos == 25 then
		ImageLoad:LoadImage(PlotV,"Image/Bomb/Bomb.png","DrawBomb()", "Image_4");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 26 then
		ImageLoad:LoadImage(PlotV,"Image/Bomb/Blaze.png","DrawBlaze()", "Image_5");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 27 then
		ImageLoad:LoadImage(PlotV,"Image/Bomb/Dynamite.png","DrawDynamite()", "Image_6");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 28 then
		ImageLoad:LoadImage(PlotV,"Image/Enemy.png","DrawEnemy()", "Image_7");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 29 then
        if UserData["AssistantProps"] == "GirlsAssistant" then
            ImageLoad:LoadImage(PlotV,"Image/Map/assistant.png","DrawAssistant()", "Image_8");
        else    
            ImageLoad:LoadImage(PlotV,"Image/Map/assistant1.png","DrawAssistant()", "Image_8");
        end	
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 30 then
		ImageLoad:LoadImage(PlotV,"Image/ShortcutBar1.png","DrawShortcutBar()", "Image_9");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 31 then
		ImageLoad:LoadImage(PlotV,"Image/Map/BackgroundColor4.png","DrawDialog()", "Image_10");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 32 then
		ImageLoad:LoadImage(PlotV,"Image/Map/ExitButtons.png","DrawButtons()", "Image_11");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 33 then
		ImageLoad:LoadImage(PlotV,"Image/FrontGround.png","DrawFrontGround()", "Image_12");
		NowLoadPos = NowLoadPos + 1;
    elseif NowLoadPos == 34 then
		ImageLoad:LoadImage(PlotV,"Image/Plot.png","DrawPlot()", "Image_13");
		NowLoadPos = NowLoadPos + 1;	
	end
	
end

FrontGroundW = 1282;
FrontGroundH = 2733;

GFrontBGIL = ImageClass:new();
GFrontBGIL :setImageFileSize(FrontGroundW, FrontGroundH);
GFrontBGIL :setImage(-500, 0 ,500, 600,  0, 500,0, 600, 1.5);

GFrontBGIR = ImageClass:new();
GFrontBGIR :setImageFileSize(FrontGroundW, FrontGroundH);
GFrontBGIR :setImage(1000, 0 ,500, 600,  500, 1000,0, 600, 1.5);

GFGFontPrompt = ImageClass:new();
GFGFontPrompt :setImageFileSize(FrontGroundW, FrontGroundH);
GFGFontPrompt :setImage(250, 410 ,500, 90,  0, 500,601, 691, 1.49);



GNumberDelay = 50;--延时1s
CountDown = 0;
CountDownStatus = 0; --倒计时状态值
FrontGroundStatus = 0;-- 前景动作值
TempZoomFGN = 0.8;
FrontGroundSS = true;

FrontGroundES = false;
RewardCountStatus = 0;--奖励计算状态
RewardGoldNum = 0;
-- 画前景
function DrawFrontGround()

	if FrontGroundStatus == 1 then
		GFrontBGIL:setRelativelyStartPos(-10,0);
		GFrontBGIR:setRelativelyStartPos(10,0);
		if GFrontBGIL["StartX"] <= -500 then
			FrontGroundStatus = 0;
			ISGameNotPause = true;--使游戏开始
			FrontGroundSS = false;
		end
	elseif FrontGroundStatus == 2 then
		GFrontBGIL:setRelativelyStartPos(10,0);
		GFrontBGIR:setRelativelyStartPos(-10,0);
		if GFrontBGIL["StartX"] >= 0 then
			FrontGroundStatus = 0;
			RewardCountStatus = 1;
			ISGameNotPause = false;--使游戏开始
		end
	elseif FrontGroundStatus == 3 then
		GFrontBGIL:setRelativelyStartPos(-10,0);
		GFrontBGIR:setRelativelyStartPos(10,0);
		if GFrontBGIL["StartX"] <= -500 then
			FrontGroundStatus = 0;
			ISGameNotPause = false;--使游戏开始
			if Modestatus == 0 and UserData["IsPassGame"] ~= 4 then	
				UserData["IsPassGame"] = 2 
				imageStartY = 100
			end
            
			FrontGroundSS = false;
		end
	end
	GFrontBGIL:DrawImage();
	GFrontBGIR:DrawImage();
	
	-- 金币统计
	if RewardCountStatus == 1 then
		if RewardGoldNum > 0 then
			GFGFontPrompt :setImage(300, 410 ,400, 80,  0, 400,691, 771, 1.49);
			GFGFontPrompt:DrawImage();
			GFGFontPrompt :setImage(310, 310 ,245, 56,  0, 350,771, 851, 1.49);
			GFGFontPrompt:DrawImage();
			GFGFontPrompt :setImage(330, 60 ,340, 40,  0, 680,851, 931, 1.49);
			GFGFontPrompt:DrawImage();
			FuncDrawFBNumber(615,330, GetBitNum(RewardGoldNum,2),0.3);
			FuncDrawFBNumber(580,330, GetBitNum(RewardGoldNum,1),0.3);
		elseif RewardGoldNum <= 0 then
			GFGFontPrompt :setImage(240, 410 ,520, 80,  0, 520, 931, 1011, 1.49);
			GFGFontPrompt:DrawImage();
			GFGFontPrompt :setImage(330, 60 ,340, 40,  0, 680,851, 931, 1.49);
			GFGFontPrompt:DrawImage();
		end
		
	end
	--倒计时显示区
	if CountDownStatus == 1 then
		GFGFontPrompt:DrawImage();
		TempZoomFGN = TempZoomFGN - 0.005;
		FuncDrawFBNumber(500,300, CountDown,TempZoomFGN);
		GNumberDelay = GNumberDelay - 1;
		if GNumberDelay <= 0 then
			if CountDown <= 0 then
				CountDownStatus = 0;
				FrontGroundStatus = 1;
			end
			TempZoomFGN = 0.7;
			CountDown = CountDown - 1;
			GNumberDelay = 100;
		end
	end
	
end







-- 画数字
function FuncDrawFBNumber(sx,xy,Num,P)
	local GFrontNumber = ImageClass:new();
	GFrontNumber :setImageFileSize(FrontGroundW, FrontGroundH);
	GFrontNumber :setscaling_ratio(P);
	GFrontNumber :setImage(sx-117*P/2 , xy-250*P/2 ,117, 250,  1084, 1201, 60+262*Num, 60+262*(Num+1), 1.49);
	GFrontNumber :DrawImage();
end

function InitStartBG()
	TempZoomFGN = 0.7;
	GNumberDelay = 0;
	CountDownStatus = 1;
	FrontGroundStatus = 0;-- 前景动作值
	GNumberDelay = 0;--剩余时间
	CountDown = 0; --倒计时
	FrontGroundSS = true;
	GFGFontPrompt :setImage(250, 410 ,500, 90,  0, 500,601, 691, 1.49);
	GFrontBGIL:setAbsoluteStartPos(0, 0);
	GFrontBGIR:setAbsoluteStartPos(500, 0);
end

--剧情模式下，背景故事滑动显示时的背景图
function EnableJustBG()
	FrontGroundSS = true;
	FrontGroundStatus = 0;-- 前景动作值
	GFrontBGIL:setAbsoluteStartPos(0, 0);
	GFrontBGIR:setAbsoluteStartPos(500, 0);
end
-- 剧情模式下，背景故事滑动显示时的背景图结束滑动的效果
function ExitJustBG()
	FrontGroundStatus = 3;-- 前景动作值
end



function EnableEndBG(GCn)
	if GCn > 0 then
		UserData["GoldCoins"] = UserData["GoldCoins"] + GCn;
		if UserData["GoldCoins"] > 9999 then
			UserData["GoldCoins"] = 9999;
		end
	end
	RewardGoldNum = GCn;
	ISGameNotPause = false;	--判断游戏是否没有暂停
	FrontGroundES = true;
	FrontGroundStatus = 2;-- 前景动作值
	GFrontBGIL:setAbsoluteStartPos(-500, 0);
	GFrontBGIR:setAbsoluteStartPos(1000, 0);
end
function ResetEndBG()
	RewardCountStatus = 0;
	RewardGoldNum = 0;
	FrontGroundES = false;
	FrontGroundStatus = 0;
end


GShortcutPosW = 630
GShortcutPosH = 863


GShortcutPosX = 40
GShortcutPosY = 40

GShortCutBarW = 100
GShortCutBarH = 81

GShortCutBar1 = ImageClass:new();
GShortCutBar1 :setImageFileSize(GShortcutPosW, GShortcutPosH);
GShortCutBar1 :setImage(GShortcutPosX, GShortcutPosY ,GShortCutBarW, GShortCutBarH,  GShortCutBarW, GShortCutBarW*2,0, GShortCutBarH, 2+0.8);

GShortCutBar2 = ImageClass:new();
GShortCutBar2 :setImageFileSize(GShortcutPosW, GShortcutPosH);
GShortCutBar2 :setImage(GShortcutPosX+100, GShortcutPosY ,GShortCutBarW, GShortCutBarH, GShortCutBarW*3, GShortCutBarW*4,0, GShortCutBarH, 2+0.8);

GSCBBBP = ImageClass:new();
GSCBBBP :setImageFileSize(GShortcutPosW, GShortcutPosH);
GSCBBBP :setscaling_ratio(0.6);
GSCBBBP :setImage(GShortcutPosX+20, GShortcutPosY+7 ,100, 110, 0, 100, 200, 310, 2+0.79);

GSCBAP = ImageClass:new();
GSCBAP :setImageFileSize(GShortcutPosW, GShortcutPosH);
GSCBAP :setscaling_ratio(0.5);
GSCBAP :setImage(GShortcutPosX+18, GShortcutPosY+10 ,135, 119, 135*UserData["AssistantProps"], 135*(UserData["AssistantProps"]+1), 81, 200, 2+0.79);

GSCBNumberW = 38.0 
GSCBNumber = ImageClass:new();
GSCBNumber :setImageFileSize(GShortcutPosW, GShortcutPosH);
GSCBNumber :setscaling_ratio(0.8);
GSCBNumber :setImage(GShortcutPosX+35, GShortcutPosY-35 ,GSCBNumberW,44,0,0, 0,0, 2+0.79);



GKeyStatus = 0;--按键模式，0为正常的游戏模式，1为操作超级大炸弹作用区域。

GBBPUseX = 300.0 --设定位置必须为50的整数倍
GBBPUseY = 300.0 --设定位置必须为50的整数倍

GBBPUseOX = 300.0 --设定位置必须为50的整数倍
GBBPUseOY = 300.0 --设定位置必须为50的整数倍

GBBPUseGlobalX = 300.0 --相对于世界的位置，设定位置必须为50的整数倍
GBBPUseGlobalY = 300.0 --相对于世界的位置，设定位置必须为50的整数倍

GBBPUseRect = ImageClass:new();
GBBPUseRect :setImageFileSize(GShortcutPosW, GShortcutPosH);
GBBPUseRect :setImage(GBBPUseX, GBBPUseY ,150,150,0,51, 323, 374, 2+0.69);

GBBPUseRedBG = ImageClass:new();
GBBPUseRedBG :setImageFileSize(GShortcutPosW, GShortcutPosH);
GBBPUseRedBG :setImage(GBBPUseX, GBBPUseY ,50,50,60,100, 330, 370, 2+0.59);
MaxGBBPUseRedBG = 6 --红色提示的最大格子数量

GWarnStatus = false;
GWarnTimer = 50;
GBBPUseWarn = ImageClass:new();
GBBPUseWarn :setImageFileSize(GShortcutPosW, GShortcutPosH);
GBBPUseWarn :setImage(GBBPUseX, GBBPUseY ,150,150,0,114, 387, 501, 2+0.59);
GBBPUseWarn :SetCenterRotate();

GBBPUseBomb = false;--记录超级大炸弹是否已落到指定位置

GBBPUseDecline = ImageClass:new();
GBBPUseDecline :setImageFileSize(GShortcutPosW, GShortcutPosH);
GBBPUseDecline :setImage(GBBPUseX, 700 ,60,110, 110,170, 200, 310, 2+0.58);


GPromptX = 450
GPromptY = 564


GPromptBGI = ImageClass:new();
GPromptBGI :setImageFileSize(GShortcutPosW, GShortcutPosH);
GPromptBGI :setImage(GPromptX, GPromptY ,700,50, 500, GShortcutPosW, 730, GShortcutPosH, 2+0.68);

PropsPrompt = ImageClass:new();
PropsPrompt :setImageFileSize(GShortcutPosW, GShortcutPosH);
PropsPrompt :setImage(GPromptX+300, GPromptY ,30,30, 0, 90, 544, 544+90, 2+0.58);

PromptFont =ImageClass:new();
PromptFont :setImageFileSize(GShortcutPosW, GShortcutPosH);
PromptFont :setscaling_ratio(0.6);

PromptFontNumW = 28

PromptFontNum =ImageClass:new();
PromptFontNum :setImageFileSize(GShortcutPosW, GShortcutPosH);
PromptFontNum :setscaling_ratio(0.8);

Glife = 0;
GlifeStatus = true;




function UserDie()
	if GlifeStatus then
		if Glife <= 0 then
			EnableEndBG(-1);
		end
		GlifeStatus = false;
		ActorReviveLag = 200;
		Glife = Glife - 1;
		releasestatus = 0;
		movestatus = 0;
	end
end
--画快捷栏
function DrawShortcutBar()

	GPromptBGI :setImage(GPromptX, GPromptY ,700,36, 500, GShortcutPosW, 730, GShortcutPosH, 2+0.68);
	GPromptBGI:DrawImage();
	
	
	
	--剩余生命提示
	PromptFont:setImage(GPromptX, GPromptY+(36-36*0.6)/2  ,180,36, 0, 180, 644, 680, 2+0.58);
	PromptFont:DrawImage();
	PromptFontNum:setImage(GPromptX+108, GPromptY+(36-28) ,PromptFontNumW,28,PromptFontNumW*Glife+10, PromptFontNumW*(Glife+1)+10, 820, 848, 2+0.48);
	PromptFontNum:DrawImage();
	
	--获得金币提示
	PromptFont:setImage(GPromptX+125, GPromptY+(36-36*0.6)/2  ,180,36, 0, 180, 700, 736, 2+0.58);
	PromptFont:DrawImage();
	if gold < 10 then
		PromptFontNum:setImage(GPromptX+235, GPromptY+(36-28) ,PromptFontNumW,28,PromptFontNumW*gold+10, PromptFontNumW*(gold+1)+10, 820, 848, 2+0.48);
		PromptFontNum:DrawImage();
	elseif gold > 10 then
		PromptFontNum:setImage(GPromptX+232, GPromptY+(36-28) ,PromptFontNumW,28,PromptFontNumW*GetBitNum(gold, 1)+10, PromptFontNumW*(GetBitNum(gold, 1)+1)+10, 820, 848, 2+0.48);
		PromptFontNum:DrawImage();
		PromptFontNum:setImage(GPromptX+232+18, GPromptY+(36-28) ,PromptFontNumW,28,PromptFontNumW*GetBitNum(gold, 2)+10, PromptFontNumW*(GetBitNum(gold, 2)+1)+10, 820, 848, 2+0.48);
		PromptFontNum:DrawImage();
	end
	
	--获得BUFF提示
	PromptFont:setImage(GPromptX+265, GPromptY+(36-36*0.6)/2 ,180,36, 0, 180, 759, 795, 2+0.58);
	PromptFont:DrawImage();
	if UserData["CanPassBomb"] == 1 then
		PropsPrompt:setImage(GPromptX+380, GPromptY+(36-30)/2 ,30,30, 90*4, 90*5, 544, 544+90, 2+0.58);
		PropsPrompt:DrawImage();
	end
	if UserData["CanPassWall"] == 1 then
		PropsPrompt:setImage(GPromptX+410, GPromptY+(36-30)/2 ,30,30, 90*5, 90*6, 544, 544+90, 2+0.58);
		PropsPrompt:DrawImage();
	end
	if UserData["TimeBomb"] == 1 then
		PropsPrompt:setImage(GPromptX+440, GPromptY+(36-30)/2 ,30,30, 90*3, 90*4, 544, 544+90, 2+0.58);
		PropsPrompt:DrawImage();
	end
	if UserData["HaveProtect"] == 1 then
		PropsPrompt:setImage(GPromptX+470, GPromptY+(36-30)/2 ,30,30, 90*6, 90*7, 544, 544+90, 2+0.58);
		PropsPrompt:DrawImage();
	end
	if UserData["SpeedX"] ~= 2 then
		PropsPrompt:setImage(GPromptX+500, GPromptY+(36-30)/2 ,30,30, 90*2, 90*3, 544, 544+90, 2+0.58);
		PropsPrompt:DrawImage();
	end

	GSCBAP:setImagePos(135*UserData["AssistantProps"], 135*(UserData["AssistantProps"]+1), 81, 200);
	if UserData["ShortCutBarBBP"] == 1 or UserData["ShortCutBarAP"] == 1 then
		GShortCutBar1:DrawImage();
		GShortCutBar1:setImagePos(GShortCutBarW*1,GShortCutBarW*2,0,GShortCutBarH);
		GSCBNumber:setImagePos(GSCBNumberW*ShortcutKey1, GSCBNumberW*(ShortcutKey1+1), 500, 544);
		GSCBNumber:setAbsoluteStartPos(GShortcutPosX+35, GShortcutPosY-35);
		GSCBNumber:DrawImage();
	end
	if UserData["ShortCutBarBBP"] == 2 or UserData["ShortCutBarAP"] == 2 then
		GShortCutBar2:DrawImage();
		GShortCutBar2:setImagePos(GShortCutBarW*3,GShortCutBarW*4,0,GShortCutBarH);
		GSCBNumber:setImagePos(GSCBNumberW*ShortcutKey2, GSCBNumberW*(ShortcutKey2+1), 500, 544);
		GSCBNumber:setAbsoluteStartPos(GShortcutPosX+35+100, GShortcutPosY-35);
		GSCBNumber:DrawImage();
	end
	if UserData["ShortCutBarBBP"] == 1 then
		GShortCutBar1:setImagePos(GShortCutBarW*0,GShortCutBarW*1,0,GShortCutBarH);
		GSCBBBP:setAbsoluteStartPos(GShortcutPosX+20,GShortcutPosY+7);
		GSCBBBP:DrawImage();
	elseif UserData["ShortCutBarBBP"] == 2 then
		GShortCutBar2:setImagePos(GShortCutBarW*2,GShortCutBarW*3,0,GShortCutBarH);
		GSCBBBP:setAbsoluteStartPos(GShortcutPosX+18+100,GShortcutPosY+10);
		GSCBBBP:DrawImage();
	end
	
	if UserData["ShortCutBarAP"] == 1 then
		GShortCutBar1:setImagePos(GShortCutBarW*0,GShortCutBarW*1,0,GShortCutBarH);
		GSCBAP:setAbsoluteStartPos(GShortcutPosX+20,GShortcutPosY+7);
		GSCBAP:DrawImage();
	elseif UserData["ShortCutBarAP"] == 2 then
		GShortCutBar2:setImagePos(GShortCutBarW*2,GShortCutBarW*3,0,GShortCutBarH);
		GSCBAP:setAbsoluteStartPos(GShortcutPosX+18+100,GShortcutPosY+10);
		GSCBAP:DrawImage();
	end
	if GKeyStatus == 1 then
	
		GBBPUseRect:setAbsoluteStartPos(GBBPUseX,GBBPUseY);
		GBBPUseRect:DrawImage();
		
		local GBBPUseTempX = GBBPUseX;
		local GBBPUseTempY = GBBPUseY;
		local loopi = 0;
		local loopj = 0;
		--画下方
		for loopi = 0,2 do
			for loopj = 0,MaxGBBPUseRedBG-1 do
				GBBPUseTempY = GBBPUseTempY - 50;
				GBBPUseRedBG:setAbsoluteStartPos(GBBPUseTempX,GBBPUseTempY);
				GBBPUseRedBG:DrawImage();
				
			end
			GBBPUseTempX = GBBPUseTempX + 50;
			GBBPUseTempY = GBBPUseY;
		end
		--画右方
		GBBPUseTempX = GBBPUseX + 100;
		GBBPUseTempY = GBBPUseY;
		for loopi = 0,2 do
			for loopj = 0,MaxGBBPUseRedBG-1 do
				GBBPUseTempX = GBBPUseTempX + 50;
				GBBPUseRedBG:setAbsoluteStartPos(GBBPUseTempX,GBBPUseTempY);
				GBBPUseRedBG:DrawImage();
			end
			GBBPUseTempX = GBBPUseX + 100;
			GBBPUseTempY = GBBPUseTempY + 50;
		end
		--画上方
		GBBPUseTempX = GBBPUseX;
		GBBPUseTempY = GBBPUseY + 100;
		for loopi = 0,2 do
			for loopj = 0,MaxGBBPUseRedBG-1 do
				GBBPUseTempY = GBBPUseTempY + 50;
				GBBPUseRedBG:setAbsoluteStartPos(GBBPUseTempX,GBBPUseTempY);
				GBBPUseRedBG:DrawImage();
			end
			GBBPUseTempX = GBBPUseTempX + 50;
			GBBPUseTempY = GBBPUseY + 100;
		end
		--画左方
		GBBPUseTempX = GBBPUseX;
		GBBPUseTempY = GBBPUseY;
		for loopi = 0,2 do
			for loopj = 0,MaxGBBPUseRedBG-1 do
				GBBPUseTempX = GBBPUseTempX - 50;
				GBBPUseRedBG:setAbsoluteStartPos(GBBPUseTempX,GBBPUseTempY);
				GBBPUseRedBG:DrawImage();
			end
			GBBPUseTempY = GBBPUseTempY + 50;
			GBBPUseTempX = GBBPUseX;
		end
	end
	
	if GWarnStatus then
		
		GBBPUseWarn:setRelativelyStartPos(originX - GBBPUseOX, originY - GBBPUseOY);
		GWarnTimer = GWarnTimer - 1;
		if GWarnTimer<=0 then
			GBBPUseWarn:SetRelativelyRA(60.0);
			GWarnTimer = 50;
		end
		GBBPUseWarn:DrawImage();
		
		GBBPUseDecline:setRelativelyStartPos(originX - GBBPUseOX,-2 + (originY - GBBPUseOY));
		if GBBPUseDecline["StartY"] <=  GBBPUseY + 75.0 then
			GWarnStatus = false;
			GBBPUseBomb = false;
			for i = 0,2 do
                for j = 0,2 do
                    --if(GBBPUseGlobalY + 50 * j <= TotalHeightPixels and GBBPUseGlobalX + 50 * i <= TotalWidthPixels)
                    if(mapTable[(GBBPUseGlobalY + 50 * j) / 50 +1][(GBBPUseGlobalX + 50 * i) / 50 + 1][3] == 0 and 
                    (mapTable[(GBBPUseGlobalY + 50 * j) / 50 +1][(GBBPUseGlobalX + 50 * i) / 50 + 1][4] <=0 or mapTable[(GBBPUseGlobalY + 50 * j) / 50 +1][(GBBPUseGlobalX + 50 * i) / 50 + 1][4] > BoxRandRate) and 
                    mapTable[(GBBPUseGlobalY + 50 * j) / 50 +1][(GBBPUseGlobalX + 50 * i) / 50 + 1][4] ~=1000 and mapTable[(GBBPUseGlobalY + 50 * j) / 50 +1][(GBBPUseGlobalX + 50 * i) / 50 + 1][7] == 0 and
                    (mapTable[(GBBPUseGlobalY + 50 * j) / 50 +1][(GBBPUseGlobalX + 50 * i) / 50 + 1][8] == 0 or mapTable[(GBBPUseGlobalY + 50 * j) / 50 +1][(GBBPUseGlobalX + 50 * i) / 50 + 1][8] > 7)) then
                        for k = 9,16 do
                            if(BombBlaze[k]["IsWrite"] == 0) then
                                BombBlaze[k]:Init(GBBPUseGlobalX + 50 *i,GBBPUseGlobalY + 50 * j)
                                BombBlaze[k]["IsWrite"] = 1
                                TestBlazeImpact(k,1)
                                break
                            end
                        end
                    end
                end
            end
		end
		GBBPUseDecline:DrawImage();
		GBBPUseY = GBBPUseY + originY - GBBPUseOY;
		GBBPUseOX = originX;
		GBBPUseOY = originY;
	end
	
end

function ActorKey()
	local KeyResult_right = KeyDetect(Right);
	local KeyResult_Up = KeyDetect(Up);
	local KeyResult_Left = KeyDetect(Left);
	local KeyResult_Down = KeyDetect(Down);
	local KeyResult_Esc = KeyDetect(0x01);
	local KeyResult_J = KeyDetect(0x24);
	local KeyResult_K = KeyDetect(0x25);
    local KeyResult_ENTER = KeyDetect(0x1C);
	local KeyResult_NUMBERENTER = KeyDetect(0x9C);
	local ShortcutKey1_R = KeyDetect(DetectShortcutKey1);
	local ShortcutKey2_R = KeyDetect(DetectShortcutKey2);
	
	
	if GlifeStatus == false then
		ActorReviveLag = ActorReviveLag - 1;
		if ActorReviveLag <= 0 then
			InitAssistantPos(4,0);
			GlifeStatus = true;
			WinBossStatus = true;
		end
	end
	
	if KeyResult_Esc == Press and FrontGroundSS == false and FrontGroundES == false then
		if GKeyStatus == 1 then
			GKeyStatus = 0;
		else
		
			ISGameNotPause = not ISGameNotPause;
			
			DialogStatus = not DialogStatus;
		end	
		
	end
    
    if KeyResult_Left == Press and UserData["IsPassGame"] == 3 and imageStartY == 1120 then
        if(chooseAssistant == 1) then
            chooseAssistant = 2
        elseif(chooseAssistant == 2) then
            chooseAssistant = 1
        end
    end

    if KeyResult_right == Press and UserData["IsPassGame"] == 3 and imageStartY == 1120 then
        if(chooseAssistant == 1) then
            chooseAssistant = 2
        elseif(chooseAssistant == 2) then
            chooseAssistant = 1
        end
    end

    if (KeyResult_ENTER == Press or KeyResult_NUMBERENTER == Press) and (UserData["IsPassGame"] == 2 or UserData["IsPassGame"] == 3) then
        if(UserData["IsPassGame"] == 2) then
            imageStartY = imageStartY + 68
        end
        if(UserData["IsPassGame"] == 3) then
            if(imageStartY == 1120) then
				UserData["AssistantLock"] = 0;
                if(chooseAssistant == 1) then
                    UserData["AssistantProps"] = BoysAssistant
                elseif(chooseAssistant == 2) then
                    UserData["AssistantProps"] = GirlsAssistant
                end
                imageStartY = 1256
            elseif(imageStartY == 1256) then
                UserData["IsPassGame"] = 4
				if WinBossStatus then
					WinBossStatus = false;
					EnableEndBG(gold);--结算画面
				end
            else
                imageStartY = imageStartY + 68
            end
        end
    end

	if DialogStatus then
		ExitResult = 0;
		if DetectMousePos(ExitButton) == 1  then
			ExitButtonEvent(1,ExitButton, GoToMainMenu);
		elseif DetectMousePos(CancelButton) == 1 then
			ExitButtonEvent(2,CancelButton, CancelBack);
		elseif ExitResult == 0 then
			GetMouseStatus();
			ExitNotReSetButton(0);
		end
	end
	
	
	
	if FrontGroundSS == false and FrontGroundES == false then 
--        if WinFocus == WM_SETFOCUS and ISGameNotPause == false then
--            ISGameNotPause = true;
--        elseif WinFocus == WM_KILLFOCUS then
--            ISGameNotPause = false;
--        end
		--快捷键1启动事件
		if ShortcutKey1_R == Press then
			if UserData["ShortCutBarBBP"] == 1 and GWarnStatus == false and GBBPUseBomb == false and GKeyStatus == 0 then
				GKeyStatus = 1;
				releasestatus = 0;
				movestatus = 0;
				GBBPUseX = actorinf:getWindowPosX() + 50 - actorinf:getWindowPosX()%50 + originX%50; --相对于窗口,设定位置必须为50的整数倍
				GBBPUseY = actorinf:getWindowPosY() - 200 - actorinf:getWindowPosY()%50 + originY%50; --相对于窗口,设定位置必须为50的整数倍
			elseif UserData["ShortCutBarAP"] == 1 then
				if assistantinf["assistantDeath"] then
					InitAssistantPos(4,1);
					assistantinf["assistantDeath"] = false;
				end
			end
		end
		-- 快捷键2启动事件
		if ShortcutKey2_R == Press then
			
			if UserData["ShortCutBarBBP"] == 2 and GWarnStatus == false and GBBPUseBomb == false and GKeyStatus == 0 then
				GKeyStatus = 1;
				releasestatus = 0;
				movestatus = 0;
				GBBPUseX = actorinf:getWindowPosX() + 50 - actorinf:getWindowPosX()%50 + originX%50; --相对于窗口,设定位置必须为50的整数倍
				GBBPUseY = actorinf:getWindowPosY() - 200 - actorinf:getWindowPosY()%50 + originY%50; --相对于窗口,设定位置必须为50的整数倍
			elseif UserData["ShortCutBarAP"] == 2 then
				if  assistantinf["assistantDeath"] then
					InitAssistantPos(4,1);
					assistantinf["assistantDeath"] = false;
				end             
			end
		end
		
		
		
		
		if GKeyStatus == 1 then
			if KeyResult_right == Release then
				GBBPUseX = GBBPUseX + 50;

			elseif KeyResult_Up == Release then
				GBBPUseY = GBBPUseY + 50;

			elseif KeyResult_Left == Release then
				GBBPUseX = GBBPUseX - 50;
		
			elseif KeyResult_Down == Release then
				GBBPUseY = GBBPUseY - 50;
		
			else

			end
			--
			if KeyResult_J == Press then
				GKeyStatus = 0;
				GBBPUseDecline:setAbsoluteStartPos(GBBPUseX+45,620);
				GBBPUseWarn:setAbsoluteStartPos(GBBPUseX,GBBPUseY);
				GBBPUseOX = originX;
				GBBPUseOY = originY;
				GBBPUseGlobalX = GBBPUseX - originX;
				GBBPUseGlobalY = GBBPUseY - originY;
				GBBPUseRedBG:setAbsoluteStartPos(GBBPUseX,GBBPUseY);
				GWarnStatus = true;
			end
		
		elseif GKeyStatus == 0 and GlifeStatus then
			if KeyResult_right == KeepPressing then
				releasestatus = 0;
				movestatus = 1;
			--	BossSwitchSetting = false;
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
		

			if KeyResult_J == Press then
				local BombX = 0
				local BombY = 0
				local i = 1
				while(BombX <= TotalWidthPixels) do
					if(BombX <= actorinf["AcStPosX"] + 25 and actorinf["AcStPosX"] + 25 < BombX + 50) then
						break
					end
					BombX = BombX + 50
				end
				while(BombY <= TotalHeightPixels) do
					if(BombY <= actorinf["AcStPosY"] - 25 and actorinf["AcStPosY"] - 25 < BombY + 50) then
						break
					end
					BombY = BombY + 50
				end
			    if(mapTable[BombY/BlockSize + 1][BombX/BlockSize + 1][4] > 0 and mapTable[BombY/BlockSize + 1][BombX/BlockSize + 1][4] <= BoxRandRate) then
			    	return
			    end
			    if(mapTable[BombY/BlockSize + 1][BombX/BlockSize + 1][7] ~= 1) then
				    while(i <= 6) do
				    	if(UserBomb[i]["IsWrite"] == 0) then
					    	UserBomb[i]:Init(BombX,BombY)
					    	UserBomb[i]["IsWrite"] = 1
					    	if UserData["TimeBomb"] == 1 then
						    	for j = 1,6 do
						    		if(BombOrder[j] == 0) then
						    			BombOrder[j] = i
						    			break
						    		end
						    	end
						    end
						    mapTable[BombY/BlockSize + 1][BombX/BlockSize + 1][7] = 1
                            for j = 17,24 do
                                if(BombBlaze[j]["IsWrite"] == 2) then
							    	if(BombBlaze[j]["UpImpact"] > 0) then
                                        for k = 1,BombBlaze[j]["UpImpact"] do
                                            mapTable[(BombBlaze[j]["Blaze"]["StartY"] + k * 50) / 50 + 1][BombBlaze[j]["Blaze"]["StartX"] / 50 +1][9] = mapTable[(BombBlaze[j]["Blaze"]["StartY"] + k * 50) / 50 + 1][BombBlaze[j]["Blaze"]["StartX"] / 50 +1][9] - 1
                                        end
                                    end
                                    if(BombBlaze[j]["LeftImpact"] > 0) then
                                        for k = 1,BombBlaze[j]["LeftImpact"] do
                                            mapTable[BombBlaze[j]["Blaze"]["StartY"] / 50 + 1][(BombBlaze[j]["Blaze"]["StartX"] - k * 50) / 50 +1][9] = mapTable[BombBlaze[j]["Blaze"]["StartY"] / 50 + 1][(BombBlaze[j]["Blaze"]["StartX"] - k * 50) / 50 +1][9] - 1
                                        end
                                    end
                                    if(BombBlaze[j]["RightImpact"] > 0) then
                                        for k = 1,BombBlaze[j]["RightImpact"] do
                                            mapTable[BombBlaze[j]["Blaze"]["StartY"] / 50 + 1][(BombBlaze[j]["Blaze"]["StartX"] + k * 50) / 50 +1][9] = mapTable[BombBlaze[j]["Blaze"]["StartY"] / 50 + 1][(BombBlaze[j]["Blaze"]["StartX"] + k * 50) / 50 +1][9] - 1
                                        end
                                    end
                                    if(BombBlaze[j]["DownImpact"] > 0) then
                                        for k = 1,BombBlaze[j]["DownImpact"] do
                                            mapTable[(BombBlaze[j]["Blaze"]["StartY"] - k * 50) / 50 + 1][BombBlaze[j]["Blaze"]["StartX"] / 50 +1][9] = mapTable[(BombBlaze[j]["Blaze"]["StartY"] - k * 50) / 50 + 1][BombBlaze[j]["Blaze"]["StartX"] / 50 +1][9] - 1
                                        end
                                    end
						    	end
                            end
						    for j = 17,24 do
							    if(BombBlaze[j]["IsWrite"] == 0) then
							    	BombBlaze[j]:Init(BombX,BombY)
                                    BombBlaze[j]["IsWrite"] = 2
                                    break
						    	end
						    end
                            for j = 17,24 do
							    if(BombBlaze[j]["IsWrite"] == 2) then
                                    TestBlazeImpact(j,0)
						    	end
						    end
						    break
					    end
					    i = i + 1
				    end
			    end
		    end
	    end
		if KeyResult_K == Press then
			if(UserData["TimeBomb"] == 1) then
				for i = 6,1,-1 do
					if(BombOrder[i] ~=0) then
						UserBomb[BombOrder[i]]["IsWrite"] = 0
						UserBomb[BombOrder[i]]["IsBlast"] = 0
						local j = BombOrder[i]
						BombOrder[i] = 0
						mapTable[UserBomb[j]["Bomb"]["StartY"]/BlockSize + 1][UserBomb[j]["Bomb"]["StartX"]/BlockSize + 1][7] = 0
						for k = 1,8 do 
							if BombBlaze[k]["IsWrite"] == 0 then
								BombBlaze[k]:Init(UserBomb[j]["Bomb"]["StartX"],UserBomb[j]["Bomb"]["StartY"])
								BombBlaze[k]["IsWrite"] = 1
								TestBlazeImpact(k,1)
								break
							end
						end
						break
					end
				end
			end	
		end
	end
	if RewardCountStatus == 1 and GetMouseStatus() == MouseLeftDown then
		GoToMainMenu();
		ResetEndBG();
	end
	
end	

function GetBuff(i)
	if i == 1 and UserData["Power"] < 9 then
		UserData["Power"] = UserData["Power"] + 1
	elseif i == 2 and UserData["HaveBombNumber"] <6 then
		UserData["HaveBombNumber"] = UserData["HaveBombNumber"] + 1
	elseif i == 3 and UserData["SpeedX"] <4 and UserData["SpeedY"] < 4 then
		UnitXOffset = UnitXOffset + 1
		UnitYOffset = UnitYOffset + 1
	elseif i == 4 then
		UserData["TimeBomb"] = 1
	elseif i == 5 then
		UserData["CanPassBomb"] = 1
	elseif i == 6 then
		UserData["CanPassWall"] = 1
	elseif i == 7 then
		UserData["HaveProject"] = 1
	end
end

imageStartY = 1460;
chooseAssistant = 1
BackGroundAnimation = ImageClass:new();
BackGroundAnimation:setImageFileSize(1000, 2620);
PlotAnimation = ImageClass:new();
PlotAnimation:setImageFileSize(1000, 2620);

function DrawPlot()
    if(UserData["IsPassGame"] == 1 and imageStartY < 2270 ) then
        BackGroundAnimation:setImage(210 , 450  , 585 , 100 , 0 , 580 , 1360 , 1460 , 0.5);
        BackGroundAnimation:DrawImage()
        PlotAnimation:setImage(210 , 100  , 585 , 350 , 0 , 580 , imageStartY , imageStartY + 350 , 0.5);
        PlotAnimation:DrawImage()
        imageStartY = imageStartY + 1;
    elseif( imageStartY >= 2270 and UserData["IsPassGame"] == 1) then
        BackGroundAnimation:setImage(210 , 450  , 585 , 100 , 0 , 580 , 1360 , 1460 , 0.5);
        BackGroundAnimation:DrawImage()
        PlotAnimation:setImage(210 , 100 + (imageStartY - 2270) , 585 , 350 - (imageStartY - 2270) , 0 , 580 , imageStartY , imageStartY + 350 - (imageStartY - 2270), 0.5);
        PlotAnimation:DrawImage()
        
        if(imageStartY == 2470) then
            ExitJustBG();
            UserData["IsPassGame"] = 0 
        end
        imageStartY = imageStartY + 1;
    end
    if(UserData["IsPassGame"] == 2) then
        if(imageStartY == 644) then
            UserData["IsPassGame"] = 0
        end
        BackGroundAnimation:setImage(0 , 0  , 1000 , 100 , 0 , 1000 , 0 , 100 , 0.6);
        BackGroundAnimation:DrawImage()
        PlotAnimation:setImage(0 , 0  , 1000 , 68 , 0 , 1000 , imageStartY , imageStartY + 68 , 0.5);
        PlotAnimation:DrawImage()
    end

    if(UserData["IsPassGame"] == 3) then
        if(imageStartY == 1120) then
            BackGroundAnimation:setImage(0 , 0  , 1000 , 100 , 0 , 1000 , 0 , 100 , 0.6);
            BackGroundAnimation:DrawImage()
            if(chooseAssistant == 1) then
                PlotAnimation:setImage(100 , 0  , 120 , 68 , 120 , 240 , imageStartY , imageStartY + 68 , 0.5);
                PlotAnimation:DrawImage()
                PlotAnimation:setImage(300 , 0  , 120 , 68 , 0 , 120 , imageStartY + 68 , imageStartY + 136 , 0.5);
                PlotAnimation:DrawImage()
            elseif(chooseAssistant == 2) then
                PlotAnimation:setImage(100 , 0  , 120 , 68 , 0 , 120 , imageStartY , imageStartY + 68 , 0.5);
                PlotAnimation:DrawImage()
                PlotAnimation:setImage(300 , 0  , 120 , 68 , 120 , 240 , imageStartY + 68 , imageStartY + 136 , 0.5);
                PlotAnimation:DrawImage()
            end
        elseif(imageStartY == 1256) then
            BackGroundAnimation:setImage(0 , 0  , 1000 , 100 , 0 , 1000 , 0 , 100 , 0.6);
            BackGroundAnimation:DrawImage()
            PlotAnimation:setImage(0 , 0  , 1000 , 68 , 0 , 1000 , imageStartY , imageStartY + 68 , 0.5);
            PlotAnimation:DrawImage()
		else
			BackGroundAnimation:setImage(0 , 0  , 1000 , 100 , 0 , 1000 , 0 , 100 , 0.6);
			BackGroundAnimation:DrawImage()
			PlotAnimation:setImage(0 , 0  , 1000 , 68 , 0 , 1000 , imageStartY , imageStartY + 68 , 0.5);
			PlotAnimation:DrawImage()
		end
    end
end