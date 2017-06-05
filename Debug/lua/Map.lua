--s行n列矩阵 maptype：地图类型 groundtype：地表类型 角色初始位置X,Y 相对与角色的视野位置
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
	
	
	--可丢掷炸弹数量
	local BombNumAva = 1;
	--炸弹火力
	local FireLevel = 1;
	--block = {posX,posY,brick=nil,wall=nil}; --0为无，1为存在
	--brick = 砖；wall = 墙 
	mapTable = {};
--	mapWindowTable = {};
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

-- 0<UnitXOffset<BlockSize:地图左移动，人物右移
-- -BlockSize<UnitXOffset<0:地图右移动，人物左移
-- 0<UnitYOffset<BlockSize:地图上移动，人物下移
-- -BlockSize<UnitYOffset<0:地图下移动，人物上移
-- UnitXOffset=0：地图水平未移动
-- UnitYOffset=0：地图竖直未移动


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

--1代表向右 2代表向上 3代表向左 4代表向下
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
		--[[if 48 <= CheckingPosX % BlockSize <= 50 then  --判断是否肯定不会碰撞
			return true;
		end--]]
		CheckingX1 = math.ceil(CheckingPosY/BlockSize);
		CheckingY1 = math.ceil(CheckingPosX/BlockSize);
		CheckingRemainder = CheckingPosY % BlockSize;
		if  48 <= CheckingRemainder or CheckingRemainder < 50 or CheckingRemainder-50 == 0 then  --判断人物是否在一个方格内
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

