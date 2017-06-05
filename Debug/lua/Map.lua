--s��n�о��� maptype����ͼ���� groundtype���ر����� ��ɫ��ʼλ��X,Y ������ɫ����Ұλ��
function initParams(s,n,maptype,groundtype,AcStPosX,AcStPosY,RelativeWindowPos)
	
	--[[vec{};--]]
	
	local i ;
	local j;
	local temp;
		
    firstsettemp = 1;
	
	TotalRows = s;
	TotalLines = n;
	
	TotalWidthPixels = n*BlockSize;
	TotalHeightPixels = s*BlockSize;
	
	
	--�ɶ���ը������
	local BombNumAva = 1;
	--ը������
	local FireLevel = 1;
	--block = {posX,posY,brick=nil,wall=nil}; --0Ϊ�ޣ�1Ϊ����
	--brick = ש��wall = ǽ 
	mapTable = {};
--	mapWindowTable = {};
	math.randomseed(os.time()); --����ʱ������
	
	--mapTable[i][j][k]	i,j����������������
	--mapTable[i][j][1]����λ��X��mapTable[i][j][2]����λ��Y��
	--mapTable[i][j][3]����ש��mapTable[i][j][4]����ǽ��0Ϊ�ޣ�1Ϊ����

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
			else mapTable[i][j][4] = math.random(0,2);
			end
		
		end
	end
	end
	
	mapTable[s][1][4] = 0;
	mapTable[s-1][1][4] = 0;
	mapTable[s-1][2][4] = 0;
	mapTable[s-2][1][4] = 0;	
	
	--�����ɫ״̬
	actorBlock ={AcStPosX,AcStPosY,BombNumAva,FireLevel};
	
	actorinf = ActorClass:new(1,1);
--	actorinf:setAbsolutePos
	
	
	actorimg = ImageClass:new();
	actorimg:setImageFileSize(208, 184);
	--actorimg:setImage(0, 555, BlockSize-5, BlockSize-5, 0, 208, 0, 184, 9.0);
	actorimg:setImage(0, 550, BlockSize, BlockSize, 0, 208, 0, 184, 9.0);
	
	
	
	--WindowActorX = TotalRows*BlockSize;
	UnitXOffset = 5;
	UnitYOffset = 5;				
    
	originX=0;
	originY=-(TotalRows-12)*BlockSize;
	actorWindowPosX = AcStPosX+originX;
	actorWindowPosY = AcStPosY+originY;
end

	BlockSize = 50;

	
	initParams(24,40,2,0,0,550,200);
	movestatus = 0;
	releasestatus = 0;
	BrickWall = ImageClass:new();
	BrickWall:setImageFileSize(503, 252);
	BrickWall:setImage(0, 0, BlockSize, BlockSize, 0, 161, 0, 161, 10.0);
	
	ground = ImageClass:new();
	ground:setImageFileSize(1024, 1024);
	ground:setImage(0, 0, BlockSize, BlockSize, 0, 1024, 0, 1024, 11.0);
	
	
	
	
	
	
	
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

-- 0<UnitXOffset<BlockSize:��ͼ���ƶ�����������
-- -BlockSize<UnitXOffset<0:��ͼ���ƶ�����������
-- 0<UnitYOffset<BlockSize:��ͼ���ƶ�����������
-- -BlockSize<UnitYOffset<0:��ͼ���ƶ�����������
-- UnitXOffset=0����ͼˮƽδ�ƶ�
-- UnitYOffset=0����ͼ��ֱδ�ƶ�


--



function DrawMap()	
	x = originX;
	y = originY;
	for i=1,TotalRows,1 do		
		for j=1,TotalLines,1 do
				if mapTable[i][j][3] == 1 then							
					BrickWall:setImagePos( 0, 251, 0, 252);	
					BrickWall:setAbsoluteStartPos(x,y);															
					BrickWall:DrawImage();				
				end												
				if mapTable[i][j][4] == 1 then						
					BrickWall:setImagePos( 253, 501, 0, 252);
					BrickWall:setAbsoluteStartPos(x,y);							
					BrickWall:DrawImage();								
				end		
				x=x+BlockSize;			
			end	
		x=originX;
		y=y+BlockSize;	
	end			
