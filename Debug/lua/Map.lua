--s��n�о��� maptype����ͼ���� Randrate������������� ��ɫ��ʼλ��X,Y Boss����/�ر�
function initParams(s,n,maptype,Randrate,AcStPosX,AcStPosY,BossSwitch)
	
	local i ;
	local j;
	local temp;
	
    --firstsettemp = 1;
	
	TotalRows = s;
	TotalLines = n;
	
	TotalWidthPixels = n*BlockSize;
	TotalHeightPixels = s*BlockSize;
	
	BoxRandRate = Randrate;
	BossSwitchSetting = BossSwitch;
	--block = {posX,posY,brick=nil,wall=nil}; --0Ϊ�ޣ�1Ϊ����
	--brick = ש��wall = ǽ 
	mapTable = {};
	

	--mapTable[i][j][k]	i,j����������������
	--mapTable[i][j][1]����λ��X��mapTable[i][j][2]����λ��Y��
	--mapTable[i][j][3]����ש��mapTable[i][j][4]����ǽ��0Ϊ�ޣ�1Ϊ���� mapTable[i][j][5]����ǽ������X���� mapTable[i][j][6]����ǽ������Y���� mapTable[i][j][7]����ը��

	if maptype == 1 then   --1�͵�ͼ
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
	if maptype == 2 then   --2�͵�ͼ
		for i=1,s do
		mapTable[i] = {};
		
		for j=1,n do
			mapTable[i][j] = {};
			mapTable[i][j][1] = i;
			mapTable[i][j][2] = j;
			mapTable[i][j][3] = math.random(0,20);	
			if(mapTable[i][j][3] == 1)	then  --��λ������ǽ
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
	Bossinf = BossClass:new();
	Bossinf:setBossAbsolutePos(500,1100);
	
	Bossimg:setImage(500,450,BlockSize,BlockSize,0,32,0,64,8.9);
	Bossimg:setAbsoluteStartPos(500,450);
	
	originX=0;
	originY=-(TotalRows-12)*BlockSize;
end

	BlockSize = 50;
	UnitXOffset = UserData["SpeedX"];
	UnitYOffset = UserData["SpeedY"];				
    BossUnitXOffset = 2;
	BossUnitYOffset = 2;
	ActorWidth = 64;
	ActorHeight = 64;
	BossWidth = 32;
	BossHeight = 48;
	actorimg = ImageClass:new();
	actorimg:setImageFileSize(192, 384);
	
	Bossimg = ImageClass:new();
	Bossimg:setImageFileSize(96,192);
	
	
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
	ExitDialog:setImage(230, 95, 540, 410, 0, 540, 0, 410, 8.0);
	BackGroundColor = ImageClass:new();
	BackGroundColor:setImageFileSize(1081, 410);
	BackGroundColor:setImage(0,0,1000,600,540,1081,0,410,8.1);
	
	ExitButton = ImageClass:new();
	ExitButton:setImageFileSize(ExitButtonWidth*3, ExitButtonHeight*2);
	ExitButton:setImage(325 ,185, ExitButtonWidth, ExitButtonHeight, 0, ExitButtonWidth, ExitButtonHeight*0, ExitButtonHeight*1, 6.0);
	CancelButton = ImageClass:new();
	CancelButton:setImageFileSize(ExitButtonWidth*3, ExitButtonHeight*2);
	CancelButton:setImage(300+1.5*ExitButtonWidth, 185, ExitButtonWidth, ExitButtonHeight, 0, ExitButtonWidth, ExitButtonHeight*1, ExitButtonHeight*2, 5.99);
	
	

function DrawDialog()
	if ISGameNotPause == false  then
		ExitDialog:DrawImage();	
		BackGroundColor:DrawImage();
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
		
	elseif releasestatus == 1 then  --�Ҽ��ͷ�
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
			if WindowMoveChecking(1) then	--�ж���Ұ�ƶ�
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
		--MessageBox(tostring(actorinf:getAbsolutePosX()),tostring(actorinf:getAbsolutePosY()) , MB_OK);
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
Actor1:SetValue(14, 2);
Boss1 = ActorAnimationRecord:new();
Boss1:SetValue(14,3);

