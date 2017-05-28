--s行n列矩阵
function initParams(s,n,maptype,groundtype)
	
	--[[vec{};--]]
	
	local i ;
	local j;
	local temp;
	--block = {posX,posY,brick=nil,wall=nil}; --0为无，1为存在
	--brick = 砖；wall = 墙 
	mapTable = {};
	math.randomseed(os.time()); --设置时间种子
	
	--mapTable[i][j][k]	i,j代表行数，列数，
	--mapTable[i][j][1]代表位置X，mapTable[i][j][2]代表位置Y，
	--mapTable[i][j][3]代表砖，mapTable[i][j][4]代表墙，0为无，1为存在

	if maptype == 1 then
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
				else
					mapTable[i][j][3] = 0;				
				end	
				mapTable[i][j][4] = math.random(0,5);
			end
		end
	end
	if maptype == 2 then
		for i=1,s do
		mapTable[i] = {};
		
		for j=1,n do
			mapTable[i][j] = {};
			mapTable[i][j][1] = i;
			mapTable[i][j][2] = j;
			mapTable[i][j][3] = math.random(0,20);	
			if(mapTable[i][j][3] == 0)	then
			mapTable[i][j][4] = 0;
			else mapTable[i][j][4] = math.random(0,2);
			end
		
		end
	end
	end
	
	
	
	
					
    
end
	initParams(12,20,1,0);
	movestatus = 0;
	BrickWall = ImageClass:new();
	BrickWall:setImageFileSize(503, 252);
	BrickWall:setImage(0, 0, 50, 50, 0, 161, 0, 161, 10.0);
	
	ground = ImageClass:new();
	ground:setImageFileSize(1024, 1024);
	ground:setImage(0, 0, 50, 50, 0, 1024, 0, 1024, 11.0);
	
	actor = ImageClass:new();
	actor:setImageFileSize(208, 184);
	actor:setImage(0, 0, 50, 50, 0, 208, 0, 184, 9.0);
	
	
	
	
function DrawGround()
	x=0;
	y=0;
	for i=1,12,1 do
		for j=1,20,1 do
			ground:setImage(x, y, 50, 50, 0, 500, 0, 500, 11.0);
			ground:DrawImage();
			x=x+50;		
		end
		x=0;
		y=y+50;
	end
end

function DrawMap()
	x=0;
	y=0;	
	--Map:DrawImage();
	
	for i=1,12,1 do
--		vec{i} = {};
		for j=1,20,1 do
			if mapTable[i][j][3] == 1 then
				BrickWall:setImage(x, y, 50, 50, 0, 50, 0, 50, 10.0);
				BrickWall:DrawImage();								
			end
			if mapTable[i][j][4] == 1 then
				BrickWall:setImage(x, y, 50, 50, 251, 503, 0, 252, 10.0);
				BrickWall:DrawImage();								
			end
			x=x+50;				
		end	
		x=0;
		y=y+50;	
	end
	
end

--1代表向右 2代表向上 3代表向左 4代表向右
function DrawActor()
	if(movestatus == 0) then
		--actor:setImage(500, 500, 50, 50, 0, 208, 0, 184, 9.0);
	end
	if(movestatus == 1) then
		actor:setRelativelyStartPos(2,0);
	end
	if(movestatus == 2) then
		actor:setRelativelyStartPos(0,2);
	end
	if(movestatus == 3) then
		actor:setRelativelyStartPos(-2,0);
	end
	if(movestatus == 4) then
		actor:setRelativelyStartPos(0,-2);
	end
	actor:DrawImage();
end
	



function LoadMapViewImageFile()
	ground:LoadImage("Image/ground.png","DrawGround()", "Image_0");
	BrickWall:LoadImage("Image/brick.png","DrawMap()", "Image_1");
	actor:LoadImage("Image/actor.png","DrawActor()", "Image_2");
	
end



function ActorKey()
	
	local KeyResult_right = KeyDetect(Right);
	local KeyResult_Up = KeyDetect(Up);
	local KeyResult_Left = KeyDetect(Left);
	local KeyResult_Down = KeyDetect(Down);
	if KeyResult_right == Press then
		movestatus = 1;
	end
	if KeyResult_right == Release then
		movestatus = 0;
	end
	if KeyResult_Up == Press then
		movestatus = 2;
	end
	if KeyResult_Up == Release then
		movestatus = 0;
	end
	--[[if KeyResult_Left == Press then
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
	--[[Result = 0;
	if Result == 0 then 
		if ShopBackGround["Event"] == 1 then
			
		end
	elseif Result == MouseLeftUp then
		ShopBackGround["Event"] = 1;
	end--]]
end	

