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
	actorimg:setImage(0, 560, BlockSize-2, BlockSize-2, 0, 208, 0, 184, 9.0);
	
	
	
	
	--WindowActorX = TotalRows*BlockSize;
	UnitXOffset = 5;
	UnitYOffset = 5;				
    
	originX=0;
	originY=-(TotalRows-12)*BlockSize;
	actorWindowPosX = AcStPosX+originX;
	actorWindowPosY = AcStPosY+originY;
end

	BlockSize = 50;

	
	initParams(24,40,1,0,0,550,200);
	movestatus = 0;
--	TenOffset = 0;
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
	if(movestatus == 0) then
		--actor:setImage(500, 500, BlockSize, BlockSize, 0, 208, 0, 184, 9.0);
	end
	if movestatus == 1 and actorinf:getAbsolutePosX()+48 < TotalWidthPixels then		
		if ImpactChecking(actorinf:getAbsolutePosX()+48+UnitXOffset,actorinf:getAbsolutePosY(),1) then
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
	if movestatus == 2 and actorinf:getAbsolutePosY() < TotalHeightPixels then
		if originY>-BlockSize*(TotalRows-12) and actorinf:getWindowPosY()>=9*BlockSize then
			originY=originY-UnitYOffset;
			actorimg:setRelativelyStartPos(0,0);
			actorinf:setRelativePos(0,UnitYOffset);	
		else 
			actorimg:setRelativelyStartPos(0,UnitYOffset);	
			actorinf:moveTOALL(0,UnitYOffset);		
		end		
	end
	if movestatus == 3 and actorinf:getAbsolutePosX() > 0 then
		if originX<0 and actorinf:getWindowPosX()<=3*BlockSize then
			originX=originX+UnitXOffset;
			actorimg:setRelativelyStartPos(0,0);
			actorinf:setRelativePos(-UnitXOffset,0);		
		else 
			actorimg:setRelativelyStartPos(-UnitXOffset,0);
			actorinf:moveTOALL(-UnitXOffset,0);
		end			
	end
	if movestatus == 4 and actorinf:getAbsolutePosY()-48 > 0 then
		if originY<0 and actorinf:getWindowPosY()<=4*BlockSize then
			originY=originY+UnitYOffset;
			actorimg:setRelativelyStartPos(0,0);
			actorinf:setRelativePos(0,-UnitYOffset);	
		else	
			actorimg:setRelativelyStartPos(0,-UnitYOffset);
			actorinf:moveTOALL(0,-UnitXOffset);	
		end			
	end
	actorimg:DrawImage();
end
	
function ImpactChecking(CheckingPosX,CheckingPosY,Direction)
	
	
	local CheckingX1;
	local CheckingY1;
	local CheckingX2;
	local CheckingY2;
	if Direction == 1 then
		--[[if 48 <= CheckingPosX % BlockSize <= 50 then  --�ж��Ƿ�϶�������ײ
			return true;
		end--]]
		CheckingX1 = math.ceil(CheckingPosY/BlockSize);
		CheckingY1 = math.ceil(CheckingPosX/BlockSize);
		CheckingRemainder = CheckingPosY % BlockSize;
		if  48 <= CheckingRemainder or CheckingRemainder < 50 or CheckingRemainder-50 == 0 then  --�ж������Ƿ���һ��������
			if mapTable[CheckingX1][CheckingY1][3] == 1 or  mapTable[CheckingX1][CheckingY1][4] == 1 then
				return false;
			else return true;			
			end					
		else 
			CheckingY2 = CheckingY1-1;
			if mapTable[CheckingX1][CheckingY1][3] == 1 or mapTable[CheckingX1][CheckingY1][4] == 1
			or mapTable[CheckingX1][CheckingY2][3] == 1 or mapTable[CheckingX1][CheckingY2][4] == 1 then
				return false;
			else return true;
			end
		end	
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
	
	
end	
	
	
function LoadMapViewImageFile()
	ground:LoadImage("Image/ground.jpg","DrawGround()", "Image_0");
	BrickWall:LoadImage("Image/brick.png","DrawMap()", "Image_1");
	actorimg:LoadImage("Image/actor.png","DrawActor()", "Image_2");
	
end



function ActorKey()
	
	local KeyResult_right = KeyDetect(Right);
	local KeyResult_Up = KeyDetect(Up);
	local KeyResult_Left = KeyDetect(Left);
	local KeyResult_Down = KeyDetect(Down);
	if KeyResult_right == KeepPressing then
		movestatus = 1;
	elseif KeyResult_Up == KeepPressing then
		movestatus = 2;
	elseif KeyResult_Left == KeepPressing then
		movestatus = 3;
	elseif KeyResult_Down == KeepPressing then
		movestatus = 4;
	else
		movestatus = 0;
	end
	
end	