function DrawActorGesture(sx, sy, fr, gesturetype ,actortype)
	actortype:setRelativelyStartPos(sx,sy);
	if gesturetype == 1 then	--��������
		--if keystatus == 1 then  --1���������� 0�������ɿ�
		if fr == 1 then  --��һ֡ͼƬ		
			actortype:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*5, ActorHeight*6);						
		elseif fr == 2 then --�ڶ�֡ͼƬ
			actortype:setImagePos(ActorWidth*2, ActorWidth*3, ActorHeight*5, ActorHeight*6);
		end		
		--end
	elseif gesturetype == 2 then	--��������
		if fr == 1 then  	
			actortype:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*1, ActorHeight*2);										
		elseif fr == 2 then 		
			actortype:setImagePos(ActorWidth*2, ActorWidth*3, ActorHeight*1, ActorHeight*2);
		end		
	elseif gesturetype == 3 then	--��������
		if fr == 1 then  	
			actortype:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*2, ActorHeight*3);								
		elseif fr == 2 then 		
			actortype:setImagePos(ActorWidth*2, ActorWidth*3, ActorHeight*2, ActorHeight*3);
		end	
	elseif gesturetype == 4 then	--��������
		if fr == 1 then  	
			actortype:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*0, ActorHeight*1);				
		elseif fr == 2 then 		
			actortype:setImagePos(ActorWidth*2, ActorWidth*3, ActorHeight*0, ActorHeight*1);
		end	
	elseif gesturetype == 5 then	--����
		if fr == 1 then  	
			actortype:setImagePos(ActorWidth*0, ActorWidth*1, ActorHeight*3, ActorHeight*4);				
		elseif fr == 2 then 		
			actortype:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*3, ActorHeight*4);
		end	
	elseif 	gesturetype == 6 then	--����
		if fr == 1 then  	
			actortype:setImagePos(ActorWidth*0, ActorWidth*1, ActorHeight*4, ActorHeight*5);				
		elseif fr == 2 then 		
			actortype:setImagePos(ActorWidth*1, ActorWidth*2, ActorHeight*4, ActorHeight*5);
		end	
	end

end

function DrawBossGesture(sx, sy, fr, gesturetype ,actortype)
	actortype:setRelativelyStartPos(sx,sy);
	if gesturetype == 1 then	--��������
		if fr == 1 then  --��һ֡ͼƬ		
			actortype:setImagePos(BossWidth*0, BossWidth*1, BossHeight*2, BossHeight*3);
		elseif fr == 2 then  --�ڶ�֡ͼƬ		
			actortype:setImagePos(BossWidth*1, BossWidth*2, BossHeight*2, BossHeight*3);							
		elseif fr == 3 then --����֡ͼƬ
			actortype:setImagePos(BossWidth*2, BossWidth*3, BossHeight*2, BossHeight*3);
		end		
	elseif gesturetype == 2 then	--��������
		if fr == 1 then  --��һ֡ͼƬ		
			actortype:setImagePos(BossWidth*0, BossWidth*1, BossHeight*3, BossHeight*4);
		elseif fr == 2 then  --�ڶ�֡ͼƬ		
			actortype:setImagePos(BossWidth*1, BossWidth*2, BossHeight*3, BossHeight*4);							
		elseif fr == 3 then --����֡ͼƬ
			actortype:setImagePos(BossWidth*2, BossWidth*3, BossHeight*3, BossHeight*4);
		end		
	elseif gesturetype == 3 then	--��������
		if fr == 1 then  --��һ֡ͼƬ		
			actortype:setImagePos(BossWidth*0, BossWidth*1, BossHeight*1, BossHeight*2);
		elseif fr == 2 then  --�ڶ�֡ͼƬ		
			actortype:setImagePos(BossWidth*1, BossWidth*2, BossHeight*1, BossHeight*2);							
		elseif fr == 3 then --����֡ͼƬ
			actortype:setImagePos(BossWidth*2, BossWidth*3, BossHeight*1, BossHeight*2);
		end	
	elseif gesturetype == 4 then	--��������
		if fr == 1 then  --��һ֡ͼƬ		
			actortype:setImagePos(BossWidth*0, BossWidth*1, BossHeight*0, BossHeight*1);
		elseif fr == 2 then  --�ڶ�֡ͼƬ		
			actortype:setImagePos(BossWidth*1, BossWidth*2, BossHeight*0, BossHeight*1);							
		elseif fr == 3 then --����֡ͼƬ
			actortype:setImagePos(BossWidth*2, BossWidth*3, BossHeight*0, BossHeight*1);
		end	
	end