end

--1�������� 2�������� 3�������� 4��������
function DrawActor()
	NowActorPosX = actorinf:getAbsolutePosX();
	NowActorPosY = actorinf:getAbsolutePosY();
	NeedISRevise = false;
	
	if releasestatus == 1 then
	
		
	end
	if releasestatus == 2 then
		RemainNum = (NowActorPosY)%BlockSize;
		if 20 <= RemainNum  then
			NeedISRevise = true;
		else NeedISRevise = false;		
		end
		if originY>-BlockSize*(TotalRows-12) and actorinf:getWindowPosY()>=9*BlockSize then
			if NeedISRevise then
					originY=originY-(BlockSize-RemainNum);
					actorinf:setRelativePos(0,BlockSize-RemainNum);
					actorimg:setRelativelyStartPos(0,0);
			end		
		else 
			if NeedISRevise then
					actorimg:setRelativelyStartPos(0,50-RemainNum);	
					actorinf:moveTOALL(0,50-RemainNum);					
			end				
		end		
					
	end			
	
	--[[if(movestatus == 0) then
				
	end--]]
	
	
	
	
	
	
	
	if movestatus == 1 and NowActorPosX+50 < TotalWidthPixels then		
		if ImpactChecking(NowActorPosX+UnitXOffset,NowActorPosY,1) then
			if originX>-BlockSize*(TotalLines-20) and actorinf:getWindowPosX()>=16*BlockSize then
				originX=originX-UnitXOffset;
				actorimg:setRelativelyStartPos(0,0);
				actorinf:setRelativePos(UnitXOffset,0);			
			else 
				actorimg:setRelativelyStartPos(UnitXOffset,0);	
				actorinf:moveTOALL(UnitXOffset,0);
			end						
		end			
			
	end
	if movestatus == 2 and NowActorPosY < TotalHeightPixels then
		if ImpactChecking(NowActorPosX,NowActorPosY+UnitYOffset,2) then
			if originY>-BlockSize*(TotalRows-12) and actorinf:getWindowPosY()>=9*BlockSize then
				originY=originY-UnitYOffset;
				actorimg:setRelativelyStartPos(0,0);	
				actorinf:setRelativePos(0,UnitYOffset);	
			else
				actorimg:setRelativelyStartPos(0,UnitYOffset);	
				actorinf:moveTOALL(0,UnitYOffset);	
			end
		end
		
			
	end
	if movestatus == 3 and NowActorPosX > 0 then
		if ImpactChecking(NowActorPosX-UnitXOffset,NowActorPosY,3) then
			if originX<0 and actorinf:getWindowPosX()<=3*BlockSize then
				originX=originX+UnitXOffset;
				actorimg:setRelativelyStartPos(0,0);
				actorinf:setRelativePos(-UnitXOffset,0);		
			else 
				actorimg:setRelativelyStartPos(-UnitXOffset,0);
				actorinf:moveTOALL(-UnitXOffset,0);
			end	
		end
				
	end
	if movestatus == 4 and NowActorPosY-50 > 0 then
		if ImpactChecking(NowActorPosX,NowActorPosY-UnitYOffset,4) then
			if originY<0 and actorinf:getWindowPosY()<=4*BlockSize then
				originY=originY+UnitYOffset;
				actorimg:setRelativelyStartPos(0,0);
				actorinf:setRelativePos(0,-UnitYOffset);	
			else	
				actorimg:setRelativelyStartPos(0,-UnitYOffset);
				actorinf:moveTOALL(0,-UnitYOffset);	
			end	
		end				
	end
	actorimg:DrawImage();
end
	
function ImpactChecking(CheckingPosX,CheckingPosY,Direction)
	
	--[[if CheckingPosX <= 0  or  CheckingPosX >= TotalWidthPixels 
	or CheckingPosY <=0 or CheckingPosY >= TotalHeightPixels then
		return false;
	end--]]
	
	local CheckingX1;
	local CheckingY1;
	local CheckingX2;
	local CheckingY2;
	local CheckingXRemainder;
	local CheckingYRemainder;
	if Direction == 1 then
		CheckingPosX = CheckingPosX+50;
		CheckingXRemainder = CheckingPosX % BlockSize;
		--[[if (45 <= CheckingXRemainder and CheckingXRemainder < 50) or CheckingXRemainder == 0 then  --�ж��Ƿ�϶�������ײ
			return true;
		end--]]
		CheckingX1 = math.ceil(CheckingPosY/BlockSize);
		CheckingY1 = math.ceil(CheckingPosX/BlockSize);
		CheckingYRemainder = CheckingPosY % BlockSize;
		if  --[[(45 <= CheckingYRemainder and CheckingYRemainder < 50) or --]]CheckingYRemainder == 0 then  --�ж������Ƿ���һ��������
			if mapTable[CheckingX1][CheckingY1][3] == 1 or  mapTable[CheckingX1][CheckingY1][4] == 1 then
				return false;
			else return true;			
			end	
			return true;				
		else 
			--return false;
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
		
	
	end
		
		
		
		
		
		--[[CheckingXRemainder = CheckingPosX % BlockSize;
		
		if CheckingXRemainder == 0
		
		
		
	end--]]
	--[[elseif Direction == 2 then
		CheckingX1 = math.ceil(CheckingPosX/BlockSize)+1;
		CheckingY1 = math.ceil(CheckingPosY/BlockSize)+1;
	elseif Direction == 3 then
		CheckingX1 = math.ceil(CheckingPosX/BlockSize);
		CheckingY1 = math.ceil(CheckingPosY/BlockSize)+1;
	elseif Direction == 4 then
		CheckingX1 = math.ceil(CheckingPosX/BlockSize)+1;
		CheckingY1 = math.ceil(CheckingPosY/BlockSize);--]]
end	
	
	--[[if mapTable[CheckingX1][CheckingY1][3] == 1 or mapTable[CheckingX1][CheckingY1][4] == 1 then
		return false;
	else return true;	
	end--]]
	
	--[[return true;
end	--]]
	
	
function LoadMapViewImageFile()
	ground:LoadImage("Image/ground3.png","DrawGround()", "Image_0");
	BrickWall:LoadImage("Image/brick4.jpg","DrawMap()", "Image_1");
	actorimg:LoadImage("Image/actor.png","DrawActor()", "Image_2");
	
end


function ActorKeyFluidRelease()
	local KeyResult_right = KeyDetect(Right);
	local KeyResult_Up = KeyDetect(Up);
	local KeyResult_Left = KeyDetect(Left);
	local KeyResult_Down = KeyDetect(Down);	
	
	if KeyResult_right == Release then
		releasestatus = 1;
	elseif KeyResult_Up == Release then
		releasestatus = 2;
	elseif KeyResult_Left == Release then
		releasestatus = 3;
	elseif KeyResult_Down == Release then
		releasestatus = 4;
	else
		releasestatus = 0;
	end
	
end



function ActorKey()
	
	local KeyResult_right = KeyDetect(Right);
	local KeyResult_Up = KeyDetect(Up);
	local KeyResult_Left = KeyDetect(Left);
	local KeyResult_Down = KeyDetect(Down);
	if KeyResult_right == KeepPressing then
		movestatus = 1;
	--[[elseif KeyResult_right == Release then
		releasestatus = 1;--]]
	--[[elseif KeyResult_Up == KeepPressing then
		movestatus = 2;--]]
	elseif KeyResult_Up == Release then
		movestatus = 2;--releasestatus = 2;
	elseif KeyResult_Left == KeepPressing then
		movestatus = 3;
	elseif KeyResult_Down == KeepPressing then
		movestatus = 4;
	else
		movestatus = 0;
	end
	
	--[[if KeyResult_right == Press then
		movestatus = 1;
	end
	if KeyResult_right == Release then
		movestatus = 0;
	end
	
	if KeyResult_Left == Press then
		movestatus = 3;
	end
	if KeyResult_Left == Release then
		movestatus = 0;
	end
	if KeyResult_Down == Press then
		movestatus = 4;
	end
	if KeyResult_Down == Release then
		movestatus = 0;
	end--]]
	
end	