end







function PressingMoving()
	if movestatus == 1 then
		if BorderChecking(NowActorPosX,1) then		
			if ImpactChecking(NowActorPosX+UnitXOffset,NowActorPosY,1) then
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
			if ImpactChecking(NowActorPosX,NowActorPosY+UnitYOffset,2) then
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
		
		
		
		
			
	
	elseif movestatus == 3  then
		if BorderChecking(NowActorPosX,3) then
			if ImpactChecking(NowActorPosX-UnitXOffset,NowActorPosY,3) then
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
			
				
	
	elseif movestatus == 4  then
		if BorderChecking(NowActorPosY,4) then
			if ImpactChecking(NowActorPosX,NowActorPosY-UnitYOffset,4) then
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
						
	end
end

--1�������� 2�������� 3�������� 4��������
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
		if  CheckingYRemainder == 0 then  --�ж������Ƿ���һ��������
			if mapTable[CheckingX1][CheckingY1][3] == 1 or  0 < mapTable[CheckingX1][CheckingY1][4] and mapTable[CheckingX1][CheckingY1][4] <= BoxRandRate  then
				return false;
			elseif mapTable[CheckingX1][CheckingY1][7] == 1 and CheckingXRemainder <= UnitXOffset then	--�������δǶ����ը���� ������δ��ը��
				return false;
			elseif mapTable[CheckingX1][CheckingY1][8] <= 7 and 0 < mapTable[CheckingX1][CheckingY1][8] then
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
			if mapTable[CheckingX1][CheckingY1][3] == 1 or  0 < mapTable[CheckingX1][CheckingY1][4] and mapTable[CheckingX1][CheckingY1][4] <= BoxRandRate then
				return false;
			elseif mapTable[CheckingX1][CheckingY1][7] == 1 and CheckingYRemainder <= UnitYOffset then	--�������δǶ����ը���� ������δ��ը��
				return false;
			elseif mapTable[CheckingX1][CheckingY1][8] <= 7 and 0 < mapTable[CheckingX1][CheckingY1][8] then
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
			if mapTable[CheckingX1][CheckingY1][3] == 1 or  0 < mapTable[CheckingX1][CheckingY1][4] and mapTable[CheckingX1][CheckingY1][4] <= BoxRandRate then
				return false;
			elseif mapTable[CheckingX1][CheckingY1][7] == 1 and CheckingXRemainder >= BlockSize - UnitXOffset then	--�������δǶ����ը���� ������δ��ը��
				return false;
			elseif mapTable[CheckingX1][CheckingY1][8] <= 7 and 0 < mapTable[CheckingX1][CheckingY1][8] then
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
			if mapTable[CheckingX1][CheckingY1][3] == 1 or  0 < mapTable[CheckingX1][CheckingY1][4] and mapTable[CheckingX1][CheckingY1][4] <= BoxRandRate then
				return false;
			elseif mapTable[CheckingX1][CheckingY1][7] == 1 and CheckingYRemainder >= BlockSize-UnitYOffset then		--�������δǶ����ը���� ������δ��ը��
				return false;
			elseif mapTable[CheckingX1][CheckingY1][8] <= 7 and 0 < mapTable[CheckingX1][CheckingY1][8] then
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



function DrawBoss()
	if BossSwitchSetting then
		if ISGameNotPause  then
			Bossimg:setAbsoluteStartPos(Bossinf:getBossAbsolutePosX()+originX,Bossinf:getBossAbsolutePosY()+originY-BlockSize);
			if BossMoveDirection() == 1 then
				if WindowMoveChecking(1) then	
					DrawBossGesture(0, 0, Boss1:TimerGo(), 1, Bossimg);				
					--DrawActorGesture(0, 0, Actor1:TimerGo(), 1, Bossimg);	
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
			else 
				DrawActorGesture(0, 0, Acto1:TimerGo(), 6, actorimg);
				DrawBossGesture(0, 0, Boss1:TimerGo(), 3, Bossimg);		
			end	
		end
		Bossimg:DrawImage();	
	--DrawActorGesture(0, 0, Actor1:TimerGo(), 5, actorimg);
			
	end
	
end

	
function BossMoveDirection()
	local ActorRow1;	--������ռ��һ��λ�õĵ�ͼX����
	local ActorRow2;	--������ռ�ڶ���λ�õĵ�ͼX����
	local ActorColumn1;	--������ռ��һ��λ�õĵ�ͼY����
	local ActorColumn2;	--������ռ�ڶ���λ�õĵ�ͼY����
	local BossCouldMoveDirection;	--Boss�����ƶ��ķ���
	local ActorHaveUnitStatus;	--������ռ����״�� 1������ռһ��
	-- 2������ռˮƽ����������λ��ΪmapTable[ActorRow1][ActorColumn1]��mapTable[ActorRow1][ActorColumn2]
	-- 3������ռ��ֱ����������λ��ΪmapTable[ActorRow1][ActorColumn1]��mapTable[ActorRow2][ActorColumn1]
	local ActorPosX = actorinf:getAbsolutePosX();	--����X�������������
	local ActorPosY = actorinf:getAbsolutePosY();	--����Y�������������
	local ActorXRemain;
	local ActorYRemain;
	local BossRandDirectionNum1;
	DistanceX = ActorPosX-Bossinf:getBossAbsolutePosX();  --������Boss��ˮƽ��
	DistanceY = ActorPosY-Bossinf:getBossAbsolutePosY();   --������Boss�Ĵ�ֱ��
	BossDerterminationMove = 0;
	
	
	--�����ɫ��ռ����
	ActorXRemain = ActorPosX%BlockSize;
	ActorYRemain = ActorPosY%BlockSize;
	if ActorXRemain == 0 and ActorYRemain == 0 then
		ActorColumn1 = ActorPosX/BlockSize + 1;
		ActorRow1 = ActorPosY/BlockSize;
		ActorHaveUnitStatus = 1; 	--������ռλ��mapTable[ActorRow1][ActorColumn1]
	elseif ActorXRemain ~= 0 then
		ActorColumn1 = math.ceil(ActorPosX/BlockSize);
		ActorColumn2 = ActorColumn1+1;
		ActorRow1 = ActorPosY/BlockSize;
		ActorHaveUnitStatus = 2;  --������ռλ��mapTable[ActorRow1][ActorColumn1]��mapTable[ActorRow1][ActorColumn2]
	elseif ActorYRemain ~= 0 then
		ActorRow1 = math.ceil(ActorPosY/BlockSize);
		ActorRow2 = ActorRow1-1;
		ActorColumn1 = ActorPosX/BlockSize + 1;	--������ռλ��mapTable[ActorRow1][ActorColumn1]��mapTable[ActorRow2][ActorColumn1]
		ActorHaveUnitStatus = 3;
	end
	
	if	math.abs(DistanceX) > 50 or math.abs(DistanceY) > 50 then		
		BossCouldMoveDirection = BossImpactChecking();
		local TargetBlockX;
		local TargetBlockY;
		if ActorHaveUnitStatus == 2 then	--����ռˮƽ��������
			TargetBlockX = (ActorHaveNoIronCaculate1(ActorColumn1)-1)*BlockSize;
			TargetBlockY = ActorPosY;
			return GetBossDerterminationMove(BossCouldMoveDirection,TargetBlockX,TargetBlockY);
		elseif	ActorHaveUnitStatus == 3 then	--����ռ��ֱ��������
			TargetBlockX = ActorPosX;
			TargetBlockY = 	ActorHaveNoIronCaculate2(ActorRow1)*BlockSize;
			return GetBossDerterminationMove(BossCouldMoveDirection,TargetBlockX,TargetBlockY);
		elseif	ActorHaveUnitStatus == 1 then	--����ֻռһ��
			if ActorHOneBoxNoIronCaculate(ActorRow1,ActorColumn1) == 1 then	--����ֻ����ֱ�ƶ�	
				if Bossinf:getBossAbsolutePosX() == ActorPosX then	--Boss������X������ͬ
					TargetBlockY = ActorPosY;
					return TargetYMove(TargetBlockY);	--Boss����СY���ط����ƶ�
				elseif	BossCouldMoveDirection == 2 or BossCouldMoveDirection == 3 then --Bossֻ����ֱ�ƶ�
					if Bossinf:getBossAbsolutePosY() <= ActorPosY then
						TargetBlockY = ActorPosY-BlockSize;						
					else 
						TargetBlockY = ActorPosY+BlockSize;
					end	
					return TargetYMove(TargetBlockY);	--Boss����СY���ط����ƶ�
			elseif BossCouldMoveDirection == 0 or BossCouldMoveDirection == 1 then	--Boss����ˮƽ�ƶ�
					TargetBlockX = ActorPosX;
					return TargetXMove(TargetBlockX);
				end
			elseif	ActorHOneBoxNoIronCaculate(ActorRow1,ActorColumn1) == 2 then --����ֻ��ˮƽ�ƶ�	
				if Bossinf:getBossAbsolutePosY() == ActorPosY then	--Boss������Y������ͬ
					TargetBlockX = ActorPosX;
					return TargetXMove(TargetBlockX);	--Boss����СX���ط����ƶ�
				elseif	BossCouldMoveDirection == 1 then --Bossֻ��ˮƽ�ƶ�
					if Bossinf:getBossAbsolutePosX() <= ActorPosX then
						TargetBlockX = ActorPosX - BlockSize;
					else	
						TargetBlockX = ActorPosX + BlockSize;
					end
					return TargetXMove(TargetBlockX);	--Boss����СX���ط����ƶ�
				elseif BossCouldMoveDirection == 0 or BossCouldMoveDirection == 2 or BossCouldMoveDirection == 3 then	--Boss������ֱ�ƶ�
					TargetBlockY = ActorPosY;
					return TargetYMove(TargetBlockY);
				end
			elseif	ActorHOneBoxNoIronCaculate(ActorRow1,ActorColumn1) == 3 then --����������ƶ�
				if BossCouldMoveDirection == 1 then	--Bossֻ��ˮƽ�ƶ�
					TargetBlockX = ActorPosX;
					return TargetXMove(TargetBlockX);
				elseif	BossCouldMoveDirection == 2 or BossCouldMoveDirection == 3 then --Bossֻ����ֱ�ƶ�
					TargetBlockY = ActorPosY ;
					return TargetYMove(TargetBlockY);
				else --Boss��ˮƽ������ֱ�����ƶ��Կ�
					if Bossinf:getBossAbsolutePosX() == ActorPosX then
						TargetBlockY = ActorPosY;
						return TargetYMove(TargetBlockY);
					elseif	Bossinf:getBossAbsolutePosY() == ActorPosY then
						TargetBlockX = ActorPosX;
						return TargetXMove(TargetBlockX);
					else	
						BossRandDirectionNum1 = math.random(1,2);	--1��ˮƽ�����ƶ� --2����ֱ�����ƶ�
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
		
	else  return 0;	 
	end
	
end	

function ActorHOneBoxNoIronCaculate(ActorRow,ActorColumn)
	if ActorRow % 2 == 0 and ActorColumn % 2 ~= 0 then  --��Ϊż������Ϊ����������ֻ����ֱ�ƶ�		
		return 1;
	elseif	ActorRow % 2 ~= 0 and ActorColumn % 2 == 0 then  --��Ϊ��������Ϊż��������ֻ��ˮƽ�ƶ�	
		return 2;
	else return 3; --����������ƶ�
	end
end


function GetBossDerterminationMove(BossCouldMoveDirection,TargetBlockX,TargetBlockY)
	local BossRandDirectionNum2;
	if BossCouldMoveDirection == 1 then --Bossֻ��ˮƽ�ƶ�
		BossDerterminationMove = TargetXMove(TargetBlockX);
	elseif	BossCouldMoveDirection == 2 then --Bossֻ����ֱ�ƶ�
		BossDerterminationMove = TargetYMove(TargetBlockY);
	elseif	BossCouldMoveDirection == 3 then --Bossֻ����ֱ�����ƶ�	
		BossDerterminationMove = 4;
	else	--Boss���Գ�Ŀ�������ٵ����������ƶ�
		if Bossinf:getBossAbsolutePosX() == TargetBlockX then
			BossDerterminationMove =  TargetYMove(TargetBlockY);
		elseif	Bossinf:getBossAbsolutePosY() == TargetBlockY then
			BossDerterminationMove =  TargetXMove(TargetBlockX);
		else	
			BossRandDirectionNum2 = math.random(1,2);	--1��ˮƽ�����ƶ� --2����ֱ�����ƶ�
			if BossRandDirectionNum2 == 1 then
				BossDerterminationMove = TargetXMove(TargetBlockX);
			else	
				BossDerterminationMove =  TargetYMove(TargetBlockY);
			end			
		end
					
					
		--[[BossRandDirectionNum2 = math.random(1,2);	--1��ˮƽ�����ƶ� --2����ֱ�����ƶ�
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
		return 3;  --Boss��������
	else
		return 1; -- Boss��������
	end				
end

function TargetYMove(TargetBlockY)
	if Bossinf:getBossAbsolutePosY() > TargetBlockY  then
		return 4; --Boss��������
	else	
		return 2; --Boss��������
	end			
end



function ActorHaveNoIronCaculate1(ActorColumn)	--��ɫ�еķ���
	if ActorColumn % 2 == 0 then  --����ռˮƽ����ǰһ��Ϊż��������������ǽ��������ǽ��Ϊ����һ�񣨺�һ�У�
			--mapTable[ActorRow1][ActorColumn2]
		return ActorColumn+1
	else	--����ռˮƽ����ǰһ��Ϊ����������������ǽ
		return ActorColumn;
	end
end

function ActorHaveNoIronCaculate2(ActorRow)	--��ɫ�еķ���
	if ActorRow % 2 == 0 then  --����ռ��ֱ��������һ��Ϊż��������������ǽ��������ǽ��Ϊ����һ��
			--mapTable[ActorRow1][ActorColumn2]
		return ActorRow-1;
	else	--����ռ��ֱ��������һ��Ϊ����������������ǽ
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
	--0���������ˮƽ����ֱ�����ƶ� 1����ֻ��ˮƽ�ƶ� 2����ֻ����ֱ�ƶ� 3����ֻ����ֱ�����ƶ� 
	if BossLastX ~= 0 then
		return 1;
	elseif BossLastY ~= 0 then
		return 2;
	else 								--Bossֻռһ������
		BossCheckingLine = BossPosX/BlockSize;
		BossCheckingRow = BossPosY/BlockSize;
		if 	BossCheckingLine == 0 then 
			if mapTable[BossCheckingRow][BossCheckingLine+2][3] == 1 then	--Bossλ�������	
				return 2;
			else return 0;
			end
		elseif 	BossCheckingRow == TotalRows then --Bossλ�����ϱ�
			return 3;
		elseif 	mapTable[BossCheckingRow][BossCheckingLine][3] == 1 then  --���Boss����Ƿ�����ǽ 
			return 2;
		elseif	 mapTable[BossCheckingRow+1][BossCheckingLine+1][3] == 1 then  --���Boss�ϱ��Ƿ�����ǽ	
			return 1;
		else 
			return 0;
		end

	end

end	
	
	
	
	
function ExitButtonEvent(Num, ButtonClass, GoFunc)
	ExitNotReSetButton(Num);
	ExitResult = GetMouseStatus();
	if ExitResult == MouseHover then --��������ͣ
		if ButtonClass["Hover"] == 0 then
			ButtonClass["Hover"] = 1;
			StartViewButtonSe:Play();
		end
		ButtonClass:setImagePos(ExitButtonWidth, ExitButtonWidth*2, ExitButtonHeight*(Num-1), ExitButtonHeight*Num);
	elseif ExitResult == MouseLeftDown then --����������
		ButtonClass:setImagePos(ExitButtonWidth*2, ExitButtonWidth*3, ExitButtonHeight*(Num-1), ExitButtonHeight*Num);
		ButtonClass["Event"] = 1;
	elseif ExitResult == MouseLeftUp then --�������ɿ�
		ButtonClass:setImagePos(0, ExitButtonWidth, ExitButtonHeight*(Num-1), ExitButtonHeight*Num);
		if ButtonClass["Event"] == 1 then
			ButtonClass["Event"] = 0;
			Gamebgm:Play(ForcedSwitch);--ǿ���л���������
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
	goStartView();
end	

function CancelBack()
	ISGameNotPause = true;
end	




function IintMapData()
	initParams(24,40,1,math.random(30,40),0,550,true); --��ʼ����ͼ����	
	ISGameNotPause = true;	--�ж���Ϸ�Ƿ�û����ͣ
	GroundTypeRandNum = math.random(1,5); --�ر����
	EnemyInit()
	ground:setImage(0, 0, BlockSize, BlockSize, 200*(GroundTypeRandNum - 1), 200*GroundTypeRandNum, 0, 100, 11.0);
end



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
		ImageLoad:LoadImage(PlotV,"Image/Map/BackgroundColor4.png","DrawDialog()", "Image_4");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 26 then
		ImageLoad:LoadImage(PlotV,"Image/Map/ExitButtons.png","DrawButtons()", "Image_5");
		NowLoadPos = NowLoadPos + 1;	
	elseif NowLoadPos == 27 then
		ImageLoad:LoadImage(PlotV,"Image/Bomb/Bomb.png","DrawBomb()", "Image_6");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 28 then
		ImageLoad:LoadImage(PlotV,"Image/Bomb/Blaze.png","DrawBlaze()", "Image_7");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 29 then
		ImageLoad:LoadImage(PlotV,"Image/Bomb/Dynamite.png","DrawDynamite()", "Image_8");
		NowLoadPos = NowLoadPos + 1;
	elseif NowLoadPos == 30 then
		ImageLoad:LoadImage(PlotV,"Image/Enemy.png","DrawEnemy()", "Image_9");
		NowLoadPos = NowLoadPos + 1;
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
		if(mapTable[BombY/BlockSize + 1][BombX/BlockSize + 1][7] ~= 1) then
			while(i <= UserData["HaveBombNumber"]) do
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
					break
				end
				i = i + 1
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
					for k = 1,6 do 
						if BombBlaze[k]["IsWrite"] == 0 then
							BombBlaze[k]:Init(UserBomb[j]["Bomb"]["StartX"],UserBomb[j]["Bomb"]["StartY"])
							BombBlaze[k]["IsWrite"] = 1
							TestBlazeImpact(k)
							break
						end
					end
					break
				end
			end
		end
		--[[local BombX = 0
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
		while(i <= UserData["HaveBombNumber"]) do
			if(UserBomb[i]["IsWrite"] == 0) then
				UserBomb[i]:Init(BombX,BombY)
				UserBomb[i]["IsWrite"] = 1
				mapTable[BombY/BlockSize + 1][BombX/BlockSize + 1][7] = 1
				break
			end
			i = i + 1
		end
		--]]
	end
	
	if ISGameNotPause == false then
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
end	

function GetBuff(i)
	if i == 1 and UserData["Power"] < 9 then
		UserData["Power"] = UserData["Power"] + 1
	elseif i == 2 and UserData["HaveBombNumber"] <6 then
		UserData["HaveBombNumber"] = UserData["HaveBombNumber"] + 1
	elseif i == 3 and UserData["SpeedX"] <4 and UserData["SpeedY"] < 4 then
		UserData["SpeedX"] = UserData["SpeedX"] + 1
		UserData["SpeedY"] = UserData["SpeedY"] + 1
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